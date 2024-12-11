
`timescale 1ns / 1ps

module DataTransferProgram (
    input  [3:0] s,
    output [7:0] inst
);
  logic [7:0] out;
  assign inst = out;

  always @(s) begin
    case (s)
      0:  out = {4'h0, {1'b1, 3'd2}}; // Ra = 2
      1:  out = {4'hf, {1'b1, 3'd0}}; // [0] = Ra
      2:  out = {4'h0, {1'b1, 3'd5}}; // Ra = 5
      3:  out = {4'hf, {1'b1, 3'd1}}; // [1] = Ra
      4:  out = {4'hc, {1'b1, 3'd0}}; // Ra = [0]
      5:  out = {4'h2, {1'b0, 3'd0}}; // Ro = Ra
      6:  out = {4'hc, {1'b1, 3'd1}}; // Ra = [1]
      7:  out = {4'h2, {1'b0, 3'd0}}; // Ro = Ra
      8:  out = {4'h1, {1'b1, 3'd5}}; // Rb = 5
      9:  out = {4'h0, {1'b0, 3'd4}}; // Ra = Ra - Rb
      10: out = {8'hf, {1'b0, 3'd0}}; // Jz 0
    endcase
  end

endmodule
