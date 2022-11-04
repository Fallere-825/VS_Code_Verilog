`timescale  1s / 1ns
module Traffic_Light(clk, clr, test, flicker, hr, hy, hg, vr, vy, vg, count);

    // 输入/输出端口声明
    input clk,
          clr,  // 灭灯信号，低电平有效
          test, // 试灯信号，低电平有效
          flicker;  // 双向黄灯闪烁信号，高电平有效

    output hr, hy, hg, vr, vy, vg;
    /* 表示横向道路与纵向道路的红灯、黄灯、绿灯
    HORIZONTAL（横向），VERTICAL（纵向）
    RED（红），YELLOW（黄），GREEN（绿） */
    reg hr, hy, hg, vr, vy, vg; // 声明输出信号为寄存器类型

    output [7:0] count; // 表示倒计时
    reg [7:0] count = 8'b00000001;  // 声明输出信号为寄存器类型

    // 交通灯的状态
    parameter L0 = 6'b100001,
              L1 = 6'b100010,
              L2 = 6'b010010,
              L3 = 6'b010100,
              L4 = 6'b001100,
              L_clr = 6'b000000,
              L_test = 6'b111111;

    // 状态定义                             HORIZONTAL      VERTICAL
    parameter S0 = 4'b0000,             // RED              GREEN
              S1 = 4'b0001,             // RED              YELLOW
              S2 = 4'b0010,             // YELLOW           YELLOW
              S3 = 4'b0011,             // YELLOW           RED
              S4 = 4'b0100,             // GREEN            RED
              S5 = 4'b0101,             // YELLOW           RED
              S6 = 4'b0110,             // YELLOW           YELLOW
              S7 = 4'b0111,             // RED              YELLOW
              S_flicker_1 = 4'b1000,    // OFF              OFF
              S_flicker_2 = 4'b1001,    // YELLOW           YELLOW
              S_clr = 4'b1010,          // OFF              OFF
              S_test = 4'b1011;         // ALL              ALL

    // 时间
    parameter T0 = 15,  // S0状态的时间
              T1 = 5,   // S1状态的时间
              T2 = 1,   // S2状态的时间
              T3 = 5,   // S3状态的时间
              T4 = 10,  // S4状态的时间
              T5 = 5,   // S5状态的时间
              T6 = 1,   // S6状态的时间
              T7 = 5;   // S7状态的时间

    // 内部状态变量
    reg [5:0] light = 6'b000000;
    reg [3:0] current_state, next_state;

    // 状态只能在时钟信号的正跳变沿改变
    always @(posedge clk)
    begin
        current_state <= next_state;    // 状态的改变
    end

    // 计算倒计时
    always @(posedge clk or negedge clr or negedge test or posedge flicker)
    begin
        if (!clr)   // 灭灯信号有效
        begin
            count <= 0; // 倒计时清零
        end
        else if (!test) // 试灯信号有效
        begin
            count <= 0; // 倒计时清零
        end
        else if (flicker)   // 双向黄灯闪烁信号有效
        begin
            count <= 0; // 倒计时清零
        end
        else
        begin
            if (count == 1 || count == 0) // 倒计时结束
            begin
                case(next_state)    // 重置为下一状态的时间
                    S0:
                    begin
                        count <= T0;
                    end
                    S1:
                    begin
                        count <= T1;
                    end
                    S2:
                    begin
                        count <= T2;
                    end
                    S3:
                    begin
                        count <= T3;
                    end
                    S4:
                    begin
                        count <= T4;
                    end
                    S5:
                    begin
                        count <= T5;
                    end
                    S6:
                    begin
                        count <= T6;
                    end
                    S7:
                    begin
                        count <= T7;
                    end
                    default:
                    begin
                        count <= T0;
                    end
                endcase
            end
            else    // 倒计时未结束
            begin
                count <= count - 1; // 继续倒计时
            end
        end
    end

    always @(current_state or clr or test or flicker or count)
    begin
        if (!clr)   // 灭灯信号有效
        begin
            next_state = S_clr;
            light = L_clr;  // 所有灯灭
        end
        else if (!test) // 试灯信号有效
        begin
            next_state = S_test;
            light = L_test; // 所有灯亮
        end
        else if (flicker)   // 双向黄灯闪烁信号有效
        begin
            case(current_state) // 用case语句描述的状态机
                S_flicker_1:
                begin
                    next_state = S_flicker_2;
                    light = L_clr;  // 所有灯灭
                end
                default:
                begin
                    next_state = S_flicker_1;
                    light = L2; // 双向黄灯亮
                end
            endcase
        end
        else
        begin
            case(current_state) // 用case语句描述的状态机
                S0:
                begin
                    light = L0;
                    if (count == 1)
                    begin
                        next_state = S1;
                    end
                    else
                    begin
                        next_state = S0;
                    end
                end
                S1:
                begin
                    light = L1;
                    if (count == 1)
                    begin
                        next_state = S2;
                    end
                    else
                    begin
                        next_state = S1;
                    end
                end
                S2:
                begin
                    light = L2;
                    if (count == 1)
                    begin
                        next_state = S3;
                    end
                    else
                    begin
                        next_state = S2;
                    end
                end
                S3:
                begin
                    light = L3;
                    if (count == 1)
                    begin
                        next_state = S4;
                    end
                    else
                    begin
                        next_state = S3;
                    end
                end
                S4:
                begin
                    light = L4;
                    if (count == 1)
                    begin
                        next_state = S5;
                    end
                    else
                    begin
                        next_state = S4;
                    end
                end
                S5:
                begin
                    light = L3;
                    if (count == 1)
                    begin
                        next_state = S6;
                    end
                    else
                    begin
                        next_state = S5;
                    end
                end
                S6:
                begin
                    light = L2;
                    if (count == 1)
                    begin
                        next_state = S7;
                    end
                    else
                    begin
                        next_state = S6;
                    end
                end
                S7:
                begin
                    light = L1;
                    if (count == 1)
                    begin
                        next_state = S0;
                    end
                    else
                    begin
                        next_state = S7;
                    end
                end
                default:
                begin
                    next_state = S0;
                    light = L0;
                end
            endcase
        end

        // 输出赋值
        hr = light[5];  // 横向道路红灯
        hy = light[4];  // 横向道路黄灯
        hg = light[3];  // 横向道路绿灯
        vr = light[2];  // 纵向道路红灯
        vy = light[1];  // 纵向道路黄灯
        vg = light[0];  // 纵向道路绿灯
    end

endmodule
