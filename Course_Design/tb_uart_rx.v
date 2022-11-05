`timescale  1ns / 1ps

module tb_uart_rx();
    
    // uart_rx Parameters
    parameter PERIOD   = 20              ;
    parameter CLK_F    = 50_000_000      ;
    parameter UART_BPS = 115200          ;
    parameter CLK_GOAL = CLK_F / UART_BPS;
    
    // uart_rx Inputs
    reg   clk      = 0 ;
    reg   rst_n    = 0 ;
    reg   uart_rxd = 0 ;
    
    // uart_rx Outputs
    wire  [7:0]  uart_data_out                 ;
    wire  uart_done                            ;
    
    
    initial
    begin
        forever #(PERIOD/2)  clk = ~clk;
    end
    
    initial
    begin
        #(PERIOD*2) rst_n = 1;
    end
    
    uart_rx #(
    .CLK_F    (CLK_F),
    .UART_BPS (UART_BPS),
    .CLK_GOAL (CLK_GOAL))
    u_uart_rx (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .uart_rxd                (uart_rxd),
    
    .uart_data_out           (uart_data_out  [7:0]),
    .uart_done               (uart_done)
    );
    
    initial
    begin
        #20
        rst_n    = 1;
        uart_rxd = 1;
        
        /* 传输1011_1101，从低位开始传输 */
        #8681
        uart_rxd = 0; // 起始位
        #8681
        uart_rxd = 1; // 第一位
        #8681
        uart_rxd = 0; // 第二位
        #8681
        uart_rxd = 1; // 第三位
        #8681
        uart_rxd = 1; // 第四位
        #8681
        uart_rxd = 1; // 第五位
        #8681
        uart_rxd = 1; // 第六位
        #8681
        uart_rxd = 0; // 第七位
        #8681
        uart_rxd = 1; // 第八位
        #8681
        uart_rxd = 1; // 停止位
        
        /* 无数据传输 */
        #8681
        uart_rxd = 1; // 线上保持高电平
        
        /* 传输0110_1110，从低位开始传输 */
        #8681
        uart_rxd = 0; // 起始位
        #8681
        uart_rxd = 0; // 第一位
        #8681
        uart_rxd = 1; // 第二位
        #8681
        uart_rxd = 1; // 第三位
        #8681
        uart_rxd = 1; // 第四位
        #8681
        uart_rxd = 0; // 第五位
        #8681
        uart_rxd = 1; // 第六位
        #8681
        uart_rxd = 1; // 第七位
        #8681
        uart_rxd = 0; // 第八位
        #8681
        uart_rxd = 1; // 停止位
        
        /* 无数据传输 */
        #8681
        uart_rxd = 1; // 线上保持高电平
        
        /* 传输1010_1011，从低位开始传输 */
        #8681
        uart_rxd = 0; // 起始位
        #8681
        uart_rxd = 1; // 第一位
        #8681
        uart_rxd = 1; // 第二位
        #8681
        uart_rxd = 0; // 第三位
        #8681
        uart_rxd = 1; // 第四位
        #8681
        uart_rxd = 0; // 第五位
        #8681
        uart_rxd = 1; // 第六位
        #8681
        uart_rxd = 0; // 第七位
        #8681
        uart_rxd = 1; // 第八位
        #8681
        uart_rxd = 1; // 停止位
        
        #86810
        #40
        $stop;
    end
    
endmodule
