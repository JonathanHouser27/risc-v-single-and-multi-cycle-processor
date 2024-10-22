`timescale 1us/100ns

module ALU (
    input [31:0] A,               // First operand
    input [31:0] B,               // Second operand
    input [31:0] imm,             // Immediate value
    input [1:0] alu_src,          // ALU source selection (0: B, 1: zero-extend imm, 2: sign-extend imm)
    input [2:0] func,             // Function select
    output [31:0] out,            // ALU output
    output c_out                  // Carry out
);

    // Intermediate signals
    wire [31:0] selected_B;       // Selected B input for ALU
    wire [31:0] zero_extended_imm; // Zero-extended version of immediate
    wire [31:0] sign_extended_imm; // Sign-extended version of immediate

    // Zero extension of lower 16 bits of immediate
    assign zero_extended_imm = {16'b0, imm[15:0]}; // Zero-extend imm[15:0] to 32 bits

    // Sign extension of lower 16 bits of immediate
    assign sign_extended_imm = {{16{imm[15]}}, imm[15:0]}; // Sign-extend imm[15:0] to 32 bits

    // Select the appropriate input for ALU
    assign selected_B = (alu_src == 2'b00) ? B :
                        (alu_src == 2'b01) ? zero_extended_imm :
                        (alu_src == 2'b10) ? sign_extended_imm :
                        B; // Default to B if alu_src is 2'b11

    // ALU output logic using continuous assignments
    assign out = (func == 3'b000) ? A + selected_B :   // ADD
                 (func == 3'b001) ? A - selected_B :   // SUBTRACT
                 (func == 3'b010) ? A & selected_B :   // AND
                 (func == 3'b011) ? A | selected_B :   // OR
                 (func == 3'b100) ? A ^ selected_B :   // XOR
                 (func == 3'b101) ? ~A :               // NOT
                 (func == 3'b110) ? A >> 1 :           // Shift right
                 32'b0;                                // Default

    // Carry out logic
    assign c_out = (func == 3'b000) ? (A + selected_B < A) : // Carry out for ADD
                   (func == 3'b001) ? (A < selected_B) :    // Borrow for SUBTRACT
                   1'b0;                                    // No carry out for other operations

endmodule
