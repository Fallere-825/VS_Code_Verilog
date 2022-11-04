`timescale  1s / 1ns
// 测试激励信号模块
module tb_Traffic_Light;

    // Traffic_Light Inputs
    reg   clk;
    reg   clr;  // 灭灯信号，低电平有效
    reg   test; // 试灯信号，低电平有效
    reg   flicker;  // 双向黄灯闪烁信号，高电平有效

    // Traffic_Light Outputs
    wire  hr;
    wire  hy;
    wire  hg;
    wire  vr;
    wire  vy;
    wire  vg;
    wire  [7:0]  count;

    // 调用（实例引用）交通信号灯控制器模块
    Traffic_Light      u_Traffic_Light (
                           .clk                     ( clk            ),
                           .clr                     ( clr            ),
                           .test                    ( test           ),
                           .flicker                 ( flicker        ),

                           .hr                      ( hr             ),
                           .hy                      ( hy             ),
                           .hg                      ( hg             ),
                           .vr                      ( vr             ),
                           .vy                      ( vy             ),
                           .vg                      ( vg             ),
                           .count                   ( count    [7:0] )
                       );

    // 设置监视系统任务
    initial
        $monitor($time,
                 " clr = %b, test = %b, flicker = %b, --- Horizontal Red = %b, Horizontal Yellow = %b, Horizontal Green = %b, Vertical Red = %b, Vertical Yellow = %b, Vertical Green = %b, Countdown = %d\n",
                 clr, test, flicker, hr, hy, hg, vr, vy, vg, count);

    // 设置时钟
    initial
    begin
        clk = 1'b0;
        forever
            #0.5 clk = ~clk;
    end

    integer i, j, k;

    // 施加激励信号
    initial
    begin
        clr = 1'b0;
        test = 1'b1;
        flicker = 1'b0;

        repeat (5) @(negedge clk);
        for (i = 0; i < 2; i = i + 1)
        begin
            for (j = 0; j < 2; j = j + 1)
            begin
                for (k = 0; k < 2; k = k + 1)
                begin
                    repeat (10) @(negedge clk);
                    clr = i;
                    test = j;
                    flicker = k;
                end
            end
        end

        repeat (20) @(negedge clk);
        clr = 1'b1;
        test = 1'b1;
        flicker = 1'b0;

        repeat (20) @(negedge clk);
        clr = 1'b1;
        test = 1'b1;
        flicker = 1'b1;

        repeat (20) @(negedge clk);
        clr = 1'b1;
        test = 1'b1;
        flicker = 1'b0;

        repeat (70) @(negedge clk);
        for (i = 0; i < 2; i = i + 1)
        begin
            for (j = 0; j < 2; j = j + 1)
            begin
                for (k = 0; k < 2; k = k + 1)
                begin
                    repeat (10) @(negedge clk);
                    clr = k;
                    test = j;
                    flicker = i;
                end
            end
        end

        repeat (20) @(negedge clk);
        $stop;
    end

endmodule
