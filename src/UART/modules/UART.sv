
module UART (
    clk,
    baud_rateSel,
    Tx,
    Rx,
    valid,
    correct,
    Rx_idle
);
  input [2:0] baud_rateSel;
  input clk, Tx;
  output valid, correct, Rx_idle;
  Baud_rate_gen clks (
      .select,
      .CLK100MHZ,
      .resetn,
      .Tx_clk,
      .Rx_clk
  );


endmodule
