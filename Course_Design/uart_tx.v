`timescale 1ns/1ps

/* 串行发送模块 */

module uart_tx (output reg uart_txd,            // UART发送端口
                output reg tx_done,             // 发送完成标志
                input wire clk,                 // 系统时钟
                input wire rst_n,               // 复位信号，低电平有效
                input wire tx_enable,           // 开始新一轮工作使能信号
                input wire [7:0] uart_data_in); // 输入8位并行数据
    
    /* 定义参数 */
    parameter CLK_F    = 50_000_000;       // 系统时钟频率
    parameter UART_BPS = 115200;           // 串口波特率
    parameter CLK_GOAL = CLK_F / UART_BPS; // 1 bit数据持续多少个系统时钟周期
    
    /* 定义寄存器 */
    reg tx_enable_0;      // 用于判断是否开始新一轮工作的寄存器0
    reg tx_enable_1;      // 用于判断是否开始新一轮工作的寄存器1
    reg [31:0] clk_count; // 系统时钟计数器
    reg [3:0] tx_count;   // 发送数据计数器
    reg [7:0] tx_data;    // 发送数据寄存器
    reg tx_flag;          // 发送状态标志
    
    /* 定义线网 */
    wire start_flag; // 开始新一轮工作标志
    
    // start_flag用于检测接收到的【开始新一轮工作使能信号】的上升沿
    // 当前8位数据发送完成后，tx读入下一组8位数据并串行发送
    assign start_flag = (~tx_enable_1) & tx_enable_0;
    
    // 通过tx_enable接收到的数据先到达tx_enable_0，再到达tx_enable_1
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_enable_0 <= 1'b0;
            tx_enable_1 <= 1'b0;
        end
        else begin
            tx_enable_0 <= tx_enable;
            tx_enable_1 <= tx_enable_0;
        end
    end
    
    /* 开始新一轮工作使能检测与输入数据寄存 */
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_flag <= 1'b0;
            tx_data <= 8'd0;
        end
        else begin
            if (start_flag) begin        // 开始新一轮工作使能信号有效
                tx_flag <= 1'b1;         // 进入发送过程，发送状态标志信号tx_flag拉高
                tx_data <= uart_data_in; // 读入8位并行数据，存入寄存器tx_data
            end
            else if (tx_count == 4'd10) begin // 停止位发送完毕
                tx_flag  <= 1'b0;             // 退出发送过程
                tx_data	 <= 8'd0;             // 寄存器清空
            end
            else begin
                tx_flag  <= tx_flag;
                tx_data	 <= tx_data;
            end
        end
    end
    
    /* 系统时钟计数与发送数据计数 */
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            clk_count <= 32'd0;
            tx_count  <= 4'd0;
        end
        else if (tx_flag) begin                   // 处于发送过程
            if (clk_count < (CLK_GOAL - 1)) begin // 经过的时钟周期未达到需要发送下一个1 bit数据的时间
                clk_count <= clk_count + 1'b1;
                tx_count  <= tx_count;
            end
            else begin                        // 达到需要发送下一个1 bit数据的时间
                clk_count <= 32'd0;           // 系统时钟计数器清零，重新计数
                tx_count  <= tx_count + 1'b1; // 发送了1 bit数据，发送数据计数器加1
            end
        end
        else begin // 不处于发送过程
            clk_count <= 32'd0;
            tx_count  <= 4'd0;
        end
    end
    
    /* 串行发送数据 */
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            uart_txd <= 1'b1;
        end
        else if (tx_flag) begin // 处于发送过程
            case (tx_count)     // 根据发送数据计数器确定应该发送的数据是哪一位
                4'd0:
                uart_txd <= 1'b0; // 发送起始位
                4'd1:
                uart_txd <= tx_data[0]; // 发送数据最低位
                4'd2:
                uart_txd <= tx_data[1];
                4'd3:
                uart_txd <= tx_data[2];
                4'd4:
                uart_txd <= tx_data[3];
                4'd5:
                uart_txd <= tx_data[4];
                4'd6:
                uart_txd <= tx_data[5];
                4'd7:
                uart_txd <= tx_data[6];
                4'd8:
                uart_txd <= tx_data[7]; // 发送数据最高位
                default:
                uart_txd <= 1'b1; // 发送停止位
            endcase
        end
        else begin            // 不处于发送过程
            uart_txd <= 1'b1; // 不传输数据时，线路保持高电平
        end
    end
    
    /* 发送完成标志控制 */
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_done <= 1'b0;
        end
        else if (tx_count == 4'd10) begin // 停止位发送完毕，让64位转8位模块送来新的一组8位数据
            tx_done <= 1'b1;              // 发送完成标志输出一个高电平脉冲
        end
        else begin
            tx_done <= 1'b0;
        end
    end
    
endmodule // uart_tx
