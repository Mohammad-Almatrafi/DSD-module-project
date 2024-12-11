
module tb_fibbonacciSequenceExecution;

  logic clk = 0, rst_n;
  logic [7:0] Ro;
  fibbonacciSequenceExecution #(
      .bits(8)
  ) DUT (
      .clk(clk),
      .rst_n(rst_n),
      .Ro(Ro)
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
    #4000;
    $finish;
  end

endmodule
