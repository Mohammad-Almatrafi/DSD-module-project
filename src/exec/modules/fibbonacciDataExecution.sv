

module fibbonacciDataExecution #(
    parameter bits = 8
) (
    input clk,
    input rst_n,
    output [bits-1:0] Ro,
    output Tx,
    input Rx,
    output [3:0] digits_seg[7:0],
    input include_parity,
    input parity_type
);


  logic [9:0] instruction_data;
  logic [3:0] ProgramAddress;

  K2_processor_withMem #(
      .Bits(bits)
  ) k2 (
      .clk(clk),
      .rst_n(rst_n),
      .ProgramAddress(ProgramAddress),
      .instruction_data(instruction_data),
      .Ro(Ro),
      .Tx(Tx),
      .Rx(Rx),
      .digits_seg(digits_seg),
      .include_parity(include_parity),
      .parity_type(parity_type)
  );


  fibbonacciDataProgram pro (
      .s(ProgramAddress),
      .inst(instruction_data)
  );

endmodule
