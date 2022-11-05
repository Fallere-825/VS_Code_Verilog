`timescale 1ns/1ps

/* 输入 并行8位数据 转 并行64位数据 输出 模块 */

module data_out_8_to_64 (output reg [63:0] data_64,   // 输出64位并行数据
                         output reg data_out_done,    // 全部64位数据传输完成标志
                         input wire clk,              // 系统时钟
                         input wire rst_n,            // 复位信号，低电平有效
                         input wire [7:0] data_8,     // 输入8位并行数据
                         input wire data_out_enable); // 读入下一组8位数据使能信号

/* 定义寄存器 */
reg [7:0] data_in;     // 输入数据寄存器
reg [63:0] data_out;   // 输出数据寄存器
reg [3:0] state;       // 输入数据组数计数器
reg data_out_enable_1; // 用于判断是否读入下一组8位数据的寄存器

/* 定义线网 */
wire start_flag; // 开始读入下一组8位数据标志

// start_flag用于检测接收到的【读入下一组8位数据使能信号】的上升沿，即检测【rx数据接收完成标志】
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

/* 输入数据组数计数与输入数据寄存 */
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state   <= 4'd8;
        data_in <= 8'd0;
    end
    else if (start_flag) begin  // 可以读入下一组数据
        data_in <= data_8;      // 读入下一组数据
        if (state > 4'd6) begin // 已经读入了最后一组数据
            state <= 4'd0;      // 循环，把读入的数据当做第一组数据
        end
        else begin
            state <= state + 1'b1; // 当前读入的组数加1
        end
    end
    else begin // 还没有到可以读入下一组数据的时刻
        state   <= state;
        data_in <= data_in;
    end
end

/* 将读入的8位数据寄存到64位寄存器中 */
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out <= 64'd0;
    end
    else begin
        case (state) // 根据输入数据组数计数器判断应该将读入的8位数据寄存到64位寄存器的哪个位置
            4'd0:
            data_out[7:0] <= data_in; // 将读入的8位数据寄存到64位寄存器的最低的8位
            4'd1:
            data_out[15:8] <= data_in;
            4'd2:
            data_out[23:16] <= data_in;
            4'd3:
            data_out[31:24] <= data_in;
            4'd4:
            data_out[39:32] <= data_in;
            4'd5:
            data_out[47:40] <= data_in;
            4'd6:
            data_out[55:48] <= data_in;
            4'd7:
            data_out[63:56] <= data_in; // 将读入的8位数据寄存到64位寄存器的最高的8位
            default:
            data_out <= 64'd0;
        endcase
    end
end

/* 全部64位数据传输完成标志控制 */
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out_done <= 1'd0;
    end
    else if (state == 4'd7) begin // 64位数据全部传输完毕
        data_out_done <= 1'd1;    // 全部64位数据传输完成标志输出一个较长时间的高电平
    end
    else begin
        data_out_done <= 1'd0;
    end
end

/* 并行输出64位数据 */
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_64 <= 64'd0;
    end
    else if (data_out_done == 1'd1) begin // 64位数据全部传输完毕
        data_64 <= data_out;              // 将寄存器data_out中的64位完整数据输出
    end
    else begin
        data_64 <= data_64;
    end
end

endmodule // data_out_8_to_64
