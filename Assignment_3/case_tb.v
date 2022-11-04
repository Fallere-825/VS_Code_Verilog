`timescale  1ns / 1ps

module tb_case_compare();
    
    // case_compare Inputs
    reg   [1:0]  sel   = 0 ;
    reg   [1:0]  z_sel = 0 ;
    reg   [1:0]  x_sel = 0 ;
    
    // case_compare Outputs
    wire  [1:0]  y                             ;
    wire  [1:0]  z_y                           ;
    wire  [1:0]  x_y                           ;
    
    
    case_compare  u_case_compare (
    .sel                     (sel    [1:0]),
    .z_sel                   (z_sel  [1:0]),
    .x_sel                   (x_sel  [1:0]),
    
    .y                       (y      [1:0]),
    .z_y                     (z_y    [1:0]),
    .x_y                     (x_y    [1:0])
    );
    
    initial
    begin
        #5 sel = 2'b01;
        z_sel  = 2'b01;
        x_sel  = 2'b01;
        #5 sel = 2'b10;
        z_sel  = 2'b10;
        x_sel  = 2'b10;
        #5 sel = 2'b11;
        z_sel  = 2'b11;
        x_sel  = 2'b11;
        #5 sel = 2'b1z;
        z_sel  = 2'b1z;
        x_sel  = 2'b1z;
        #5 sel = 2'b1x;
        z_sel  = 2'b1x;
        x_sel  = 2'b1x;
        #5 $stop;
    end
    
endmodule
