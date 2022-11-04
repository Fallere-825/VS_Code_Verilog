module s74194 (nrst,
               clk,
               s0,
               s1,
               dil,
               dir,
               datain,
               dataout);
    input nrst, clk, s0, s1, dil, dir;
    input [3:0] datain;
    output [3:0] dataout;
    reg [3:0] dataout;
    
    always @(posedge clk or negedge nrst)  begin
        if (!nrst)  begin
            dataout <= 4'b0000;
        end
        else begin
            case({s1, s0})
                2'b00: begin                 // data hold
                    dataout <= dataout;
                end
                2'b01: begin                 // right shift
                    dataout[3]   <= dir;
                    dataout[2:0] <= dataout[3:1];
                end
                2'b10: begin                 // left shift
                    dataout[0] <= dil;
                    dataout[1] <= dataout[0];
                    dataout[2] <= dataout[1];
                    dataout[3] <= dataout[2];
                end
                2'b11 : begin                // paralell download
                    dataout <= datain;
                end
            endcase
        end    //else
    end    //always
endmodule
    
