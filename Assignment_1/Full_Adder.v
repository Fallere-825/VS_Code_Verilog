module Full_Adder(a,b,c_1,s,c);
  input a,b,c_1;
  output s,c;

  wire s,c;

  assign s = a^b^c_1;
  assign c = ((a^b)&c_1)|(a&b);

endmodule
