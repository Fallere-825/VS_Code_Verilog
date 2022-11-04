module monitor_1001(din,
                    clk,
                    rst_,
                    find);
    input din, clk, rst_;
    output find;
    reg [3:0] shift_d4;
    reg [1:0] satur_timer;
    reg find;
    
    always @(posedge clk or negedge rst_)
    begin
        if (!rst_)
        begin
            shift_d4    = 4'b0;
            find        = 1'b0;
            satur_timer = 2'b0;
        end
        else
        begin
            shift_d4    = shift_d4 >> 1;
            shift_d4[3] = din;
            if ((shift_d4 == 4'b1001) || (|satur_timer))
            begin
                find = 1'b1;
                if ((shift_d4 == 4'b1001) && (&satur_timer))
                    satur_timer = 2'b01;
                else
                    satur_count;
            end
            else
            begin
                find        = 1'b0;
                satur_timer = 2'b00;
            end
        end
    end
    
    task satur_count;
        satur_timer = satur_timer + 2'b01;
    endtask
endmodule
    
