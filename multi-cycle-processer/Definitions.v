// Define the Opcodes
`define OPCODE_R_TYPE  7'b0110011
`define OPCODE_I_TYPE  7'b0010011
`define OPCODE_S_TYPE  7'b0100011
`define OPCODE_B_TYPE  7'b1100011
`define OPCODE_U_TYPE  7'b0110111
`define OPCODE_J_TYPE  7'b1101111

`define FUNCT7_SUB  7'b0100000 // Function code for SUB operation
`define FUNCT3_ADD  3'b000     // Function code for ADD
`define FUNCT3_SUB  3'b000     // Function code for SUB
`define FUNCT3_AND  3'b111     // Function code for AND
`define FUNCT3_OR   3'b110     // Function code for OR
`define FUNCT3_SLT  3'b010     // Function code for SLT
`define FUNCT3_BNE  3'b001     // Function code for BNE


// Function codes for I-Type instructions
`define FUNCT3_ADDI 3'b000     // Function code for ADDI
`define FUNCT3_ORI  3'b110     // Function code for ORI
`define FUNCT3_LW   3'b010     // Function code for LW
`define FUNCT3_SLTI 3'b010     // Function code for SLTI

// Function codes for S-Type instructions
`define FUNCT3_SW   3'b010     // Function code for SW

// Function codes for B-Type instructions
`define FUNCT3_BEQ  3'b000     // Function code for BEQ

// ALU operation codes
`define ALU_ADD     4'b0000    // ALU operation for ADD
`define ALU_SUB     4'b0001    // ALU operation for SUB
`define ALU_AND     4'b0010    // ALU operation for AND
`define ALU_OR      4'b0011    // ALU operation for OR
`define ALU_SLT     4'b0100    // ALU operation for SLT
`define ALU_ADDI    4'b0101    // ALU operation for ADDI
`define ALU_ORI     4'b0110    // ALU operation for ORI
`define ALU_LOAD    4'b0111    // ALU operation for LOAD
`define ALU_SLTI    4'b1000    // ALU operation for SLTI
`define ALU_LUI     4'b1001    // ALU operation for LUI
`define ALU_JAL     4'b1010    // ALU operation for JAL
`define ALU_STORE   4'b1011    // ALU operation for STORE
`define ALU_JUMP    4'b1100    // ALU operation for JUMP
`define ALU_BRANCH  4'b1101    // ALU operation for BRANCH
`define ALU_BGE     4'b1110    // ALU operation for BGE
`define ALU_BNE     4'b1111    // ALU operation for BNE
