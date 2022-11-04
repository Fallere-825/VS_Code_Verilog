`timescale 1ns/1ps

/* 输入 并行8位数据 转 并行64位数据 输出 模块 */

module data_out_8_to_64 (output reg [63:0] data_64, // 输出64位并行数据
                         output reg transmit_done,
                         input wire clk,              // 系统时钟
                         input wire rst_n,            // 复位信号，低电平有效
                         input wire [7:0] data_8,     // 输入8位并行数据
                         input wire data_out_enable); // 读入下一组8位数据使能信号

/* 定义寄存器 */
reg [7:0] data_1;      // 输出数据寄存器
reg [63:0] data;       // 输出数据寄存器
reg [3:0] state;       // 输入数据组数计数器
reg data_out_enable_1; // 用于判断是否读入下一组8位数据的寄存器

/* 定义线网 */
wire start_flag; // 开始读入下一组8位数据数据标志

// start_flag用于检测接收到的【读入下一组8位数据使能信号】上升沿，即检测【rx数据接收完成】标志
// rx接收完一组8位数据并输出之后，本模块读入该组数据并寄存
assign start_flag = (~data_out_enable_1) & data_out_enable;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out_enable_1 <= 1'b0;
    end
    else begin
        data_out_enable_1 <= data_out_enable;
    end
end

/* always @(posedge clk or negedge rst_n) begin
 if (!rst_n) begin
 data_1 <= 8'd0;
 end
 else begin
 data_1 <= data_8;
 end
 end */

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= 4'd8;
    end
    else begin
        if (start_flag) begin
            data_1 <= data_8;
            if (state > 4'd6) begin
                state <= 4'd0;
            end
            else begin
                state <= state +1'b1;
            end
        end
        else begin
            state <= state;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data <= 64'd0;
    end
    else begin
        // if (start_flag) begin
        case (state)
            4'd0:
            data[7:0] <= data_1;
            4'd1:
            data[15:8] <= data_1;
            4'd2:
            data[23:16] <= data_1;
            4'd3:
            data[31:24] <= data_1;
            4'd4:
            data[39:32] <= data_1;
            4'd5:
            data[47:40] <= data_1;
            4'd6:
            data[55:48] <= data_1;
            4'd7:
            data[63:56] <= data_1;
            default:
            data <= data;
        endcase
        // end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        transmit_done <= 0;
    end
    else if (/* (*/    state == 4'd7       /*) && start_flag */) begin // 接收完起始位 + 8 bit数据 + 停止位
        transmit_done <= 1;                                            // 输出寄存器rx_data中接收到的新的8 bit数据
    end
    else begin
        transmit_done <= 0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_64 <= 8'd0;
    end
    else if (transmit_done == 1) begin // 接收完起始位 + 8 bit数据 + 停止位
        data_64 <= data;               // 输出寄存器rx_data中接收到的新的8 bit数据
    end
    else begin
        data_64 <= data_64;
    end
end

endmodule // data_out_8_to_64

