`timescale 1ns/1ps

/* 顶层模块 */

module top (output wire [63:0] data_out_64, // 输出64位并行数据
            output wire data_out_done,      // 全部64位数据传输完成标志
            input wire clk,                 // 系统时钟
            input wire rst_n,               // 复位信号，低电平有效
            input wire manual_start,        // 手动启动系统信号
            input wire [63:0] data_in_64);  // 输入64位并行数据

/* 定义线网 */
wire data; // tx传输给rx的1位数据

top_in  u_top_in (
.clk                     (clk),
.rst_n                   (rst_n),
.data_64                 (data_in_64),
.manual_start            (manual_start),

.uart_txd                (data)
);


top_out  u_top_out (
.clk                     (clk),
.rst_n                   (rst_n),
.uart_rxd                (data),

.data_64                 (data_out_64),
.data_out_done           (data_out_done)
);

endmodule // top
