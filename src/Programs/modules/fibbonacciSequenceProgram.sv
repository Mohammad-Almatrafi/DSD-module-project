`timescale 1ns / 1ps

module fibbonacciSequenceProgram (
    input  [3:0] s,
    output [7:0] inst
);
  logic [7:0] out;
  assign inst = out;

  always @(s) begin
    case (s)
      0: out = 8'b0000_1000; // Ra = 0
      1: out = 8'b0001_1001; // Rb = 1
      2: out = 8'b0010_0000; // Ro = Ra
      3: out = 8'b0001_0000; // Rb = Ra + Rb
      4: out = 8'b0111_0000; // JC 0
      5: out = 8'b0000_0000; // Ra = Ra + Rb
      6: out = 8'b0001_0100; // Rb = Ra - Rb
      7: out = 8'b0000_0100; // Ra = Ra - Rb
      8: out = 8'b1011_0010; // J 2
    endcase
  end

endmodule
