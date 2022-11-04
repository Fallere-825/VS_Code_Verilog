// 定义激励（顶层模块）
module tb_Adder_CLA;

    // Adder_CLA Inputs
    reg   [31:0]  a;
    reg   [31:0]  b;
    reg   c_in;

    // Adder_CLA Outputs
    wire  c_out;
    wire  [31:0]  sum;

    // 调用（实例引用）CLA加法器
    Adder_CLA   u_Adder_CLA (
                    .a                       ( a      [31:0] ),
                    .b                       ( b      [31:0] ),
                    .c_in                    ( c_in          ),

                    .c_out                   ( c_out         ),
                    .sum                     ( sum    [31:0] )
                );

    // 设置信号值的监视
    initial
    begin
        $monitor($time, " a = %b, b = %b, c_in = %b, --- c_out = %b, sum = %b\n", a, b, c_in, c_out, sum);
    end

    initial
    begin
        a = 32'b0;
        b = 32'b0;
        c_in = 1'b0;
    end

    // 激励信号的输入
    always
    begin
        #10 a = {$random};
        b = {$random};
        c_in = {$random} % 2;
    end

endmodule
