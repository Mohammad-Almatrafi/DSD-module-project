module tb_Dataflow_Tx;

  localparam n = 8;
  logic clk = 0, rst_n, start_sig, Tx;
  logic [n-1:0] D;
  logic parity_check, valid;

  Dataflow_Tx #(
      .n(n),
      .parity_type_even_odd(1'b0)
  ) DUT (
      .clk(clk),
      .rst_n(rst_n),
      .start_sig(start_sig),
      .D(D),
      .Tx(Tx),
      .parity_check(parity_check),
      .valid(valid)
  );

  always #5 clk = ~clk;


  initial begin
    rst_n = 1'b1;
    #1 rst_n = 1'b0;
    #1 rst_n = 1'b1;
    D = 0;
    start_sig = 0;
    parity_check = 1;
    // parity_check, valid
    repeat (5) @(negedge clk);

    D = 'h55;
    start_sig = 1;
    @(negedge clk);
    start_sig = 0;
    repeat (11) @(negedge clk);

    $finish;


  end


endmodule
