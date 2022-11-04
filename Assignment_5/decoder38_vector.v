module decoder38_vector (outa,
                         in1,
                         in2,
                         in3);
    input in1, in2, in3;
    output [7:0] outa;
    reg [7:0] outa;
    
    always @(in1 or in2 or in3)  begin
        case ({in3,in2,in1})
            3'b000 : begin
                outa = 8'b1111_1110;
            end
            3'b001 : begin
                outa = 8'b1111_1101;
            end
            3'b010 : begin
                outa = 8'b1111_1011;
            end
            3'b011 : begin
                outa = 8'b1111_0111;
            end
            3'b100 : begin
                outa = 8'b1110_1111;
            end
            3'b101 : begin
                outa = 8'b1101_1111;
            end
            3'b110 : begin
                outa = 8'b1011_1111;
            end
            3'b111 : begin
                outa = 8'b0111_1111;
            end
        endcase
    end
    
endmodule
    
    
