module DFF (
    clk,
    rst_n,
    clear,
    en,
    d,
    q
);

  input clear, clk, rst_n, en, d;
  output logic q;

  always @(posedge clk, negedge rst_n) begin

    if (~rst_n | clear) q <= 1'b0;
    else if (en) q <= d;

  end



endmodule
