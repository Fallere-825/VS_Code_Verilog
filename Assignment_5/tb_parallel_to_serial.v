module tb_parallel_to_serial();
    
    
    // parallel_to_serial Inputs
    reg   clk        = 0 ;
    reg   rst        = 0 ;
    reg   [3:0]  pin = 0 ;
    
    // parallel_to_serial Outputs
    wire  sout                                 ;
    
    
    parallel_to_serial  u_parallel_to_serial (
    .clk                     (clk),
    .rst                     (rst),
    .pin                     (pin   [3:0]),
    
    .sout                    (sout)
    );
    
    initial
    begin
        rst     = 1;
        #10 rst = 0;
        #10 pin = 4'b1001;
        #50 pin = 4'b0110;
        #50 pin = 4'b1111;
        #50 pin = 4'b0000;
        #50 pin = 4'b1110;
        #50 pin = 4'b0111;
    end
    always begin
        #5 clk = ~clk;
    end
    
endmodule
