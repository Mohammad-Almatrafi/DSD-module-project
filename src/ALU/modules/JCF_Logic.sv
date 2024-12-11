module JCF_Logic (
    ZF,
    CF,
    J,
    D,
    C,
    S_reg,
    JCF,
    DataMemEn,
    Data_selector
);

  input logic J;
  input logic C, CF, ZF;
  input logic S_reg;
  input logic [1:0] D;
  output logic Data_selector, DataMemEn, JCF;

  logic inter;
  logic muxOut;
  assign muxOut = J ? ZF : CF;
  assign inter = muxOut & ((~S_reg & J) | (~S_reg & C));
  assign JCF = (J & ~C & ~S_reg) | inter;
  assign Data_selector = J & C & S_reg;
  assign DataMemEn = (&D) & S_reg & J & C;
endmodule
