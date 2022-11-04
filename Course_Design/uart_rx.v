`timescale 1ns/1ps

/* 串行接收模块 */

module uart_rx (output reg [7:0] uart_data_out, // 输出8位并行数据
                output reg uart_done,           // 数据接收完成标志
                input wire clk,                 // 系统时钟
                input wire rst_n,               // 复位信号，低电平有效
                input wire uart_rxd);           // UART接收端口

/* 定义参数 */
parameter CLK_F    = 50_000_000;       // 系统时钟频率
parameter UART_BPS = 115200;           // 串口波特率
parameter CLK_GOAL = CLK_F / UART_BPS; // 1 bit数据持续多少个系统时钟周期

/* 定义寄存器 */
reg uart_rxd_1;       // 用于判断接收是否开始的寄存器
reg [31:0] clk_count; // 系统时钟计数器
reg [3:0] rx_count;   // 接收数据计数器
reg [7:0] rx_data;    // 接收数据寄存器
reg rx_flag;          // 接收状态标志

/* 定义线网 */
wire start_flag; // 开始接收数据标志

// start_flag用于检测接收到的下降沿，即检测起始位0
assign start_flag = uart_rxd_1 & (~uart_rxd);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        uart_rxd_1 <= 1'b1;
    end
    else begin
        uart_rxd_1 <= uart_rxd;
    end
end

/* 起始位检测 */
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rx_flag <= 1'b0;
    end
    else begin
        if (start_flag) begin // 检测到起始位
            rx_flag <= 1'b1;  // 进入接收过程，接收状态标志信号rx_flag拉高
        end
        else if (rx_count == 4'd10) begin // 停止位接收完毕
            rx_flag <= 1'b0;              // 停止接收数据
        end
        else begin
            rx_flag <= rx_flag;
        end
    end
end

/* 系统时钟计数与接收数据计数 */
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        clk_count <= 32'd0;
        rx_count  <= 4'd0;
    end
    else if (rx_flag) begin                   // 处于接收过程
        if (clk_count < (CLK_GOAL - 1)) begin // 经过的时钟周期未达到需要接收下一个1 bit数据的时间
            clk_count <= clk_count + 1'b1;
            rx_count  <= rx_count;
        end
        else begin                        // 达到需要接收下一个1 bit数据的时间
            clk_count <= 32'd0;           // 系统时钟计数器清零，重新计数
            rx_count  <= rx_count + 1'b1; // 接收到1 bit数据，接收数据计数器加1
        end
    end
    else begin // 不处于接收过程
        clk_count <= 32'd0;
        rx_count  <= 4'd0;
    end
end

/* 串行接收数据 */
// 1 bit数据会保持CLK_GOAL个系统时钟周期，在中间CLK_GOAL / 2处进行数据采样
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rx_data <= 8'd0;
    end
    else if (rx_flag) begin                    // 处于接收过程
        if (clk_count == (CLK_GOAL / 2)) begin // 达到数据采样时刻
            case (rx_count)
                4'd1:
                rx_data[0] <= uart_rxd; // 寄存数据最低位
                4'd2:
                rx_data[1] <= uart_rxd;
                4'd3:
                rx_data[2] <= uart_rxd;
                4'd4:
                rx_data[3] <= uart_rxd;
                4'd5:
                rx_data[4] <= uart_rxd;
                4'd6:
                rx_data[5] <= uart_rxd;
                4'd7:
                rx_data[6] <= uart_rxd;
                4'd8:
                rx_data[7] <= uart_rxd; // 寄存数据最高位
                default:
                rx_data <= rx_data;
            endcase
        end
        else begin // 未达到数据采样时刻
            rx_data <= rx_data;
        end
    end
    else begin // 不处于接收过程
        rx_data <= 8'd0;
    end
end

/* 数据接收完成标志控制与数据输出 */
// 数据接收完成后给出标志信号，并输出寄存器rx_data中接收到的新的8 bit数据
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        uart_data_out <= 8'd0;
        uart_done     <= 1'b0;
    end
    else if (rx_count == 4'd10) begin // 接收完起始位 + 8 bit数据 + 停止位
        uart_data_out <= rx_data;     // 输出寄存器rx_data中接收到的新的8 bit数据
        uart_done     <= 1'b1;        // 数据接收完成标志信号拉高，输出一个高电平脉冲
    end
    else begin
        uart_data_out <= uart_data_out;
        uart_done     <= 1'b0;
    end
end

endmodule // uart_rx
