`timescale 1ns/1ps

module uart_tx_to_rx (output wire [7:0] uart_data_out, // 输出8位并行数据
                      output wire uart_done,
                      output wire tx_done,
                      input wire clk,          // 系统时钟
                      input wire rst_n,        // 复位信号，低电平有效
                      input wire manual_start, // 发送使能信号
                      input wire [7:0] uart_data_in);

wire uart_tx_to_rx;

uart_tx
u_uart_tx (
.clk                     (clk),
.rst_n                   (rst_n),
.uart_enable             (manual_start),
.uart_data_in            (uart_data_in),

.uart_txd                (uart_tx_to_rx),
.tx_done                 (tx_done)
);

uart_rx
u_uart_rx (
.clk                     (clk),
.rst_n                   (rst_n),
.uart_rxd                (uart_tx_to_rx),

.uart_data_out           (uart_data_out),
.uart_done               (uart_done)
);

endmodule // uart_tx_to_rx
