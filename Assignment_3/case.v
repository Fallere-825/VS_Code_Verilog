`timescale 1ns / 1ps
module case_compare(input[1:0] sel,
                    output reg [1:0] y,
                    input[1:0] z_sel,
                    output reg [1:0] z_y,
                    input[1:0] x_sel,
                    output reg [1:0] x_y);
    
    always @(*) begin
        case(sel)
            2'b00: y   = 2'b00;
            2'b01: y   = 2'b01;
            2'b1?: y   = 2'b10;
            default: y = 2'b11;
        endcase
    end
    
    always @(*) begin
        casez(z_sel)
            2'b00: z_y   = 2'b00;
            2'b01: z_y   = 2'b01;
            2'b1?: z_y   = 2'b10;
            default: z_y = 2'b11;
        endcase
    end
    
    always @(*) begin
        casex(x_sel)
            2'b00: x_y   = 2'b00;
            2'b01: x_y   = 2'b01;
            2'b1?: x_y   = 2'b10;
            default: x_y = 2'b11;
        endcase
    end
    
    
endmodule
    
