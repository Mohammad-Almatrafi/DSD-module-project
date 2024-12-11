module Reg_n_bit #(
    parameter n = 8
) (
    input clk,
    input resetn,
    input reg_en,
    input [n-1:0] D,
    output logic [n-1:0] Q
);

  always @(posedge clk or negedge resetn) begin

    if (~resetn) Q <= 'b0;
    else if (reg_en) Q <= D;

  end



endmodule
