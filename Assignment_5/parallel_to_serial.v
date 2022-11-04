module parallel_to_serial (sout,
                           clk,
                           rst,
                           pin);
    input clk, rst;
    input [3:0] pin;
    output sout;
    reg sout;
    reg [3:0] temp;
    
    always @(pin) begin
        temp <= pin;
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sout <= 0;
        end
        else begin
            sout      <= temp[3];
            temp[3:0] <= {temp[2:0], 1'b0};
        end
    end
    
endmodule //parallel_to_serial
