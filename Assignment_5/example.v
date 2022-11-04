module example (z,
                o,
                clk,
                rst,
                x,
                y);
    input  clk, rst, x, y;
    output z, o;
    reg z, o;
    reg q1, q0, d1, d0;
    
    always @(q1 or q0 or x or y) begin
        z  = ~(~(~x & q1 & q0) & ~(x & (q0 ^ y)));
        o  = ~(x & (q0 ^ y));
        d1 = q0 ^ y;
        d0 = (x ^ q1) ^ q0;
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q1 <= 1'b0;
            q0 <= 1'b0;
        end
        else  begin
            q1 <= d1;
            q0 <= d0;
        end
    end
    
endmodule //example
