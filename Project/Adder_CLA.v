// 定义CLA加法器
module Adder_CLA(a, b, c_in, c_out, sum);

    // 参数声明语句，参数可以重新定义
    parameter N = 32; // 默认的输入数据为32位

    // 输入/输出端口声明
    input [N - 1:0] a, b; // 数据
    input c_in; // 初始进位
    output c_out; // 进位输出
    output [N - 1:0] sum; // 和输出

    // 内部线网
    wire [N/4:0] c; // 每个4位超前进位加法器的进位输出

    // 初始进位赋值
    assign c[0] = c_in;

    // 声明一个临时循环变量，该变量只用于生成块的循环计算。Verilog仿真时该变量在设计中并不存在
    genvar i;

    // 用一个单循环调用（实例引用）4位超前进位加法器
    generate
        for (i = 0; i < N/4; i = i + 1)
        begin : Adder_CLA4_loop
            Adder_CLA4  u_Adder_CLA4 (
                            .a                       ( a[i*4 + 3 : i*4] ),
                            .b                       ( b[i*4 + 3 : i*4] ),
                            .ci                      ( c[i] ),

                            .co                      ( c[i+1] ),
                            .s                       ( sum[i*4 + 3 : i*4] )
                        );
        end
    endgenerate

    // 进位输出赋值
    assign c_out = c[N/4];

endmodule
