`timescale 1ns/1ps

/* 输入 并行64位数据 转 并行8位数据 输出 模块 */

module data_in_64_to_8 (output reg [7:0] data_8,   // 输出8位并行数据
                        output reg tx_enable,      // tx开始新一轮工作使能信号
                        input wire clk,            // 系统时钟
                        input wire rst_n,          // 复位信号，低电平有效
                        input wire [63:0] data_64, // 输入64位并行数据
                        input wire data_in_enable, // 输出下一组8位数据使能信号
                        input wire manual_start);  // 手动启动系统信号

/* 定义寄存器 */
reg [63:0] data;      // 输入数据寄存器
reg [3:0] state;      // 输出数据组数计数器
reg data_in_enable_1; // 用于判断是否开始输出下一组8位数据的寄存器
reg manual_start_1;   // 用于判断是否启动系统的寄存器

/* 定义线网 */
wire start_flag; // 开始输出下一组8位数据标志

// start_flag用于检测接收到的【输出下一组8位数据使能信号】的上升沿或【系统启动信号】的上升沿
// 当前8位数据输出完成后，输出下一组8位数据给tx
assign start_flag = (((~data_in_enable_1) & data_in_enable) || ((~manual_start_1) & manual_start));

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_in_enable_1 <= 1'b0;
        manual_start_1   <= 1'b0;
    end
    else begin
        data_in_enable_1 <= data_in_enable;
        manual_start_1   <= manual_start;
    end
end

/* 输出数据组数计数与输入数据寄存 */
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= 4'd8;
        data  <= 64'd0;
    end
    else if (start_flag) begin  // 可以输出下一组数据
        if (state > 4'd6) begin // 输出完最后一组数据
            state <= 4'd0;      // 循环，从头开始输出第一组数据
            data  <= data_64;   // 读入64位并行数据，存入寄存器
        end
        else begin
            state <= state + 1'b1; // 当前输出的组数加1
            data  <= data;
        end
    end
    else begin // 还没有到可以输出下一组数据的时刻
        state <= state;
        data  <= data;
    end
end

/* 并行输出一组8位数据 */
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_8 <= 8'd0;
    end
    else begin
        case (state) // 根据输出数据组数计数器判断应该输出哪组数据
            4'd0:
            data_8 <= data[7:0]; // 输出64位数据中最低的一组8位数据
            4'd1:
            data_8 <= data[15:8];
            4'd2:
            data_8 <= data[23:16];
            4'd3:
            data_8 <= data[31:24];
            4'd4:
            data_8 <= data[39:32];
            4'd5:
            data_8 <= data[47:40];
            4'd6:
            data_8 <= data[55:48];
            4'd7:
            data_8 <= data[63:56]; // 输出64位数据中最高的一组8位数据
            default:
            data_8 <= 8'd0;
        endcase
    end
end

/* tx开始新一轮工作使能信号控制 */
always @(posedge clk or negedge rst_n)  begin
    if (!rst_n) begin
        tx_enable <= 1'b0;
    end
    else if (start_flag) begin // tx让本模块传输下一组8位数据
        tx_enable <= 1'b1;     // tx开始新一轮工作使能信号输出一个高电平脉冲，让tx得到新的一组8位数据
    end
    else begin
        tx_enable <= 1'b0;
    end
end
endmodule // data_in_64_to_8
