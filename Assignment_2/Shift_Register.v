module shift(data_out,
             data_in,
             clr,
             clk);     // shifter
    
    output[7:0] data_out;
    input data_in,clr,clk;
    
    reg[7:0] data_out;
    
    always @(posedge clk or posedge clr)
    begin
        if (clr)
            data_out = 8'b0;
        else  begin
            data_out    = data_out>>1;
            data_out[7] = data_in;
        end
    end
endmodule
