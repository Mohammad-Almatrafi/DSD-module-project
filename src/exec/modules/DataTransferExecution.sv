
module DataTransferExecution #(
    parameter bits = 8
) (
    clk,
    rst_n,
    Ro
);

  input clk, rst_n;
  output [bits-1:0] Ro;

  logic [7:0] instruction_data;
  logic [3:0] ProgramAddress;
  K2_processor #(
      .Bits(bits)
  ) Processor (
      .clk(clk),
      .rst_n(rst_n),
      .ProgramAddress(ProgramAddress),
      .instruction_data(instruction_data),
      .Ro(Ro)
  );



  DataTransferProgram pro (
      .s(ProgramAddress),
      .inst(instruction_data)
  );

endmodule
