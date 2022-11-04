module tb_s74194();
    
    
    // s74194 Inputs
    reg   nrst          = 0 ;
    reg   clk           = 0 ;
    reg   s0            = 0 ;
    reg   s1            = 0 ;
    reg   dil           = 0 ;
    reg   dir           = 0 ;
    reg   [3:0]  datain = 0 ;
    
    // s74194 Outputs
    wire  [3:0]  dataout                       ;
    
    
    s74194  u_s74194 (
    .nrst                    (nrst),
    .clk                     (clk),
    .s0                      (s0),
    .s1                      (s1),
    .dil                     (dil),
    .dir                     (dir),
    .datain                  (datain   [3:0]),
    
    .dataout                 (dataout  [3:0])
    );
    
    initial
    begin
        #10 nrst = 1;
        
        #10 datain = 4'b1111;
        {s1, s0}   = 2'b11; // paralell download test
        #10 datain = 4'b1001;
        
        #20 {s1, s0} = 2'b00;   // data hold test
        datain       = 4'b0011;
        
        #20 dir  = 1;
        {s1, s0} = 2'b01;   // right shift test
        #10 dir  = 0;
        #20 dir  = 1;
        
        #30 dil  = 1;
        {s1, s0} = 2'b10;   // left shift test
        #20 dil  = 0;
        #10 dil  = 1;
        
        #10 nrst = 0;
    end
    always  begin
        #5 clk = ~clk;
    end
    
endmodule
