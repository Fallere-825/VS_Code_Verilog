`timescale 1ns/1ps

/* 串行接收 与 并行64位数据输出 模块 */

module top_out (output wire [63:0] data_64, // 输出64位并行数据
                output wire data_out_done,  // 全部64位数据传输完成标志
                input wire clk,             // 系统时钟
                input wire rst_n,           // 复位信号，低电平有效
                input wire uart_rxd);       // UART接收端口

// uart_rx Parameters
parameter CLK_F    = 50_000_000      ;
parameter UART_BPS = 115200          ;
parameter CLK_GOAL = CLK_F / UART_BPS;

/* 定义线网 */
wire [7:0] uart_data_out; // 【rx】传给【8位转64位模块】的8位并行数据
wire uart_done;           // rx数据接收完成标志，让8位转64位模块读入新到的一组8位数据

uart_rx #(
.CLK_F    (CLK_F),
.UART_BPS (UART_BPS),
.CLK_GOAL (CLK_F / UART_BPS))
u_uart_rx (
.clk                     (clk),
.rst_n                   (rst_n),
.uart_rxd                (uart_rxd),

.uart_data_out           (uart_data_out),
.uart_done               (uart_done)
);

data_out_8_to_64  u_data_out_8_to_64 (
.clk                     (clk),
.rst_n                   (rst_n),
.data_8                  (uart_data_out),
.data_out_enable         (uart_done),

.data_64                 (data_64),
.data_out_done           (data_out_done)
);

endmodule // top_out
