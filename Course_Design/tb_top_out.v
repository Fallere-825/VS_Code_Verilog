`timescale  1ns / 1ps

module tb_top_out();
    
    // top_out Parameters
    parameter PERIOD   = 20;
    parameter CLK_F    = 50_000_000      ;
    parameter UART_BPS = 115200          ;
    parameter CLK_GOAL = CLK_F / UART_BPS;
    
    // top_out Inputs
    reg   clk      = 0 ;
    reg   rst_n    = 0 ;
    reg   uart_rxd = 0 ;
    
    // top_out Outputs
    wire  [63:0]  data_64                      ;
    wire  data_out_done                        ;
    
    
    initial
    begin
        forever #(PERIOD/2)  clk = ~clk;
    end
    
    initial
    begin
        #(PERIOD*2) rst_n = 1;
    end
    
    top_out #(
    .CLK_F    (CLK_F),
    .UART_BPS (UART_BPS),
    .CLK_GOAL (CLK_GOAL))
    u_top_out (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .uart_rxd                (uart_rxd),
    
    .data_64                 (data_64        [63:0]),
    .data_out_done           (data_out_done)
    );
    
    initial
    begin
        #20
        rst_n    = 1;
        uart_rxd = 1;
        
        
        /* 收取一个64位数据91ef9be64104fb5d（1001_0001_1110_1111_1001_1011_1110_0110_0100_0001_0000_0100_1111_1011_0101_1101），从低位开始收取 */
        /* 收取第一组8位数据 */
        #8681
        uart_rxd = 0; // 起始位
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1; // 终止位
        
        #40 // 传输两个8位数据之间的时间间隔
        
        /* 收取第二组8位数据 */
        #8681
        uart_rxd = 0; // 起始位
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1; // 终止位
        
        #40 // 传输两个8位数据之间的时间间隔
        
        /* 收取第三组8位数据 */
        #8681
        uart_rxd = 0; // 起始位
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1; // 终止位
        
        #40 // 传输两个8位数据之间的时间间隔
        
        /* 收取第四组8位数据 */
        #8681
        uart_rxd = 0; // 起始位
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1; // 终止位
        
        #40 // 传输两个8位数据之间的时间间隔
        
        /* 收取第五组8位数据 */
        #8681
        uart_rxd = 0; // 起始位
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1; // 终止位
        
        #40 // 传输两个8位数据之间的时间间隔
        
        /* 收取第六组8位数据 */
        #8681
        uart_rxd = 0; // 起始位
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1; // 终止位
        
        #40 // 传输两个8位数据之间的时间间隔
        
        /* 收取第七组8位数据 */
        #8681
        uart_rxd = 0; // 起始位
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1; // 终止位
        
        #40 // 传输两个8位数据之间的时间间隔
        
        /* 收取第八组8位数据 */
        #8681
        uart_rxd = 0; // 起始位
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 0;
        #8681
        uart_rxd = 1;
        #8681
        uart_rxd = 1; // 终止位
        
        
        #86810
        #40
        $stop;
    end
    
endmodule
