// `include "buildingBlocks/ALU.sv"
// `include "buildingBlocks/D_Register.sv"
module ALU_Block_with_CZF #(
    parameter bits = 8
) (
    clk,
    rst_n,
    a,
    b,
    s,
    out,
    c,
    z
);

  input logic [bits-1:0] a, b;
  input logic s, clk, rst_n;
  output logic [bits-1:0] out;
  output c, z;
  logic wc, wz;

  ALU #(
      .bits(bits)
  ) alu_logic (
      .a(a),
      .b(b),
      .s(s),
      .y(out),
      .cOut(wc)
  );

  assign wz = &(~out);

  D_Register #(
      .bits(1)
  ) RC (
      .clk(clk),
      .rst_n(rst_n),
      .en(1'b1),
      .d(wc),
      .q(c)
  );

  D_Register #(
      .bits(1)
  ) RZ (
      .clk(clk),
      .rst_n(rst_n),
      .en(1'b1),
      .d(wz),
      .q(z)
  );





endmodule

// input logic clk,
// input logic rst_n,
// input logic en,
// input logic [bits-1:0] d,
// output logic [bits-1:0] q
