`timescale  1ns / 1ps

module tb_top();
    
    // top Parameters
    parameter PERIOD = 20;
    
    
    // top Inputs
    reg   clk                = 0 ;
    reg   rst_n              = 0 ;
    reg   manual_start       = 0 ;
    reg   [63:0]  data_in_64 = 0 ;
    
    // top Outputs
    wire  [63:0]  data_out_64                  ;
    
    
    
    always #(PERIOD/2)  clk = ~clk;
    
    
    top  u_top (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .manual_start            (manual_start),
    .data_in_64              (data_in_64    [63:0]),
    
    .data_out_64             (data_out_64   [63:0])
    );
    
    initial
    begin
        #20
        rst_n        = 1'b1;
        data_in_64   = 64'b1010_0001_1010_0011_0100_1101_0110_1111_1111_0110_1011_0010_1100_0101_1000_0001;
        manual_start = 1'b1;
        
        
        
        
        
        
        
        
        // #40
        // #8681
        // #8681
        // #8681
        // #8681
        #(86810 * 8)
        #(20 * 28)
        #10
        // manual_start = 1'b0;
        #10
        #(8681 * 9)
        // #(86810 * 6)
        
        
        rst_n        = 1'b1;
        data_in_64   = 64'b0100_0100_0010_0011_0011_1110_0111_1001_0100_0111_1001_0100_0010_0111_1111_0111;
        manual_start = 1'b1;
        
        
        
        
        
        #868100
        #(86810 * 4)
        #868100
        
        
        
        
        
        
        
        
        $stop;
        
        
        
        
        
        
        
        
        
        
        
    end
    
endmodule
