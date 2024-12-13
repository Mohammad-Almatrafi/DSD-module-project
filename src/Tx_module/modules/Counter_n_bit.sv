module Counter_n_bit #(
    parameter n = 8
) (
    input clk,
    input resetn,
    input clear,
    input count_en,
    output logic [n-1:0] Q
);

  always @(posedge clk or negedge resetn) begin
    if (~resetn | clear) Q <= 0;
    else if (count_en) Q <= Q + 1;
  end

endmodule
