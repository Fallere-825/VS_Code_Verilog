`timescale  1ns / 1ps

/* 串行发送模块testbench */

module tb_uart_tx();
    
    /* uart_tx Inputs */
    reg   clk                 = 0 ; // 系统时钟
    reg   rst_n               = 0 ; // 复位信号，低电平有效
    reg   uart_enable         = 0 ; // 发送使能信号
    reg   [7:0]  uart_data_in = 0 ; // 输入8位并行数据
    reg   [7:0] rx_check      = 0 ;
    
    // uart_tx Outputs
    wire  uart_txd                             ;
    wire  tx_done                              ;
    
    integer i = 0;
    
    parameter BIT_PERIOD = 8681;
    
    /* 产生50MHz系统时钟 */
    parameter PERIOD        = 20;
    always #(PERIOD/2)  clk = ~clk;
    
    
    uart_tx
    u_uart_tx (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .uart_enable             (uart_enable),
    .uart_data_in            (uart_data_in  [7:0]),
    
    .uart_txd                (uart_txd),
    .tx_done                 (tx_done)
    );
    
    initial
    begin
        /* 传输11001001 */
        #20
        rst_n        = 1;
        uart_data_in = 8'b1100_1001;
        uart_enable  = 1;
        #8681
        rst_n        = 1;
        uart_data_in = 8'd0;
        uart_enable  = 0;
        
        /* 传输10010011 */
        #(8681 * 9)
        #40
        rst_n        = 1;
        uart_data_in = 8'b1100_1001;
        uart_enable  = 1;
        #8681
        rst_n        = 1;
        uart_data_in = 8'b1100_1001;
        uart_enable  = 0;
        
        /* 测试复位信号，本部分中复位信号一直有效 */
        #86810
        rst_n        = 0;
        uart_data_in = 8'b1100_1001;
        uart_enable  = 1;
        #8681
        rst_n        = 0;
        uart_data_in = 8'b1100_1001;
        uart_enable  = 0;
        
        /* 测试发送使能信号 */
        /* 本部分中虽然送入了8位并行数据，但发送使能信号没有上升沿 */
        #86810
        rst_n        = 1;
        uart_data_in = 8'b1100_1001;
        uart_enable  = 0;
        #8681
        $stop;
    end
    
    always @(posedge clk) begin
        wait (uart_txd == 0);
        rx_check <= 7'd0;
        #(BIT_PERIOD)
        #(BIT_PERIOD / 2)
        
        for (i = 0; i < 8; i = i + 1) begin
            rx_check[i] <= uart_txd;
            if (i < 7) begin
                #(BIT_PERIOD);
            end
        end
    end
    
endmodule
