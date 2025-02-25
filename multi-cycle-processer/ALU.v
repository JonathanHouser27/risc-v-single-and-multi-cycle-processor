`timescale 1us/100ns
`define OPCODE_R_TYPE  7'b0110011
`define OPCODE_I_TYPE  7'b0010011
`define OPCODE_S_TYPE  7'b0100011
`define OPCODE_B_TYPE  7'b1100011
`define OPCODE_U_TYPE  7'b0110111
`define OPCODE_J_TYPE  7'b1101111

`define FUNCT7_SUB  7'b0100000 // Function code for SUB operation
`define FUNCT3_ADD  3'b000     // Function code for ADD
`define FUNCT3_SUB  3'b000     // Function code for SUB
`define FUNCT3_SLT  3'b010     // Function code for SLT
`define FUNCT3_OR   3'b110     // Function code for OR
`define FUNCT3_AND  3'b111     // Function code for AND

// Function codes for I-Type instructions
`define FUNCT3_ADDI 3'b000     // Function code for ADDI
`define FUNCT3_ORI  3'b110     // Function code for ORI
`define FUNCT3_LW   3'b010     // Function code for LW
`define FUNCT3_SLTI 3'b010     // Function code for SLTI

// Function codes for S-Type instructions
`define FUNCT3_SW   3'b010     // Function code for SW

// Function codes for B-Type instructions
`define FUNCT3_BEQ  3'b000      // Function code for BEQ
`define FUNCT3_BNE  3'b001	// Function code for BNE
`define FUNCT3_BLT  3'b100	// Function code for BLT
`define FUNCT3_BGE  3'b101      // Function code for BGE

// ALU operation codes
`define ALU_ADD     5'b00000    // ALU operation for ADD
`define ALU_SUB     5'b00001    // ALU operation for SUB
`define ALU_AND     5'b00010    // ALU operation for AND
`define ALU_OR      5'b00011    // ALU operation for OR
`define ALU_SLT     5'b00100    // ALU operation for SLT
`define ALU_ADDI    5'b00101    // ALU operation for ADDI
`define ALU_ORI     5'b00110    // ALU operation for ORI
`define ALU_LOAD    5'b00111    // ALU operation for LOAD
`define ALU_SLTI    5'b01000    // ALU operation for SLTI
`define ALU_LUI     5'b01001    // ALU operation for LUI
`define ALU_JAL     5'b01010    // ALU operation for JAL
`define ALU_STORE   5'b01011    // ALU operation for STORE
`define ALU_JUMP    5'b01100    // ALU operation for JUMP
`define ALU_BRANCH  5'b01101    // ALU operation for BRANCH
`define ALU_BEQ     5'b01110    // Function code for BEQ
`define ALU_BNE     5'b01111	// Function code for BNE
`define ALU_BLT     5'b10000	// Function code for BLT
`define ALU_BGE     5'b10001    // Function code for BGE

module ALU (
    input [31:0] A,                
    input [31:0] B,                
    input [31:0] imm,              
    input reg [4:0] func,              
    output reg [31:0] out,         
    output reg branch_taken            
);

always @(*) begin
    // Default values to prevent latching
    out = 32'b0;
    branch_taken = 1'b0;

    case (func)
        `ALU_ADD, `ALU_LOAD: begin
		out = A + B;
		branch_taken = 1'b0;
	end
        `ALU_ADDI, `ALU_STORE: begin
		out = A + imm;
		branch_taken = 1'b0;
	end
        `ALU_SUB: begin
		out = A - B;
		branch_taken = 1'b0;
	end
        `ALU_AND: begin
		out = A & B;
		branch_taken = 1'b0;
	end
        `ALU_OR: begin
		out = A | B;
		branch_taken = 1'b0;
	end
        `ALU_LUI: begin
		out = imm;
		branch_taken = 1'b0;
	end
	`ALU_BRANCH: begin
		out = 32'b0;
		branch_taken = 1'b1;
	end
        `ALU_BGE: begin
		out = 32'b0;
		branch_taken = (A >= B) ? 1'b1 : 1'b0;
	end
	`ALU_BLT: begin
		out = 32'b0;
		branch_taken = (A < B) ? 1'b1 : 1'b0;
	end
	`ALU_BNE: begin
		out = 32'b0;
		branch_taken = (A != B) ? 1'b1 : 1'b0;
	end
	`ALU_BEQ: begin
		out = 32'b0;
		branch_taken = (A == B) ? 1'b1 : 1'b0;
	end
	`ALU_JUMP: begin
		out = 32'b0;
		branch_taken = 1'b1;
	end
    endcase

end

endmodule
