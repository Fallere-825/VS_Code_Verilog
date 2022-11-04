module D_FF(q,
            qn,
            d,
            clk,
            reset);
    output q,qn;
    input d,clk,reset;
    
    reg q,qn;
    
    always @ (posedge clk or posedge reset)
    begin
        if (reset)
        begin
            q <= 0;qn <= 1;
        end
        else
        begin
            q <= d;qn <= ~d;
        end
    end
endmodule
