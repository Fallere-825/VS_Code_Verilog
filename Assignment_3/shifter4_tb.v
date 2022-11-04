`timescale  1ns / 1ps

module shifter_4_tb();
    
    // shifter_4 Inputs
    reg   data_in = 0 ;
    reg   clk     = 0 ;
    reg   clr     = 1 ;
    
    // shifter_4 Outputs
    wire  [3:0]  data_out;
    
    
    always #5 clk = ~clk;
    
    shifter_4  u_shifter_4 (
    .data_in                 (data_in),
    .clk                     (clk),
    .clr                     (clr),
    
    .data_out                (data_out  [3:0])
    );
    
    initial
    begin
        #10 clr     = 0;
        #12 data_in = 0;
        #9 data_in  = 1;
        #30 data_in = 1;
        #10 data_in = 0;
        #20 data_in = 1;
        #10 data_in = 0;
        #10 clr     = 1;
        #10 clr     = 0;
        #12 data_in = 0;
        #9 data_in  = 1;
        #30 data_in = 1;
        #10 data_in = 0;
        #20 data_in = 1;
        #10 data_in = 0;
        #50 $stop;
    end
    
endmodule
