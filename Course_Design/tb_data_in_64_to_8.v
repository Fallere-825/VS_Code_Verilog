`timescale  1ns / 1ps

module tb_data_in_64_to_8();
    
    // data_in_64_to_8 Parameters
    parameter PERIOD = 20;
    
    
    // data_in_64_to_8 Inputs
    reg   clk             = 0 ;
    reg   rst_n           = 0 ;
    reg   [63:0]  data_64 = 0 ;
    reg   data_in_enable  = 0 ;
    reg   manual_start    = 0 ;
    
    // data_in_64_to_8 Outputs
    wire  [7:0]  data_8                        ;
    wire  tx_enable                            ;
    
    
    initial
    begin
        forever #(PERIOD/2)  clk = ~clk;
    end
    
    data_in_64_to_8  u_data_in_64_to_8 (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .data_64                 (data_64         [63:0]),
    .data_in_enable          (data_in_enable),
    .manual_start            (manual_start),
    
    .data_8                  (data_8          [7:0]),
    .tx_enable               (tx_enable)
    );
    
    initial
    begin
        #20
        rst_n = 1;
        
        
        /* 测试传输一个64位数据 */
        /* 传输第一组8位数据 */
        data_64      = 64'hbb941c2b7e1d731b;
        manual_start = 1;
        #40
        manual_start = 0;
        
        /* 传输第二组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第三组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第四组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第五组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第六组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第七组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第八组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        
        /* 下面测试传输第二个64位数据，过程与上面相同 */
        /* 传输第一组8位数据 */
        #86810
        data_64        = 64'hbca16b888f3cafb4;
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第二组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第三组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第四组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第五组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第六组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第七组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        /* 传输第八组8位数据 */
        #86810
        data_in_enable = 1;
        #40
        data_in_enable = 0;
        
        
        #86810
        $stop;
    end
    
endmodule
