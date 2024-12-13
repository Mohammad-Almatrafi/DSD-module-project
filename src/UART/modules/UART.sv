
module UART #(
    parameter n = 8
) (
    clk,
    rst_n,
    baud_rateSel,
    start_send,
    send_msg_content,
    include_parity,
    parity_type,
    Tx,
    Rx,
    valid,
    correct,
    Rx_idle,
    recive_msg_content
);

  input [2:0] baud_rateSel;
  input start_send, include_parity, parity_type;
  input [n-1:0] send_msg_content;
  input clk, rst_n, Rx;
  output Tx;
  output valid, correct, Rx_idle;
  output [n-1:0] recive_msg_content;
  logic Tx_clk, Rx_clk;

  Baud_rate_gen clks (
      .select(baud_rateSel),
      .CLK100MHZ(clk),
      .resetn(rst_n),
      .Tx_clk(Tx_clk),
      .Rx_clk(Rx_clk)
  );




  Dataflow_Rx #(
      .n(n)
  ) Rx_mod (
      .clk(Rx_clk),
      .rst_n(rst_n),
      .Rx(Rx),
      .parity_check(include_parity),
      .parity_type_even_odd(parity_type),
      .correct(correct),
      .out_buffer(recive_msg_content),
      .Rx_idle(Rx_idle)
  );
  Dataflow_Tx #(
      .n(n)
      // 1 even / 0 odd
  ) Tx_module (
      .clk(Tx_clk),
      .rst_n(rst_n),
      .start_sig(start_send),
      .D(send_msg_content),
      .Tx(Tx),
      .parity_check(include_parity),
      .parity_type_even_odd(parity_type),
      .valid(valid)
  );

endmodule
