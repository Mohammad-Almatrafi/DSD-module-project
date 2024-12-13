// `include "MUX_n_bit.sv"
module Datapath_Tx #(
    parameter n = 8
) (
    input clk,
    input parity_type_even_odd,  // 1 even / 0 odd
    input resetn,
    input [n-1:0] D,
    input reg_en,
    input reset_reg,
    input reset_count,
    input count_en,
    input [1:0] mux2_sl,
    output Tx_out,
    output count_eq_size
);

  localparam m = $clog2(n);
  logic [n-1:0] reg_out;
  logic [$clog2(n)-1:0] count_out;
  logic parity_bit;
  assign parity_bit = (~parity_type_even_odd) ^ (^reg_out);

  Reg_n_bit #(
      .n(n)
  ) reg_tx (
      .clk(clk),
      .resetn(resetn & reset_reg),
      .reg_en(reg_en),
      .D(D),
      .Q(reg_out)
  );

  Counter_n_bit #(
      .n(n)
  ) counter_tx (
      .clk(clk),
      .resetn(resetn & reset_count),
      .clear(1'b0),
      .count_en(count_en),
      .Q(count_out)
  );

  assign count_eq_size = count_out == (n - 1);
  logic [m-1 : 0] mux1_s;
  logic [n-1:0] mux1_i;
  logic mux1_out;
  assign mux1_i = {'b0, reg_out};
  assign mux1_s = count_out;

  MUX_n_bit #(
      .n(m)
  ) mux_tx1 (
      .s  (mux1_s),
      .i  (mux1_i),
      .out(mux1_out)
  );

  logic [1:0] mux2_s;
  logic [3:0] mux2_i;
  logic mux2_out;
  assign mux2_s = mux2_sl;
  assign mux2_i[0] = 1'b0;
  assign mux2_i[1] = 1'b1;
  assign mux2_i[2] = mux1_out;
  assign mux2_i[3] = parity_bit;
  assign mux2_out = mux2_i[mux2_s];


  assign Tx_out = mux2_out;

endmodule
