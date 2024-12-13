module tb_Dataflow_Rx;

  localparam n = 8;
  logic Rxclk = 0, Txclk = 0, rst_n, start_sig, Tx;
  logic [n-1:0] D;
  logic parity_check, valid;
  logic [n-1:0] out_buffer;
  logic correct, Rx_idle;

  Dataflow_Tx #(
      .n(n)
  ) DUT (
      .clk(Txclk),
      .rst_n(rst_n),
      .start_sig(start_sig),
      .D(D),
      .Tx(Tx),
      .parity_type_even_odd(1'b0),
      .parity_check(parity_check),
      .valid(valid)
  );

  Dataflow_Rx #(
      .n(n)
  ) RxDUT (
      .clk(Rxclk),
      .rst_n(rst_n),
      .Rx(Tx),
      .parity_check(parity_check),
      .parity_type_even_odd(1'b0),
      .correct(correct),
      .out_buffer(out_buffer),
      .Rx_idle(Rx_idle)
  );
  logic [3:0] countit = 0;
  always #5 Rxclk = ~Rxclk;
  always @(posedge Rxclk) begin
    if (countit == 7) begin
      Txclk   = ~Txclk;
      countit = 0;
    end else countit = countit + 1;

  end

  initial begin
    rst_n = 1'b1;
    #1 rst_n = 1'b0;
    #1 rst_n = 1'b1;
    D = 0;
    start_sig = 0;
    parity_check = 1;
    // parity_check, valid
    repeat (5) @(negedge Txclk);

    D = 'h55;
    start_sig = 1;
    @(negedge Txclk);
    start_sig = 0;
    repeat (11) @(negedge Txclk);

    $finish;


  end


endmodule
