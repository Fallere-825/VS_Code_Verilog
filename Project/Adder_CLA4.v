// 定义4位超前进位加法器
module Adder_CLA4(a, b, ci, co, s);

    // 输入和输出端口声明
    input [3:0] a, b; // 数据
    input ci; // 初始进位
    output co; // 进位输出
    output [3:0] s; // 和输出

    //内部连线
    wire [4:1] c; // 每一级的进位
    wire [3:0] g; // 进位产生信号
    wire [3:0] p; // 进位传输信号

    // 计算每一级的g
    assign g = a & b;

    // 计算每一级的p
    assign p = a ^ b;

    // 计算每一级的进位
    // 在计算超前进位的算术方程中ci等于c[0]
    assign c[1] = g[0] | (p[0] & ci),
           c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & ci),
           c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & ci),
           c[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & ci);

    // 计算加法的总和
    assign s[0] = p[0] ^ ci,
           s[1] = p[1] ^ c[1],
           s[2] = p[2] ^ c[2],
           s[3] = p[3] ^ c[3];

    // 进位输出赋值
    assign co = c[4];

endmodule
