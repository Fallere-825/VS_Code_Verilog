`timescale 1ns/1ps

/* 输入并行64位数据 与 串行发送 模块 */

module top_in (output wire uart_txd,      // UART发送端口
               input wire clk,            // 系统时钟
               input wire rst_n,          // 复位信号，低电平有效
               input wire [63:0] data_64, // 输入64位并行数据
               input wire manual_start);  // 手动启动系统信号
    
    /* 定义线网 */
    wire [7:0] data_8; // 【64位转8位模块】传给【tx】的8位并行数据
    wire tx_done;      // tx发送完成标志，让64位转8位模块送来新的一组8位数据
    wire tx_enable;    // tx开始新一轮工作使能信号，让tx得到新的一组8位数据
    
    data_in_64_to_8  u_data_in_64_to_8 (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .data_64                 (data_64),
    .data_in_enable          (tx_done),
    .manual_start            (manual_start),
    
    .data_8                  (data_8),
    .tx_enable               (tx_enable)
    );
    
    uart_tx      u_uart_tx (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .tx_enable               (tx_enable),
    .uart_data_in            (data_8),
    
    .uart_txd                (uart_txd),
    .tx_done                 (tx_done)
    );
    
endmodule // top_in
