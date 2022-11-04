module tb_decoder38_vector();
    
    
    // decoder38_vector Inputs
    reg   in1 = 1'b1 ;
    reg   in2 = 1'b1 ;
    reg   in3 = 1'b1 ;
    
    // decoder38_vector Outputs
    wire  [7:0]  outa                          ;
    
    
    decoder38_vector  u_decoder38_vector (
    .in1                     (in1),
    .in2                     (in2),
    .in3                     (in3),
    
    .outa                    (outa  [7:0])
    );
    
    always begin
        #5 {in3, in2, in1} = {in3, in2, in1} - 1;
    end
    
endmodule
    
