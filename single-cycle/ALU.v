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
`define ALU_SUB    4'b1001 // Subtraction

module ALU (
    input [31:0] A,                // First operand
    input [31:0] B,                // Second operand
    input [31:0] imm,              // Immediate value
    input [1:0] alu_src,           // ALU source selection (0: B, 1: zero-extend imm, 2: sign-extend imm)
    input [3:0] func,              // Function select
    output [31:0] out,             // ALU output
    output c_out,                  // Carry out (for add/sub)
    output branch_taken            // Branch taken signal
);

wire [31:0] selected_B;            // Selected B input for ALU
wire [31:0] add_result;            // Result of addition
wire zero_flag;                    // Zero flag for branch logic

// Select the appropriate B input for ALU
assign selected_B = (alu_src == 2'b00) ? B :              // Use B directly
                    (alu_src == 2'b01) ? imm :            // Use zero-extended immediate
                    (alu_src == 2'b10) ? imm :            // Use sign-extended immediate
                    B;                                     // Default to B if alu_src is not valid

// ALU core operations (addition, subtraction, etc.)
assign add_result = A + selected_B;
assign out = (func == `ALU_ADD || func == `ALU_ADDI || func == `ALU_LOAD || func == `ALU_STORE) ? add_result :
             (func == `ALU_AND) ? (A & selected_B) :
             (func == `ALU_OR) ? (A | selected_B) :
             (func == `ALU_SUB) ? (A - selected_B) :     // Subtraction
             (func == `ALU_BRANCH) ? (A - selected_B) :  // Branch comparison (subtract)
             (func == `ALU_LUI) ? selected_B :           // For LUI, output the immediate
             (func == `ALU_JUMP) ? selected_B :          // For Jump, output the target
             32'b0; // Default to 0 if no valid operation

// Carry-out logic for addition and subtraction
assign c_out = (func == `ALU_ADD || func == `ALU_ADDI || func == `ALU_LOAD || func == `ALU_STORE) ? 
               (add_result < A) :  // Carry out for addition (detect overflow)
               (func == `ALU_SUB) ? (A < selected_B) : // Carry out for subtraction (borrow detection)
               1'b0; // No carry for other operations

// Zero flag logic (set if ALU output is zero)
assign zero_flag = (out == 32'b0);

// Branch taken logic (branches if zero flag is set, or if it's a jump instruction)
assign branch_taken = (func == `ALU_BRANCH && zero_flag) || (func == `ALU_JUMP);

endmodule
