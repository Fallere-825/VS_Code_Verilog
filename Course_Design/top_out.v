`timescale 1ns/1ps

module top_out (output wire [63:0] data_64,
                input wire clk,
                input wire rst_n,
                input wire uart_txd);


wire [7:0] uart_data_out;
wire uart_done;




uart_rx
u_uart_rx (
.clk                     (clk),
.rst_n                   (rst_n),
.uart_rxd                (uart_txd),

.uart_data_out           (uart_data_out),
.uart_done               (uart_done)
);



data_out_8_to_64  u_data_out_8_to_64 (
.clk                     (clk),
.rst_n                   (rst_n),
.data_8                  (uart_data_out),
.data_out_enable         (uart_done),

.data_64                 (data_64)
);

endmodule // top_out
