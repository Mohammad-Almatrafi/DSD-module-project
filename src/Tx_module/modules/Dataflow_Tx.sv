module Dataflow_Tx #(
    parameter n = 8
) (

    clk,
    rst_n,
    start_sig,
    D,
    Tx
);

  input logic clk, rst_n, start_sig;
  input logic [n-1:0] D;
  output Tx;

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
      .mux_s(mux_s)

  );


endmodule
