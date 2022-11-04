module Full_Adder_tb;
 reg a,b,c_1;
 wire s,c;

 Full_Adder U0(a,b,c_1,s,c);

 initial begin
  a = 0; b = 0; c_1 = 0;
  #5 a = 0; b = 0; c_1 = 1;
  #5 a = 0; b = 1; c_1 = 0;
  #5 a = 0; b = 1; c_1 = 1;
  #5 a = 1; b = 0; c_1 = 0;
  #5 a = 1; b = 0; c_1 = 1;
  #5 a = 1; b = 1; c_1 = 0;
  #5 a = 1; b = 1; c_1 = 1;
  #5 a = 0; b = 0; c_1 = 0;
  #10 $stop;
 end

endmodule
