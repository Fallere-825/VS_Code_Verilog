`timescale  1ns / 1ps

module tb_uart_tx_to_rx();
    
    // uart_tx_to_rx Parameters
    parameter PERIOD = 20;
    
    
    // uart_tx_to_rx Inputs
    reg   clk                 = 0 ;
    reg   rst_n               = 0 ;
    reg   manual_start        = 0 ;
    reg   [7:0]  uart_data_in = 0 ;
    
    // uart_tx_to_rx Outputs
    wire  [7:0]  uart_data_out                 ;
    wire  uart_done                            ;
    wire  tx_done                              ;
    
    
    
    always #(PERIOD/2)  clk = ~clk;
    
    
    uart_tx_to_rx  u_uart_tx_to_rx (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .manual_start            (manual_start),
    .uart_data_in            (uart_data_in   [7:0]),
    
    .uart_data_out           (uart_data_out  [7:0]),
    .uart_done               (uart_done),
    .tx_done                 (tx_done)
    );
    
    initial
    begin
        /* 传输11001001 */
        #20
        rst_n        = 1;
        uart_data_in = 8'b1100_1001;
        manual_start = 1;
        #8681
        rst_n        = 1;
        uart_data_in = 8'd0;
        manual_start = 0;
        
        /* 传输10010011 */
        #(8681 * 9)
        #40
        rst_n        = 1;
        uart_data_in = 8'b1100_1001;
        manual_start = 1;
        #8681
        rst_n        = 1;
        uart_data_in = 8'b1100_1001;
        manual_start = 0;
        
        /* 测试复位信号，本部分中复位信号一直有效 */
        #86810
        rst_n        = 0;
        uart_data_in = 8'b1100_1001;
        manual_start = 1;
        #8681
        rst_n        = 0;
        uart_data_in = 8'b1100_1001;
        manual_start = 0;
        
        /* 测试发送使能信号 */
        /* 本部分中虽然送入了8位并行数据，但发送使能信号没有上升沿 */
        #86810
        rst_n        = 1;
        uart_data_in = 8'b1100_1001;
        manual_start = 0;
        #8681
        $stop;
    end
    
endmodule
