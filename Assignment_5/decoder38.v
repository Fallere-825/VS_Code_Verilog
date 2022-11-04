module decoder38 (a,
                  b,
                  c,
                  d,
                  e,
                  f,
                  g,
                  h,
                  in1,
                  in2,
                  in3);
    input in1, in2, in3;
    output a, b, c, d, e, f, g, h;
    reg a, b, c, d, e, f, g, h;
    
    always @(in1 or in2 or in3)  begin
        case ({in3,in2,in1})
            3'b000 : begin
                a = 0; b = 1; c = 1; d = 1; e = 1; f = 1; g = 1; h = 1;
            end
            3'b001 : begin
                a = 1; b = 0; c = 1; d = 1; e = 1; f = 1; g = 1; h = 1;
            end
            3'b010 : begin
                a = 1; b = 1; c = 0; d = 1; e = 1; f = 1; g = 1; h = 1;
            end
            3'b011 : begin
                a = 1; b = 1; c = 1; d = 0; e = 1; f = 1; g = 1; h = 1;
            end
            3'b100 : begin
                a = 1; b = 1; c = 1; d = 1; e = 0; f = 1; g = 1; h = 1;
            end
            3'b101 : begin
                a = 1; b = 1; c = 1; d = 1; e = 1; f = 0; g = 1; h = 1;
            end
            3'b110 : begin
                a = 1; b = 1; c = 1; d = 1; e = 1; f = 1; g = 0; h = 1;
            end
            3'b111 : begin
                a = 1; b = 1; c = 1; d = 1; e = 1; f = 1; g = 1; h = 0;
            end
        endcase
    end
    
endmodule
    
