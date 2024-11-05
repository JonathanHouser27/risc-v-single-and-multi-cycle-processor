`timescale 1us/100ns

// ALU Operation Codes
`define ALU_ADD    4'b0000 // Addition
`define ALU_ADDI   4'b0001 // Add Immediate
`define ALU_LOAD   4'b0010 // Load
`define ALU_STORE  4'b0011 // Store
`define ALU_LUI    4'b0100 // Load Upper Immediate
`define ALU_JUMP   4'b0101 // Jump
`define ALU_OR     4'b0110 // Bitwise OR
`define ALU_AND    4'b0111 // Bitwise AND
`define ALU_BRANCH 4'b1000 // Branch

module ALU (
    input [31:0] A,                // First operand
    input [31:0] B,                // Second operand
    input [31:0] imm,              // Immediate value
    input [1:0] alu_src,           // ALU source selection (0: B, 1: zero-extend imm, 2: sign-extend imm)
    input [3:0] func,              // Function select
    output [31:0] out,             // ALU output
    output c_out,                  // Carry out
    output branch_taken            // Branch taken signal
);

wire [31:0] selected_B;        // Selected B input for ALU
wire [31:0] zero_extended_imm; // Zero-extended version of immediate
wire [31:0] sign_extended_imm; // Sign-extended version of immediate
wire [31:0] add_result;        // Result for addition
wire [31:0] branch_result;     // Result for branch comparison
wire zero_flag;                // Zero flag for branch taken logic

    // Zero extension of lower 16 bits of immediate
assign zero_extended_imm = {16'b0, imm[15:0]}; // Zero-extend imm[15:0] to 32 bits

    // Sign extension of lower 16 bits of immediate
assign sign_extended_imm = {{16{imm[15]}}, imm[15:0]}; // Sign-extend imm[15:0] to 32 bits

    // Select the appropriate input for ALU
assign selected_B = (alu_src == 2'b00) ? B :
                    (alu_src == 2'b01) ? zero_extended_imm :
                    (alu_src == 2'b10) ? sign_extended_imm :
                    B; // Default to B if alu_src is 2'b11

    // ALU output logic
assign add_result = A + selected_B; // Calculate addition result
assign out = (func == `ALU_ADD || func == `ALU_ADDI || func == `ALU_LOAD || func == `ALU_STORE) ? add_result :
             (func == `ALU_AND) ? (A & selected_B) :
             (func == `ALU_OR) ? (A | selected_B) :
             (func == `ALU_BRANCH) ? (A - selected_B) :
             (func == `ALU_JUMP) ? selected_B : // Assume selected_B contains the jump target
             32'b0; // Default case

    // Carry out logic
assign c_out = (func == `ALU_ADD || func == `ALU_ADDI || func == `ALU_LOAD || func == `ALU_STORE) ? (add_result < A) : 1'b0;

    // Zero flag logic
assign zero_flag = (out == 32'b0);

    // Branch taken logic
assign branch_taken = (func == `ALU_BRANCH && zero_flag) || (func == `ALU_JUMP);

endmodule
