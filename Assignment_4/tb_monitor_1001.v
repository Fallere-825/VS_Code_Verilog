module tb_monitor_1001();
    reg clk, din, rst_;
    reg [31:0] inp;
    wire find;
    
    monitor_1001 U1(din, clk, rst_, find);
    
    initial begin
        clk      = 1'b1;
        rst_     = 1'b1;
        din      = 1'b0;
        inp      = 32'b1011_0010_0100_0100_1111_1001_1001_0010;
        #5 rst_  = 1'b0;
        #10 rst_ = 1'b1;
    end
    
    always begin
        #10 din = inp[31];
        inp     = inp << 1;
    end
    
    always #5 clk = ~clk;
endmodule
