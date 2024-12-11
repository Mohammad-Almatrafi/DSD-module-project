module Baud_rate_gen #(
    parameter select = 0
) (
    input  CLK100MHZ,
    input  resetn,
    output Tx_clk,
    output Rx_clk
);

  logic [11:0] count_lim;
  // for baud rate 1200 divider select = 0
  // for baud rate 2400 divider select = 1
  // for baud rate 4800 divider select = 2
  // for baud rate 9600 divider select = 3
  // for baud rate 19200 divider select = 4
  // for baud rate 38400 divider select = 5
  // for baud rate 57600 divider select = 6
  // for baud rate 115200 divider select = 7 
  logic [11:0] Baud_rates[7:0];
  assign Baud_rates[0] = 12'd2604;
  assign Baud_rates[1] = 12'd1302;
  assign Baud_rates[2] = 12'd651;
  assign Baud_rates[3] = 12'd326;
  assign Baud_rates[4] = 12'd162;
  assign Baud_rates[5] = 12'd82;
  assign Baud_rates[6] = 12'd54;
  assign Baud_rates[7] = 12'd27;

  assign count_lim = Baud_rates[select];

  clk_div tx_clk (
      .CLK100MHZ(Rx_clk),
      .resetn(resetn),
      .count_lim('d8),
      .clk(Tx_clk)
  );

  clk_div rx_clk (
      .CLK100MHZ(CLK100MHZ),
      .resetn(resetn),
      .count_lim(count_lim),
      .clk(Rx_clk)
  );



endmodule
