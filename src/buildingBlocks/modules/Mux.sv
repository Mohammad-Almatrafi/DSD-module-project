`timescale 1ns / 1ps

module Mux #(
    parameter bits = 8,
    selectBits = 3
) (
    input logic [bits-1:0] d[(2**selectBits)-1:0],
    input logic [selectBits-1:0] s,
    output logic [bits-1:0] y
);

  // assign y = s ? d[1]:d[0];
  always @(*) begin
    y = d[s];
  end

endmodule
