module button_debouncer (
    clk,
    rst_n,
    d,
    q
);
  input clk, rst_n, d;
  output q;
  logic s;

  assign q = (s == 0) & d;

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) s <= 1'b0;
    else s <= d;
  end



endmodule
