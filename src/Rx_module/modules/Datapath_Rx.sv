module Datapath_Rx #(
    parameter msg_size = 8
) (

    clk,
    rst_n,
    Tx,

    parity_type_even_odd,
    parity_check,
    en_with_nTx,
    count_delay_eq,
    count_size_eq,
    count_delay_rst_n,
    count_delay_en,
    count_size_rst_n,
    count_size_en,
    shift_reg_en,
    shift_reg_rst_n,
    parity_FF_en,
    parity_FF_rst_n,
    choose_equality,
    correct,
    out_buffer


);

  input clk, rst_n, Tx, choose_equality, en_with_nTx, parity_type_even_odd, parity_check;
  input count_delay_rst_n, count_delay_en, count_size_rst_n, count_size_en;
  input shift_reg_en, shift_reg_rst_n, parity_FF_en, parity_FF_rst_n;
  output count_delay_eq, count_size_eq;
  output correct;
  output [msg_size - 1:0] out_buffer;
  assign correct = (parity_bit ^ (^out_buffer) ^ parity_type_even_odd) | (~parity_check);
  shift_reg #(
      .n(msg_size)
  ) shift (
      .clk(clk),
      .rst_n(shift_reg_rst_n),
      .clear(1'b0),
      .en(shift_reg_en & count_delay_eq),
      .in(Tx),
      .q(out_buffer)
  );

  DFF D (
      .clk(clk),
      .rst_n(parity_FF_rst_n),
      .clear(1'b0),
      .en(parity_FF_en & count_delay_eq),
      .d(Tx),
      .q(parity_bit)
  );
  // shift reg is needed
  Counter_n_bit #(
      .n(4)
  ) delay_counter (
      .clk(clk),
      .resetn(count_delay_rst_n & (~en_with_nTx | ~Tx)),
      .clear(counter_delay_clear),
      .count_en(count_delay_en | (en_with_nTx & ~Tx)),
      .Q(count_delay)
  );

  logic counter_delay_clear;
  logic [3:0] count_delay;
  assign counter_delay_clear = choose_equality ? count_delay == 4'd15 : count_delay == 4'd7;
  assign count_delay_eq = counter_delay_clear;
  assign count_size_eq = counter_size == (msg_size - 1);
  parameter counter_size_size = $clog2(msg_size);
  logic [counter_size_size-1:0] counter_size;
  Counter_n_bit #(
      .n(counter_size_size)
  ) size_counter (
      .clk(clk),
      .resetn(count_size_rst_n),
      .clear(1'b0),
      .count_en(count_size_en & count_delay_eq),
      .Q(counter_size)
  );

endmodule
