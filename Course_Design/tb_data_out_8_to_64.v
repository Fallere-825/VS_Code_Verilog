`timescale  1ns / 1ps

module tb_data_out_8_to_64();
    
    // data_out_8_to_64 Parameters
    parameter PERIOD = 20;
    
    
    // data_out_8_to_64 Inputs
    reg   clk             = 0 ;
    reg   rst_n           = 0 ;
    reg   [7:0]  data_8   = 0 ;
    reg   data_out_enable = 0 ;
    
    // data_out_8_to_64 Outputs
    wire  [63:0]  data_64                      ;
    wire  data_out_done                        ;
    
    
    initial
    begin
        forever #(PERIOD/2)  clk = ~clk;
    end
    
    data_out_8_to_64  u_data_out_8_to_64 (
    .clk                     (clk),
    .rst_n                   (rst_n),
    .data_8                  (data_8           [7:0]),
    .data_out_enable         (data_out_enable),
    
    .data_64                 (data_64          [63:0]),
    .data_out_done           (data_out_done)
    );
    
    initial
    begin
        #20
        rst_n = 1;
        
        
        /* 测试收取一个64位数据 */
        /* 收取第一组8位数据 */
        data_8          = 8'hd7;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第二组8位数据 */
        #86810
        data_8          = 8'ha7;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第三组8位数据 */
        #86810
        data_8          = 8'h01;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第四组8位数据 */
        #86810
        data_8          = 8'ha0;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第五组8位数据 */
        #86810
        data_8          = 8'hc4;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第六组8位数据 */
        #86810
        data_8          = 8'h04;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第七组8位数据 */
        #86810
        data_8          = 8'h27;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第八组8位数据 */
        #86810
        data_8          = 8'hcb;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        
        /* 下面测试收取第二个64位数据，过程与上面相同 */
        /* 收取第一组8位数据 */
        #86810
        data_8          = 8'h46;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第二组8位数据 */
        #86810
        data_8          = 8'h4d;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第三组8位数据 */
        #86810
        data_8          = 8'h74;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第四组8位数据 */
        #86810
        data_8          = 8'h9a;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第五组8位数据 */
        #86810
        data_8          = 8'hfa;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第六组8位数据 */
        #86810
        data_8          = 8'h03;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第七组8位数据 */
        #86810
        data_8          = 8'h74;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        /* 收取第八组8位数据 */
        #86810
        data_8          = 8'h23;
        data_out_enable = 1;
        #40
        data_out_enable = 0;
        
        
        #86810
        #40
        $stop;
    end
    
endmodule
