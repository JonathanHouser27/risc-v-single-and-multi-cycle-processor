`timescale 1us/100ns

module ripple_carry_adder(
    input [31:0] A,      // 32-bit Input A
    input [31:0] B,      // 32-bit Input B
    output [31:0] S,     // 32-bit Sum Output
    output Cout          // Carry Out
);

    wire [31:0] carry;   // Intermediate carry wires

    assign carry[0] = 1'b0; // Initial carry-in is 0

    // Instantiate full adders for each bit
    full_adder u0(A[0], B[0], carry[0], S[0], carry[1]);
    full_adder u1(A[1], B[1], carry[1], S[1], carry[2]);
    full_adder u2(A[2], B[2], carry[2], S[2], carry[3]);
    full_adder u3(A[3], B[3], carry[3], S[3], carry[4]);
    full_adder u4(A[4], B[4], carry[4], S[4], carry[5]);
    full_adder u5(A[5], B[5], carry[5], S[5], carry[6]);
    full_adder u6(A[6], B[6], carry[6], S[6], carry[7]);
    full_adder u7(A[7], B[7], carry[7], S[7], carry[8]);
    full_adder u8(A[8], B[8], carry[8], S[8], carry[9]);
    full_adder u9(A[9], B[9], carry[9], S[9], carry[10]);
    full_adder u10(A[10], B[10], carry[10], S[10], carry[11]);
    full_adder u11(A[11], B[11], carry[11], S[11], carry[12]);
    full_adder u12(A[12], B[12], carry[12], S[12], carry[13]);
    full_adder u13(A[13], B[13], carry[13], S[13], carry[14]);
    full_adder u14(A[14], B[14], carry[14], S[14], carry[15]);
    full_adder u15(A[15], B[15], carry[15], S[15], carry[16]);
    full_adder u16(A[16], B[16], carry[16], S[16], carry[17]);
    full_adder u17(A[17], B[17], carry[17], S[17], carry[18]);
    full_adder u18(A[18], B[18], carry[18], S[18], carry[19]);
    full_adder u19(A[19], B[19], carry[19], S[19], carry[20]);
    full_adder u20(A[20], B[20], carry[20], S[20], carry[21]);
    full_adder u21(A[21], B[21], carry[21], S[21], carry[22]);
    full_adder u22(A[22], B[22], carry[22], S[22], carry[23]);
    full_adder u23(A[23], B[23], carry[23], S[23], carry[24]);
    full_adder u24(A[24], B[24], carry[24], S[24], carry[25]);
    full_adder u25(A[25], B[25], carry[25], S[25], carry[26]);
    full_adder u26(A[26], B[26], carry[26], S[26], carry[27]);
    full_adder u27(A[27], B[27], carry[27], S[27], carry[28]);
    full_adder u28(A[28], B[28], carry[28], S[28], carry[29]);
    full_adder u29(A[29], B[29], carry[29], S[29], carry[30]);
    full_adder u30(A[30], B[30], carry[30], S[30], carry[31]);
    full_adder u31(A[31], B[31], carry[31], S[31], Cout); // Final carry out

endmodule
