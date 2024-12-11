`timescale 1ns / 1ps

module Decoder #(
    parameter bits = 2
) (
    input [bits-1:0] i,
    input en,
    output reg [2**bits-1:0] out
);

  always @(*) begin
    out = '0;
    if (en) begin
      out[i] = 1'b1;
    end
  end

endmodule
