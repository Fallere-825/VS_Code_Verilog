`timescale 1ns/1ps

/* 顶层模块 */

module top (output wire uart_txd,           // UART发送端口
            output wire [63:0] data_out_64, // 输出64位并行数据
            output wire data_out_done,      // 全部64位数据传输完成标志
            input wire clk,                 // 系统时钟
            input wire rst_n,               // 复位信号，低电平有效
            input wire [63:0] data_in_64,   // 输入64位并行数据
            input wire manual_start,        // 手动启动系统信号
            input wire uart_rxd);           // UART接收端口
    
    // top_in Parameters
    // top_out Parameters
    parameter CLK_F    = 50_000_000      ;
    parameter UART_BPS = 115200          ;
    parameter CLK_GOAL = CLK_F / UART_BPS;
    
    top_in #(
    .CLK_F    (CLK_F),
    .UART_BPS (UART_BPS),
    .CLK_GOAL (CLK_F / UART_BPS))
    u_top_in (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .data_64                 (data_in_64),
    .manual_start            (manual_start),
    
    .uart_txd                (uart_txd)
    );
    
    top_out #(
    .CLK_F    (CLK_F),
    .UART_BPS (UART_BPS),
    .CLK_GOAL (CLK_F / UART_BPS))
    u_top_out (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .uart_rxd                (uart_rxd),
    
    .data_64                 (data_out_64),
    .data_out_done           (data_out_done)
    );
    
endmodule // top
