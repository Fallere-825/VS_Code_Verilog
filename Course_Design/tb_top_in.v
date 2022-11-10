`timescale  1ns / 1ps

module tb_top_in();
    
    // top_in Parameters
    parameter PERIOD   = 20;
    parameter CLK_F    = 50_000_000      ;
    parameter UART_BPS = 115200          ;
    parameter CLK_GOAL = CLK_F / UART_BPS;
    
    // top_in Inputs
    reg   clk             = 0 ;
    reg   rst_n           = 0 ;
    reg   [63:0]  data_64 = 0 ;
    reg   manual_start    = 0 ;
    
    // top_in Outputs
    wire  uart_txd                             ;
    
    
    initial
    begin
        forever #(PERIOD/2)  clk = ~clk;
    end
    
    top_in #(
    .CLK_F    (CLK_F),
    .UART_BPS (UART_BPS),
    .CLK_GOAL (CLK_GOAL))
    u_top_in (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .data_64                 (data_64       [63:0]),
    .manual_start            (manual_start),
    
    .uart_txd                (uart_txd)
    );
    
    initial
    begin
        #20
        rst_n = 1;
        
        /* 传输第一个64位数据 */
        data_64      = 64'b0010_1100_1111_1111_0000_1010_1110_1111_1000_1010_1110_0001_0110_1000_0110_0101;
        manual_start = 1;
        #40
        manual_start = 0;
        
        /* 传输第二个64位数据 */
        #86810
        data_64 = 64'b1110_0100_0010_1001_1111_0110_0101_0111_1010_0111_1100_0010_1101_1011_0111_1000;
        
        #868100
        #868100
        #40
        $stop;
    end
    
endmodule
