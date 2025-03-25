`timescale 1us/100ns

`define OPCODE_R_TYPE  7'b0110011	// uses funct7, func3, rs1, rs2, rd, opcode
`define OPCODE_I_TYPE  7'b0010011	// uses func3, rs1, rd, opcode, imm
`define OPCODE_S_TYPE  7'b0100011	// uses func3, rs1, rs2, opcode, imm
`define OPCODE_B_TYPE  7'b1100011	// uses func3, rs1, rs2, opcode, imm
`define OPCODE_U_TYPE  7'b0110111	// only opcode, rd, and imm
`define OPCODE_J_TYPE  7'b1101111	// only opcode, rd, and imm

// FUNC7 and FUNC3 for R Type Instructions (0110011)
`define FUNCT7_SUB  7'b0100000 // Function code for SUB operation
`define FUNCT3_ADD  3'b000     // Function code for ADD
`define FUNCT3_SUB  3'b000     // Function code for SUB
`define FUNCT3_AND  3'b111     // Function code for AND
`define FUNCT3_OR   3'b110     // Function code for OR
`define FUNCT3_SLT  3'b010     // Function code for SLT

// FUNC3 for I Type Instruction (0010011)
`define FUNCT3_ADDI  3'b000     // Function code for ADDI
`define FUNCT3_SLTI  3'b010     // Function code for SLTI
`define FUNCT3_SLTIU 3'b011     // Function code for SLTIU
`define FUNCT3_XORI  3'b100     // Function code for XORI
`define FUNCT3_ORI   3'b110     // Function code for ORI
`define FUNCT3_ANDI  3'b111     // Function code for ANDI



`define FUNCT3_LW    3'b010     // Function code for LW


// Function codes for S-Type instructions
`define FUNCT3_SW   3'b010     // Function code for SW

// Function codes for B-Type instructions
`define FUNCT3_BEQ  3'b000      // Function code for BEQ
`define FUNCT3_BNE  3'b001	// Function code for BNE
`define FUNCT3_BLT  3'b100	// Function code for BLT
`define FUNCT3_BGE  3'b101      // Function code for BGE
`define FUNCT3_BLTU 3'b110	// Function code for BLTU
`define FUNCT3_BGEU 3'b111	// Function code for BGEU

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
