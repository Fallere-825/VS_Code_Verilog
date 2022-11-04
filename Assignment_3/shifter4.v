module shifter_4(data_out,
                 data_in,
                 clk,
                 clr);
    output [3:0] data_out;
    input data_in, clk, clr;
    
    wire [3:0] data_out;
    wire data_in, clk, clr;
    
    D_FF  U1 (.d(data_in),.clk(clk),.reset(clr),.q(data_out[0]));
    D_FF  U2 (.d(data_out[0]),.clk(clk),.reset(clr),.q(data_out[1]));
    D_FF  U3 (.d(data_out[1]),.clk(clk),.reset(clr),.q(data_out[2]));
    D_FF  U4 (.d(data_out[2]),.clk(clk),.reset(clr),.q(data_out[3]));
endmodule
    
