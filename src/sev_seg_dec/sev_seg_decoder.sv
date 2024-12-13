module seven_seg_decoder(
    input  wire [3:0] bin,      // 4-bit binary input (0–F)
    output reg  [6:0] seg       // 7-bit output for segments a-g
);

// Add your code here -----------------------------------
    assign seg[0] = ((~bin[1]&bin[0]&~bin[3]&~bin[2])|(~bin[1]&~bin[0]&~bin[3]&bin[2])|(~bin[1]&bin[0]&bin[3]&bin[2])|(bin[1]&bin[0]&bin[3]&~bin[2]));//a
    assign seg[1] =((bin[1]&~bin[0]&bin[2])|(bin[1]&bin[3]&bin[0])|(~bin[0]&bin[3]&bin[2])|(~bin[1]&bin[0]&~bin[3]&bin[2]));//b
    assign seg[2] =((bin[1]&bin[3]&bin[2])|(~bin[0]&bin[3]&bin[2])|(bin[1]&~bin[0]&~bin[3]&~bin[2]));//c
    assign seg[3] =((bin[1]&bin[0]&bin[2])|(~bin[1]&bin[0]&~bin[3]&~bin[2])|(~bin[1]&~bin[0]&~bin[3]&bin[2])|(bin[1]&~bin[0]&bin[3]&~bin[2]));//d
    assign seg[4] =((bin[0]&~bin[3])|(~bin[1]&~bin[3]&bin[2])|(~bin[1]&bin[0]&~bin[2]));//e
    assign seg[5] =((bin[0]&~bin[3]&~bin[2])|(bin[1]&~bin[3]&~bin[2])|(bin[1]&bin[0]&~bin[3])|(~bin[1]&bin[0]&bin[3]&bin[2]));//f
    assign seg[6] =((~bin[1]&~bin[3]&~bin[2])|(bin[1]&bin[0]&~bin[3]&bin[2])|(~bin[1]&~bin[0]&bin[3]&bin[2]));//g


// Add your code here -----------------------------------

endmodule
