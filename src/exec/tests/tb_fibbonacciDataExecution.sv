
module tb_fibbonacciDataExecution;

  logic clk = 0, rst_n;
  logic [7:0] Ro;
  logic Rx, Tx, include_parity = 0, parity_type = 0;
  logic [3:0] digits_seg[7:0];
  fibbonacciDataExecution #(
      .bits(8)
  ) DUT (
      .clk(clk),
      .rst_n(rst_n),
      .Ro(Ro),
      .Tx(Tx),
      .Rx(Rx),
      .digits_seg(digits_seg),
      .include_parity(include_parity),
      .parity_type(parity_type)
  );



  always #10 clk = ~clk;

  always @(Ro) $display("%d", Ro);


  initial begin
    $display("Ro");
    rst_n = 1;
    #1;
    rst_n = 0;
    #1;
    rst_n = 1;
    // #250;
    #4000;
    $finish;
  end

endmodule
