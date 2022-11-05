`timescale  1ns / 1ps

module tb_uart_tx();
    
    // uart_tx Parameters
    parameter PERIOD   = 20              ;
    parameter CLK_F    = 50_000_000      ;
    parameter UART_BPS = 115200          ;
    parameter CLK_GOAL = CLK_F / UART_BPS;
    
    // uart_tx Inputs
    reg   clk                 = 0 ;
    reg   rst_n               = 0 ;
    reg   tx_enable           = 0 ;
    reg   [7:0]  uart_data_in = 0 ;
    
    // uart_tx Outputs
    wire  uart_txd                             ;
    wire  tx_done                              ;
    
    
    initial
    begin
        forever #(PERIOD/2)  clk = ~clk;
    end
    
    uart_tx #(
    .CLK_F    (CLK_F),
    .UART_BPS (UART_BPS),
    .CLK_GOAL (CLK_GOAL))
    u_uart_tx (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .tx_enable               (tx_enable),
    .uart_data_in            (uart_data_in  [7:0]),
    
    .uart_txd                (uart_txd),
    .tx_done                 (tx_done)
    );
    
    initial
    begin
        #20
        rst_n = 1;
        
        /* 传输1010_1100 */
        uart_data_in = 8'b1010_1100;
        tx_enable    = 1;
        #40
        tx_enable = 0;
        
        /* 传输0110_1110 */
        #86810
        uart_data_in = 8'b0110_1110;
        tx_enable    = 1;
        #40
        tx_enable = 0;
        
        /* 传输1100_0010 */
        #86810
        uart_data_in = 8'b1100_0010;
        tx_enable    = 1;
        #40
        tx_enable = 0;
        
        #86810
        $stop;
    end
    
endmodule
