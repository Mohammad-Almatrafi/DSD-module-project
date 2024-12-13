
// `include "Counters/modules/counter_4bit.sv"
// `include "sev_seg/modules/sev_seg_controller.sv"

module imp_UART_loop (
    input wire CLK100MHZ,  // using the same name as pin names
    input wire CPU_RESETN,
    output wire CA,
    CB,
    CC,
    CD,
    CE,
    CF,
    CG,
    DP,
    output wire [7:0] AN,
    input wire [15:0] SW,
    input wire BTNC,
    output wire LED[2:0]
);


  logic reset_n;
  logic clk;
  assign reset_n = CPU_RESETN;
  assign clk = CLK100MHZ;


  // Seven segments Controller
  wire [6:0] Seg;
  wire [3:0] digits[0:7];
  logic btn_out;
  logic loop_log;

  //   button_debouncer btn_deb (
  //       .clk(UART_mod.Tx_clk),
  //       .rst_n(reset_n),
  //       .d(BTNC),
  //       .q(btn_out)
  //   );
  UART #(
      .n(8)
  ) UART_mod (
      .clk(clk),
      .rst_n(reset_n),
      .baud_rateSel(SW[15:13]),
      .start_send(BTNC),  //btn_out),
      .send_msg_content(SW[7:0]),
      .include_parity(SW[12]),
      .parity_type(SW[11]),
      .Tx(loop_log),
      .Rx(loop_log),
      .valid(LED[0]),
      .correct(LED[1]),
      .Rx_idle(LED[2]),
      .recive_msg_content(recive_msg_content)
  );
  logic [7:0] recive_msg_content;


  //   assign digits[0] = 4'b1111;
  //   assign digits[1] = 4'b1111;
  assign digits[2] = 4'b1111;
  assign digits[3] = 4'b1111;
  assign digits[4] = 4'b1111;
  assign digits[5] = 4'b1111;
  //   assign digits[6] = 4'b1111;
  //   assign digits[7] = 4'b1111;

  //   assign digits[0] = SW[7:0];
  //   assign digits[1] = Ro[7:4];
  assign digits[7] = SW[7:4];
  assign digits[6] = SW[3:0];
  assign digits[0] = recive_msg_content[3:0];
  assign digits[1] = recive_msg_content[7:4];




  sev_seg_controller ssc (
      .clk(clk),
      .resetn(reset_n),
      .digits(digits),
      .Seg(Seg),
      .AN(AN)
  );


  assign {CG, CF, CE, CD, CC, CB, CA} = Seg;
  assign DP = 1'b1;  // turn off the dot point on seven segs


endmodule
