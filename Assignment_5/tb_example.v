module tb_example();
    
    
    // example Inputs
    reg   clk = 0 ;
    reg   rst = 0 ;
    reg   x   = 0 ;
    reg   y   = 0 ;
    
    // example Outputs
    wire  z                                    ;
    wire  o                                    ;
    
    
    example  u_example (
    .clk                     (clk),
    .rst                     (rst),
    .x                       (x),
    .y                       (y),
    
    .z                       (z),
    .o                       (o)
    );
    
    initial
    begin
        rst         = 1;
        #10 rst     = 0;
        #200 {x, y} = 2'b01;
        #230 {x, y} = 2'b10;
        #200 {x, y} = 2'b11;
        #200 rst    = 1;
    end
    
    always begin
        #10 clk = ~clk;
    end
    
endmodule
