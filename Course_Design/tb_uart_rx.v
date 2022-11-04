`timescale  1ns / 1ps

/* 串行接收模块testbench */

module tb_uart_rx();
    
    /* uart_rx Inputs */
    reg   clk      = 0 ; // 系统时钟
    reg   rst_n    = 0 ; // 复位信号，低电平有效
    reg   uart_rxd = 0 ; // UART接收端口
    
    /* uart_rx Outputs */
    wire  [7:0]  uart_data_out                     ; // 输出8位并行数据
    wire  uart_done                            ;     // 数据接收完成标志
    
    /* 产生50MHz系统时钟 */
    parameter PERIOD        = 20;
    always #(PERIOD/2)  clk = ~clk;
    
    
    uart_rx
    u_uart_rx (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .uart_rxd                (uart_rxd),
    
    .uart_data_out               (uart_data_out  [7:0]),
    .uart_done               (uart_done)
    );
    
    initial
    begin
        #20
        rst_n    = 1;
        uart_rxd = 1;
        #8681
        rst_n    = 1;
        uart_rxd = 1;
        
        #8681
        rst_n    = 1;
        uart_rxd = 0; // 起始位
        
        /* 传输11001001，从低位开始传输 */
        #8681
        rst_n    = 1;
        uart_rxd = 1; // 第一位
        #8681
        rst_n    = 1;
        uart_rxd = 0; // 第二位
        #8681
        rst_n    = 1;
        uart_rxd = 0; // 第三位
        #8681
        rst_n    = 1;
        uart_rxd = 1; // 第四位
        #8681
        rst_n    = 1;
        uart_rxd = 0; // 第五位
        #8681
        rst_n    = 1;
        uart_rxd = 0; // 第六位
        #8681
        rst_n    = 1;
        uart_rxd = 1; // 第七位
        #8681
        rst_n    = 1;
        uart_rxd = 1; // 第八位
        
        #8681
        rst_n    = 1;
        uart_rxd = 1; // 停止位
        
        #8681
        rst_n    = 1;
        uart_rxd = 1;
        #8681
        rst_n    = 1;
        uart_rxd = 1;
        
        /* 测试复位信号 */
        /* 以下测试部分的输入信号与上面测试部分的输入信号基本相同，区别是以下全程输入的复位信号都有效 */
        #8681
        rst_n    = 0; // 复位信号有效
        uart_rxd = 1;
        
        #8681
        rst_n    = 0;
        uart_rxd = 0; // 起始位
        
        /* 传输11001001，从低位开始传输 */
        #8681
        rst_n    = 0;
        uart_rxd = 1; // 第一位
        #8681
        rst_n    = 0;
        uart_rxd = 0; // 第二位
        #8681
        rst_n    = 0;
        uart_rxd = 0; // 第三位
        #8681
        rst_n    = 0;
        uart_rxd = 1; // 第四位
        #8681
        rst_n    = 0;
        uart_rxd = 0; // 第五位
        #8681
        rst_n    = 0;
        uart_rxd = 0; // 第六位
        #8681
        rst_n    = 0;
        uart_rxd = 1; // 第七位
        #8681
        rst_n    = 0;
        uart_rxd = 1; // 第八位
        
        #8681
        rst_n    = 0;
        uart_rxd = 1; // 停止位
        
        #8681
        rst_n    = 0;
        uart_rxd = 1;
        #8681
        rst_n    = 0;
        uart_rxd = 1;
        
        $stop;
    end
    
endmodule
