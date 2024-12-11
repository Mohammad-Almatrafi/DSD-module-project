// `include "K2_processor.sv"
module K2_processor_withMem #(
    parameter Bits = 8
) (
    clk,
    rst_n,
    instruction_data,
    ProgramAddress,
    Ro
);

  input logic clk, rst_n;
  input logic [7:0] instruction_data;
  output logic [3:0] ProgramAddress;
  output logic [Bits-1:0] Ro;
  logic DataMemEn;
  logic [Bits-1:0] MemData;
  logic [2:0] imm;
  logic [Bits-1:0] Ra;

  K2_processor #(
      .Bits(Bits)
  ) k2 (
      .clk(clk),
      .rst_n(rst_n),
      .instruction_data(instruction_data),
      .ProgramAddress(ProgramAddress),
      .Ro(Ro),
      .DataMemEn(DataMemEn),
      .imm(imm),
      .MemData(MemData),
      .Ra(Ra)
  );



  Register_array #(  // we can replace this with any I/O or memory module
      .bits(Bits),
      .array_select_size(3)
  ) DataMem (
      .clk(clk),
      .rst_n(rst_n),
      .R_W(DataMemEn),
      .select(imm),
      .d(Ra),
      .q(MemData)
  );  // we can replace this with any i/o or memory module



endmodule
