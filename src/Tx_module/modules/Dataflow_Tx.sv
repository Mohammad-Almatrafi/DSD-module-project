module Dataflow_Tx #(
    parameter n = 8
    // 1 even / 0 odd
) (
    clk,
    rst_n,
    start_sig,
    D,
    Tx,
    parity_check,
    parity_type_even_odd,
    valid
);
  input logic parity_type_even_odd;
  input logic clk, rst_n, start_sig, parity_check;
  input logic [n-1:0] D;
  output Tx, valid;

  Datapath_Tx #(
      .n(n)
  ) Datapath (
      .clk(clk),
      .resetn(rst_n),
      .D(D),
      .reg_en(buffer_en),
      .reset_reg(buffer_rst_n),
      .reset_count(counter_rst_n),
      .count_en(counter_en),
      .mux2_sl(mux_s),
      .Tx_out(Tx),
      .parity_type_even_odd(parity_type_even_odd),
      .count_eq_size(count_eq_size)
  );

  logic count_eq_size, buffer_en, buffer_rst_n, counter_rst_n, counter_en;
  logic [1:0] mux_s;

  FSM_Tx fsm (
      .clk(clk),
      .rst_n(rst_n),
      .start_sig(start_sig),
      .count_eq_size(count_eq_size),
      .buffer_en(buffer_en),
      .buffer_rst_n(buffer_rst_n),
      .counter_rst_n(counter_rst_n),
      .counter_en(counter_en),
      .mux_s(mux_s),
      .parity_check(parity_check),
      .valid(valid)
  );


endmodule
