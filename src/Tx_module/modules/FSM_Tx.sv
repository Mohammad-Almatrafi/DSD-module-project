module FSM_Tx (

    clk,
    rst_n,
    start_sig,
    count_eq_size,
    buffer_en,
    buffer_rst_n,
    counter_rst_n,
    counter_en,
    mux_s,
    parity_check,
    valid

);

  input clk, rst_n, start_sig, count_eq_size;
  input parity_check;
  output logic buffer_en, buffer_rst_n, counter_en, counter_rst_n, valid;
  output logic [1:0] mux_s;
  localparam init = 3'b00, start = 3'b01, send_0 = 3'b10, send_msg = 3'b11, send_parity = 3'b100;
  logic [2:0] n_state, p_state;
  assign valid = buffer_en;

  always @(posedge clk, negedge rst_n) begin  // state transition always block

    if (~rst_n) p_state <= init;
    else p_state <= n_state;

  end

  always @(p_state) begin  // always output block
    case (p_state)

      init: begin  // functionality => mux should pass 1, buffer and counter should be reseted
        mux_s = 2'd1;
        buffer_en = 1'b0;
        buffer_rst_n = 1'b1;
        counter_en = 1'b0;
        counter_rst_n = 1'b0;
      end

      start: begin  // functionality => mux should pass 1, buffer should pass whatever the user wants
        // counter should be at zero
        mux_s = 2'd1;
        buffer_en = 1'b1;
        buffer_rst_n = 1'b1;
        counter_en = 1'b0;
        counter_rst_n = 1'b0;
      end

      send_0: begin // functionality => mux should pass 0, buffer should be disabled till the transmission ends
        // counter should be at zero
        mux_s = 2'd0;
        buffer_en = 1'b0;
        buffer_rst_n = 1'b1;
        counter_en = 1'b0;
        counter_rst_n = 1'b0;
      end

      send_msg: begin // functionality => mux should pass what is in the buffer, buffer should be disabled till the transmission ends
        // counter should start counting 
        mux_s = 2'b10;
        buffer_en = 1'b0;
        buffer_rst_n = 1'b1;
        counter_en = 1'b1;
        counter_rst_n = 1'b1;
      end
      send_parity: begin // functionality => mux should pass the parity logic output, buffer should be disabled till the transmission ends
        // counter should start counting 
        mux_s = 2'b11;
        buffer_en = 1'b0;
        buffer_rst_n = 1'b1;
        counter_en = 1'b0;
        counter_rst_n = 1'b0;
      end
    endcase

  end


  always @(p_state, start_sig, count_eq_size) begin

    case (p_state)

      init: begin
        n_state = start;
      end

      start: begin
        n_state = start_sig ? send_0 : start;
      end

      send_0: begin
        n_state = send_msg;
      end

      send_msg: begin
        n_state = count_eq_size ? (parity_check ? send_parity : start) : send_msg;
      end
      send_parity: begin
        n_state = start;
      end

    endcase

  end

endmodule
