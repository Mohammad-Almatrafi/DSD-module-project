module MUX_n_bit #(
    parameter n = 3
) (
    input [n-1:0] s,
    input [2**n-1:0] i,
    output out
);

  assign out = i[s];


endmodule
