`timescale  1ns / 1ps

module tb_data_in_64_to_8();
    
    // data_in_64_to_8 Inputs
    reg   clk             = 0 ;
    reg   rst_n           = 0 ;
    reg   [63:0]  data_64 = 0 ;
    reg   data_in_enable  = 0 ;
    
    // data_in_64_to_8 Outputs
    wire  [7:0]  data_8                        ;
    
    
    parameter PERIOD        = 20;
    always #(PERIOD/2)  clk = ~clk;
    
    
    data_in_64_to_8  u_data_in_64_to_8 (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .data_64                 (data_64         [63:0]),
    .data_in_enable          (data_in_enable),
    
    .data_8                  (data_8          [7:0])
    );
    
    initial
    begin
        #20
        rst_n          = 1;
        data_64        = 64'b1000_0001_1010_0011_0100_1101_0110_1111_1111_0110_1011_0010_1100_0101_1000_0001;
        data_in_enable = 1;
        #8681
        data_in_enable = 0;
        #86810
        data_in_enable = 1;
        
        #8681
        data_in_enable = 0;
        #86810
        data_in_enable = 1;
        
        #8681
        data_in_enable = 0;
        #86810
        data_in_enable = 1;
        
        #8681
        data_in_enable = 0;
        #86810
        data_in_enable = 1;
        
        #8681
        data_in_enable = 0;
        #86810
        data_in_enable = 1;
        
        #8681
        data_in_enable = 0;
        #86810
        data_in_enable = 1;
        
        #8681
        data_in_enable = 0;
        #86810
        data_in_enable = 1;
        
        #8681
        data_in_enable = 0;
        #86810
        data_in_enable = 1;
        
        #8681
        data_in_enable = 0;
        #86810
        data_in_enable = 1;
        
        #8681
        data_in_enable = 0;
        #86810
        data_in_enable = 1;
        
        #8681
        data_in_enable = 0;
        #86810
        data_in_enable = 1;
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        $stop;
    end
    
endmodule
