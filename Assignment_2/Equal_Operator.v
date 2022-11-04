module Equal_Operator();
    
    reg [1:0]a,b;
    
    initial begin
        a = 2'b1x;
        b = 2'b1x;
        
        if (a == b)
            $display(" a is equal to b");
        else
            $display(" a is not equal to b");
        
        if (a === b)
            $display(" a is identical to b");
        else
            $display(" a is not identical to b");
    end
endmodule
