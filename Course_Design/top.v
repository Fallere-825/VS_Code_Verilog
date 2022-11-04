`timescale 1ns/1ps

module top (output wire [63:0] data_out_64,
            input wire clk,
            input wire rst_n,
            input wire manual_start,
            input wire [63:0] data_in_64);


wire uart_txd;

wire rst_check;

wire rst_total;

reg   [63:0] data_in_1;

assign rst_check = (data_in_64 == data_in_1)? 1'b1 : 1'b0;

assign rst_total = ~(~(rst_check) || ~(rst_n));

always @(posedge clk) begin
    
    data_in_1 <= data_in_64;
    
    
end



top_in  u_top_in (
.clk                     (clk),
.rst_n                   (rst_n),
.manual_start            (manual_start),
.data_64                 (data_in_64),

.uart_txd                (uart_txd)
);


top_out  u_top_out (
.clk                     (clk),
.rst_n                   (rst_n),
.uart_txd                (uart_txd),

.data_64                 (data_out_64)
);
endmodule // top
