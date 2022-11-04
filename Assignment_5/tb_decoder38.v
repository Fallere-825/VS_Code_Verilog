module tb_decoder38();
    
    
    // decoder38 Inputs
    reg   in1 = 1'b1 ;
    reg   in2 = 1'b1 ;
    reg   in3 = 1'b1 ;
    
    // decoder38 Outputs
    wire  a                                    ;
    wire  b                                    ;
    wire  c                                    ;
    wire  d                                    ;
    wire  e                                    ;
    wire  f                                    ;
    wire  g                                    ;
    wire  h                                    ;
    
    
    decoder38  u_decoder38 (
    .in1                     (in1),
    .in2                     (in2),
    .in3                     (in3),
    
    .a                       (a),
    .b                       (b),
    .c                       (c),
    .d                       (d),
    .e                       (e),
    .f                       (f),
    .g                       (g),
    .h                       (h)
    );
    
    always begin
        #5 {in3, in2, in1} = {in3, in2, in1} - 1;
    end
    
endmodule
