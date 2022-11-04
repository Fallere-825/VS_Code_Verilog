`timescale 1ns/1ps

module data_out_8_to_64 (output reg [63:0] data_64,
                         input wire clk,
                         input wire rst_n,
                         input wire [7:0] data_8,
                         input wire data_out_enable);

reg [3:0] state;
reg   data_out_enable_1;

/* 定义线网 */
wire start_flag; // 开始发送数据标志

// start_flag用于检测接收到的上升沿，即检测接收端rx数据接收完成标志
// 接收端rx接收数据完成后，发送端tx就可以发送下一组数据
assign start_flag = (~data_out_enable_1) & data_out_enable;

// 通过uart_enable接收到的数据先到达uart_enable_0，再到达uart_enable_1
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out_enable_1 <= 1'b0;
    end
    else begin
        data_out_enable_1 <= data_out_enable;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= 4'd0;
    end
    else begin
        if (start_flag) begin
            if (state == 4'd7) begin
                state <= 4'd0;
            end
            else begin
                state <= state +1'b1;
            end
        end
        else begin
            state <= state;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_64 <= 64'd0;
    end
    else begin
        if (start_flag) begin
            case (state)
                4'd0:
                data_64[7:0] <= data_8;
                4'd1:
                data_64[15:8] <= data_8;
                4'd2:
                data_64[23:16] <= data_8;
                4'd3:
                data_64[31:24] <= data_8;
                4'd4:
                data_64[39:32] <= data_8;
                4'd5:
                data_64[47:40] <= data_8;
                4'd6:
                data_64[55:48] <= data_8;
                4'd7:
                data_64[63:56] <= data_8;
                default:
                data_64 <= data_64;
            endcase
        end
    end
end

endmodule // data_out_8_to_64

