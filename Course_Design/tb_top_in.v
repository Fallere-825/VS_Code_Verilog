`timescale  1ns / 1ps

module tb_top_in();
    
    // top_in Parameters
    parameter PERIOD = 20;
    
    
    // top_in Inputs
    reg   clk             = 0 ;
    reg   rst_n           = 0 ;
    reg   manual_start    = 0 ;
    reg   [63:0]  data_64 = 0 ;
    reg   [7:0] rx_check  = 0 ;
    
    // top_in Outputs
    wire  uart_txd                             ;
    wire uart_data_out0;
    wire uart_done;
    
    integer i = 0;
    
    parameter BIT_PERIOD = 8681;
    
    always #(PERIOD/2)  clk = ~clk;
    
    
    top_in  u_top_in (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .manual_start            (manual_start),
    .data_64                 (data_64       [63:0]),
    
    .uart_txd                (uart_txd)
    );
    
    
    uart_rx
    u_uart_rx (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .uart_rxd                (uart_txd),
    
    .uart_data_out           (uart_data_out),
    .uart_done               (uart_done)
    );
    
    initial
    begin
        #20
        rst_n        = 1'b1;
        data_64      = 64'b1000_0001_1010_0011_0100_1101_0110_1111_1111_0110_1011_0010_1100_0101_1000_0001;
        manual_start = 1'b1;
        
        
        
        
        
        
        
        
        #868100
        #(86810 * 2)
        $stop;
    end
    
    /* always @(posedge clk) begin
     wait (uart_txd == 0);
     rx_check <= 7'd0;
     #(BIT_PERIOD)
     #(BIT_PERIOD / 2)
     
     for (i = 0; i < 8; i = i + 1) begin
     rx_check[i] <= uart_txd;
     if (i < 7) begin
     #(BIT_PERIOD);
     end
     end
     end */
    
    
endmodule
