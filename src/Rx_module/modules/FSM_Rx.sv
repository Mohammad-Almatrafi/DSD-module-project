module FSM_Rx (
    clk,
    rst_n,
    count_delay_eq,
    count_size_eq,
    parity,
    count_delay_rst_n,
    count_delay_en,
    count_size_rst_n,
    count_size_en,
    shift_reg_en,
    shift_reg_rst_n,
    parity_FF_en,
    parity_FF_rst_n,
    en_with_nTx,
    choose_equality
);

  input logic clk, rst_n, count_delay_eq, count_size_eq, parity;
  output logic count_delay_en, count_delay_rst_n, count_size_en, count_size_rst_n, choose_equality;
  output logic shift_reg_en, shift_reg_rst_n, parity_FF_en, parity_FF_rst_n, en_with_nTx;
  logic [2:0] n_state, p_state;
  localparam init = 3'd0, start = 3'd1, recieve_msg = 3'd2, parity_state = 3'd3, delay_next = 3'd4;

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) p_state <= init;
    else p_state <= n_state;
  end

  always @(p_state) begin
    case (p_state)
      init: begin
        count_delay_en = 1'b0;
        count_delay_rst_n = 1'b0;
        count_size_en = 1'b0;
        count_size_rst_n = 1'b0;
        shift_reg_en = 1'b0;
        shift_reg_rst_n = 1'b0;
        parity_FF_en = 1'b0;
        parity_FF_rst_n = 1'b0;
        choose_equality = 1'b0;
        en_with_nTx = 1'b0;
      end

      start: begin
        count_delay_en = 1'b1;
        count_delay_rst_n = 1'b1;
        count_size_en = 1'b0;
        count_size_rst_n = 1'b0;
        shift_reg_en = 1'b0;
        shift_reg_rst_n = 1'b1;
        parity_FF_en = 1'b0;
        parity_FF_rst_n = 1'b1;
        choose_equality = 1'b0;
        en_with_nTx = 1'b1;

      end
      recieve_msg: begin
        count_delay_en = 1'b1;
        count_delay_rst_n = 1'b1;
        count_size_en = 1'b1;
        count_size_rst_n = 1'b1;
        shift_reg_en = 1'b1;
        shift_reg_rst_n = 1'b1;
        parity_FF_en = 1'b0;
        parity_FF_rst_n = 1'b0;
        choose_equality = 1'b1;
        en_with_nTx = 1'b0;
      end
      parity_state: begin
        count_delay_en = 1'b1;
        count_delay_rst_n = 1'b1;
        count_size_en = 1'b0;
        count_size_rst_n = 1'b0;
        shift_reg_en = 1'b0;
        shift_reg_rst_n = 1'b1;
        parity_FF_en = 1'b1;
        parity_FF_rst_n = 1'b1;
        choose_equality = 1'b1;
        en_with_nTx = 1'b0;
      end

      delay_next: begin

        count_delay_en = 1'b1;
        count_delay_rst_n = 1'b1;
        count_size_en = 1'b0;
        count_size_rst_n = 1'b0;
        shift_reg_en = 1'b0;
        shift_reg_rst_n = 1'b1;
        parity_FF_en = 1'b0;
        parity_FF_rst_n = 1'b1;
        choose_equality = 1'b1;
        en_with_nTx = 1'b0;

      end

    endcase

  end


  always @(p_state, count_delay_eq, count_size_eq) begin
    case (p_state)
      init: begin
        n_state = start;
      end

      start: begin
        n_state = count_delay_eq ? recieve_msg : start;
      end

      recieve_msg: begin
        n_state = count_delay_eq & count_size_eq ? (parity ? parity_state:delay_next) : recieve_msg;
      end

      parity_state: begin
        n_state = count_delay_eq ? delay_next : parity_state;
      end

      delay_next: begin
        n_state = count_delay_eq ? start : delay_next;
      end
    endcase
  end

endmodule
