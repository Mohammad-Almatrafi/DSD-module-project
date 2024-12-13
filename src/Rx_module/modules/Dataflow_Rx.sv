
module Dataflow_Rx #(
    parameter n = 8
) (
    clk,
    rst_n,
    Rx,
    parity_check,
    parity_type_even_odd,
    correct,
    out_buffer,
    Rx_idle
);

  input clk, rst_n;
  logic count_delay_eq, en_with_nTx, count_size_eq, count_delay_rst_n, count_delay_en;
  logic count_size_rst_n, count_size_en, shift_reg_en, shift_reg_rst_n;
  logic parity_FF_en, parity_FF_rst_n;
  logic choose_equality;
  output correct, Rx_idle;
  input Rx, parity_type_even_odd, parity_check;
  output [n-1:0] out_buffer;

  Datapath_Rx #(
      .msg_size(n)
  ) datapath (

      .clk(clk),
      .rst_n(rst_n),
      .Tx(Rx),
      .parity_type_even_odd(parity_type_even_odd),
      .parity_check(parity_check),
      .en_with_nTx(en_with_nTx),
      .count_delay_eq(count_delay_eq),
      .count_size_eq(count_size_eq),
      .count_delay_rst_n(count_delay_rst_n),
      .count_delay_en(count_delay_en),
      .count_size_rst_n(count_size_rst_n),
      .count_size_en(count_size_en),
      .shift_reg_en(shift_reg_en),
      .shift_reg_rst_n(shift_reg_rst_n),
      .parity_FF_en(parity_FF_en),
      .parity_FF_rst_n(parity_FF_rst_n),
      .choose_equality(choose_equality),
      .correct(correct),
      .out_buffer(out_buffer)
  );

  FSM_Rx fsm (
      .clk(clk),
      .rst_n(rst_n),
      .count_delay_eq(count_delay_eq),
      .count_size_eq(count_size_eq),
      .parity(parity_check),
      .count_delay_rst_n(count_delay_rst_n),
      .count_delay_en(count_delay_en),
      .count_size_rst_n(count_size_rst_n),
      .count_size_en(count_size_en),
      .shift_reg_en(shift_reg_en),
      .shift_reg_rst_n(shift_reg_rst_n),
      .parity_FF_en(parity_FF_en),
      .parity_FF_rst_n(parity_FF_rst_n),
      .en_with_nTx(en_with_nTx),
      .choose_equality(choose_equality)
  );
  assign Rx_idle = fsm.p_state == 1'd1;


endmodule
