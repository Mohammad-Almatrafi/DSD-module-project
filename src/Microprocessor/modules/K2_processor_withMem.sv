// `include "K2_processor.sv"
module K2_processor_withMem #(
    parameter Bits = 8
) (
    clk,
    rst_n,
    instruction_data,
    ProgramAddress,
    Ro,
    Tx,
    Rx,
    digits_seg,
    include_parity,
    parity_type
);

  input include_parity, parity_type;
  input logic clk, rst_n;
  input logic [9:0] instruction_data;
  output logic [3:0] ProgramAddress;
  output logic [Bits-1:0] Ro;
  logic DataMemEn;
  logic [Bits-1:0] MemData;
  //   logic [2:0] imm;
  logic [Bits-1:0] Ra;
  logic [4:0] imm;
  logic [7:0] inst_to_proc;
  logic [1:0] Mem_sel;
  assign inst_to_proc = {instruction_data[9:5], instruction_data[2:0]};
  assign imm = instruction_data[4:0];
  assign Mem_sel = instruction_data[4:3];
  output logic [3:0] digits_seg[7:0];

  K2_processor #(
      .Bits(Bits)
  ) k2 (
      .clk(clk),
      .rst_n(rst_n),
      .instruction_data(inst_to_proc),
      .ProgramAddress(ProgramAddress),
      .Ro(Ro),
      .DataMemEn(DataMemEn),
      .MemData(MemData),
      .Ra(Ra),
      .PC_en(PC_en),
      .Data_selector(Data_selector)
  );
  // (~Data_selector | ~DataMemEn | (imm != 5'b10000) | valid)
  logic PC_en;
  assign PC_en = Data_selector ? (DataMemEn ? ~valid | imm != 5'b10000 : imm != 5'b10001 | ~Rx_idle) : 1'b1;
  logic [Bits-1:0] digits_seg_m[3:0];
  logic Data_selector;
  //   assign DataMemEn
  genvar i;
  generate
    for (i = 0; i < 4; i++) begin
      D_Register #(
          .bits(Bits)
      ) digits_regs (
          .clk(clk),
          .rst_n(rst_n),
          .en(DataMemEn & (Mem_sel == 2'd1) & (imm[2:0] == i)),
          .d(Ra),
          .q(digits_seg_m[i])
      );
      assign digits_seg[2*i]   = digits_seg_m[i][3:0];
      assign digits_seg[2*i+1] = digits_seg_m[i][7:4];
    end
  endgenerate

  Register_array #(  // we can replace this with any I/O or memory module
      .bits(Bits),
      .array_select_size(3)
  ) DataMem (
      .clk(clk),
      .rst_n(rst_n),
      .R_W(DataMemEn & ~Mem_sel[0] & ~Mem_sel[1]),
      .select(imm),
      .d(Ra),
      .q(reg_array_data)
  );  // we can replace this with any i/o or memory module
  logic [Bits-1:0] reg_array_data;
  logic start_send, include_parity, parity_type, valid, correct, Rx_idle;
  input logic Rx;
  logic [Bits-1:0] recive_msg_content;
  output logic Tx;
  assign start_send = Data_selector & (imm == 5'b10000);
  assign MemData = Data_selector & (Mem_sel == 0) ? reg_array_data : recive_msg_content;
  UART #(
      .n(Bits)
  ) UART_mod (
      .clk(clk),
      .rst_n(rst_n),
      .baud_rateSel(3'd0),
      .start_send(start_send),
      .send_msg_content(Ra),
      .include_parity(include_parity),
      .parity_type(parity_type),
      .Tx(Tx),
      .Rx(Rx),
      .valid(valid),
      .correct(correct),
      .Rx_idle(Rx_idle),
      .recive_msg_content(recive_msg_content)
  );



endmodule
