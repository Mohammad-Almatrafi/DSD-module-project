
`timescale 1ns / 1ps

module fibbonacciDataProgram (
    input  [3:0] s,
    output [7:0] inst
);
  logic [7:0] out;
  assign inst = out;

  always @(s) begin
    case (s)
      0:  out = 8'b0000_1001;  //RA = 1
      1:  out = 8'b1111_1001;  //[1] = RA
      2:  out = 8'b1100_1000;  //RA = 0
      3:  out = 8'b1111_1010;  //[2] = RA
      4:  out = 8'b0010_0000;  //RO = RA
      5:  out = 8'b1100_1001;  //RA = [1]
      6:  out = 8'b1101_1010;  //RB = [2]
      7:  out = 8'b0010_0000;  //RO = RA
      8:  out = 8'b1111_1010;  //[2] = RA
      9:  out = 8'b0000_0000;  //RA = RA+RB
      10: out = 8'b0111_0000;  //JC 0
      11: out = 8'b1011_0110;  //J 6
    endcase
  end

endmodule
