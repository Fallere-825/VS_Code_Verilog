module shift_hb; 

    reg data_in, clr, clk; 
    wire [7:0] data_out; 

    shift U0 (.data_out(data_out), .data_in(data_in), .clr(clr), .clk(clk));
    
    initial begin
        clr     = 1;
        clk     = 0;
        data_in = 0;
        
        #10 clr     = 0;
        #10 data_in = 0;
        #10 data_in = 1;
        #20 data_in = 0;
        #10 data_in = 1;
        #10 data_in = 0;
        #10 clr     = 1;
        #10 clr     = 0;
        #10 data_in = 0;
        #20 data_in = 1;
        #10 data_in = 0;
        #10 data_in = 1;
        #10 data_in = 0;
        #3  clr     = 1;
        #3  clr     = 0;
        #10 $stop;
    end
    
    always
    #5 clk = ~clk;
endmodule
