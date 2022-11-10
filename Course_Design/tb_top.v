`timescale  1ns / 1ps

module tb_top();
    
    // top Parameters
    parameter PERIOD   = 20;
    parameter CLK_F    = 50_000_000      ;
    parameter UART_BPS = 115200          ;
    parameter CLK_GOAL = CLK_F / UART_BPS;
    
    // top Inputs
    reg   clk                = 0 ;
    reg   rst_n              = 0 ;
    reg   [63:0]  data_in_64 = 0 ;
    reg   manual_start       = 0 ;
    
    // top Outputs
    wire  [63:0]  data_out_64                  ;
    wire  data_out_done                        ;
    
    
    /* 定义线网 */
    wire data; // tx传输给rx的1位数据
    
    
    initial
    begin
        forever #(PERIOD/2)  clk = ~clk;
    end
    
    top #(
    .CLK_F    (CLK_F),
    .UART_BPS (UART_BPS),
    .CLK_GOAL (CLK_GOAL))
    u_top (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .data_in_64              (data_in_64     [63:0]),
    .manual_start            (manual_start),
    .uart_rxd                (data),
    
    .uart_txd                (data),
    .data_out_64             (data_out_64    [63:0]),
    .data_out_done           (data_out_done)
    );
    
    initial
    begin
        #20
        rst_n = 1'b1;
        
        /* 传输第一个64位数据 */
        data_in_64   = 64'h2d7e66091ed0a403;
        manual_start = 1;
        #40
        manual_start = 0;
        
        /* 传输第二个64位数据 */
        #86810
        data_in_64 = 64'hd253328dd2c0fc3c;
        
        /* 传输第三个64位数据 */
        #868100
        data_in_64 = 64'h8162476652bdd1d0;
        
        #868100
        #868100
        #40
        $stop;
    end
    
endmodule
