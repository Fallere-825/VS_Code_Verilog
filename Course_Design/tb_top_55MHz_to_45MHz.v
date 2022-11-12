`timescale  1ns / 1ps

module tb_top_55MHz_to_45MHz();
    
    // top_A Parameters
    parameter PERIOD_A   = 1000 / 55           ;
    parameter CLK_F_A    = 55_000_000          ;
    parameter UART_BPS_A = 115200              ;
    parameter CLK_GOAL_A = CLK_F_A / UART_BPS_A;
    
    // top_B Parameters
    parameter PERIOD_B   = 1000 / 45           ;
    parameter CLK_F_B    = 45_000_000          ;
    parameter UART_BPS_B = 115200              ;
    parameter CLK_GOAL_B = CLK_F_B / UART_BPS_B;
    
    // top_A Inputs
    reg   clk_A                = 0 ;
    reg   rst_n_A              = 0 ;
    reg   [63:0]  data_in_64_A = 0 ;
    reg   manual_start_A       = 0 ;
    reg   uart_rxd_A           = 0 ;
    
    // top_B Inputs
    reg   clk_B                = 0 ;
    reg   rst_n_B              = 0 ;
    reg   [63:0]  data_in_64_B = 0 ;
    reg   manual_start_B       = 0 ;
    
    // top_A Outputs
    wire  [63:0]  data_out_64_A                  ;
    wire  data_out_done_A                        ;
    
    // top_B Outputs
    wire  uart_txd_B                             ;
    wire  [63:0]  data_out_64_B                  ;
    wire  data_out_done_B                        ;
    
    
    /* 定义线网 */
    wire data; // top_A传输给top_B的1位数据
    
    
    initial
    begin
        forever #(PERIOD_A/2)  clk_A = ~clk_A;
    end
    
    initial
    begin
        forever #(PERIOD_B/2)  clk_B = ~clk_B;
    end
    
    top #(
    .CLK_F    (CLK_F_A),
    .UART_BPS (UART_BPS_A),
    .CLK_GOAL (CLK_GOAL_A))
    u_top_A (
    .clk                     (clk_A),
    .rst_n                   (rst_n_A),
    .data_in_64              (data_in_64_A     [63:0]),
    .manual_start            (manual_start_A),
    .uart_rxd                (uart_rxd_A),
    
    .uart_txd                (data),
    .data_out_64             (data_out_64_A    [63:0]),
    .data_out_done           (data_out_done_A)
    );
    
    top #(
    .CLK_F    (CLK_F_B),
    .UART_BPS (UART_BPS_B),
    .CLK_GOAL (CLK_GOAL_B))
    u_top_B (
    .clk                     (clk_B),
    .rst_n                   (rst_n_B),
    .data_in_64              (data_in_64_B     [63:0]),
    .manual_start            (manual_start_B),
    .uart_rxd                (data),
    
    .uart_txd                (uart_txd_B),
    .data_out_64             (data_out_64_B    [63:0]),
    .data_out_done           (data_out_done_B)
    );
    
    initial
    begin
        #20
        rst_n_A = 1'b1;
        rst_n_B = 1'b1;
        
        /* 传输第一个64位数据 */
        data_in_64_A   = 64'hcf9797fe562843e4;
        manual_start_A = 1;
        #40
        manual_start_A = 0;
        
        /* 传输第二个64位数据 */
        #86810
        data_in_64_A = 64'h97a495fb75590d72;
        
        /* 传输第三个64位数据 */
        #868100
        data_in_64_A = 64'he1725cf7c134253e;
        
        #868100
        #868100
        #40
        $stop;
    end
    
endmodule
