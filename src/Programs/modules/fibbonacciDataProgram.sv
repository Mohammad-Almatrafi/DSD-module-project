
`timescale 1ns / 1ps

module fibbonacciDataProgram (
    input  [3:0] s,
    output [9:0] inst
);
  logic [9:0] out;
  assign inst = out;
  logic [9:0] add_Ra_Ra_Rb;
  logic [9:0] add_Rb_Ra_Rb;
  logic [9:0] sub_Ra_Ra_Rb;
  logic [9:0] sub_Rb_Ra_Rb;
  logic [9:0] Ro_Ra;
  logic [9:0] Ra_imm;
  logic [9:0] Rb_imm;
  logic [9:0] JC;
  logic [9:0] JZ;
  logic [9:0] J;
  logic [9:0] Ra__imm_;
  logic [9:0] Rb__imm_;
  logic [9:0] _imm__Ra;
  assign add_Ra_Ra_Rb = 10'b00_0000_0000;
  assign add_Rb_Ra_Rb = 10'b00_0100_0000;
  assign sub_Ra_Ra_Rb = 10'b00_0000_0100;
  assign sub_Rb_Ra_Rb = 10'b00_0100_0100;
  assign Ro_Ra = 10'b00_1000_0000;
  assign Ra_imm = 10'b00_0010_0000;
  assign Rb_imm = 10'b00_0110_0000;
  assign JC = 10'b01_1100_0000;
  assign JZ = 10'b11_1100_0000;
  assign J = 10'b10_1100_0000;
  assign Ra__imm_ = 10'b11_0010_0000;
  assign Rb__imm_ = 10'b11_0110_0000;
  assign _imm__Ra = 10'b11_1110_0000;




  always @(s) begin
    case (s)
      0:  out = Ra_imm | 3'b001;  //RA = 1
      1:  out = _imm__Ra | 5'b00001;  //[1] = RA
      2:  out = Ra_imm | 3'b0;  //RA = 0
      3:  out = _imm__Ra | 5'b00010;  //[2] = RA
      4:  out = _imm__Ra | 5'b10000;  // [Tx] = Ra 
      5:  out = Ra__imm_ | 5'b00001;  //RA = [1]
      6:  out = Rb__imm_ | 5'b00010;  //RB = [2]
      7:  out = _imm__Ra | 5'b10000;  // [Tx] = RA
      8:  out = _imm__Ra | 5'b00010;  //[2] = RA
      9:  out = add_Ra_Ra_Rb;  //RA = RA+RB
      10: out = JC | 3'b000;  //JC 0
      11: out = J | 3'b110;  //J 6
    endcase
  end

endmodule
