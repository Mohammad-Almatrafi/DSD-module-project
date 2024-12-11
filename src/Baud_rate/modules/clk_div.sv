module clk_div (
    input logic CLK100MHZ,
    input logic resetn,
    input [11:0] count_lim,
    output logic clk
);

  logic [11:0] count;

  initial clk = 0;

  always @(posedge CLK100MHZ or negedge resetn) begin
    if (!resetn) begin
      clk   <= 0;
      count <= 12'b0;
    end else begin
      if (count == count_lim - 1) begin
        count <= 12'b0;
        clk   <= ~clk;
      end else begin
        count <= count + 1;
      end
    end
  end
endmodule
