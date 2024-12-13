module shift_reg #(
    parameter n = 8
) (
    clk,
    rst_n,
    clear,
    en,
    in,
    q
);

  input clk, rst_n, clear, en, in;
  output logic [n-1:0] q;


  always @(posedge clk, negedge rst_n) begin

    if (~rst_n | clear) q <= 'b0;
    else if (en) q <= {in, q[n-1:1]};

  end





endmodule
