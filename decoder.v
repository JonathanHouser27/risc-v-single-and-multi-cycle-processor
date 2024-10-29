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

// Instruction Opcode Definitions
`define OPCODE_R_TYPE  7'b0110011 // R-Type
`define OPCODE_I_TYPE  7'b0010011 // I-Type
`define OPCODE_S_TYPE  7'b0100011 // S-Type
`define OPCODE_B_TYPE  7'b1100011 // B-Type
`define OPCODE_U_TYPE  7'b0110111 // U-Type
`define OPCODE_J_TYPE  7'b1101111 // J-Type

module decode (
    input clk,
    input rst,
    input [31:0] instruction,
    output [3:0] alu_op,        // Changed width to 4 bits to match ALU operation codes
    output we,
    output mem_read,
    output mem_write,
    output [31:0] branch_target,
    output branch_enable,
    output [31:0] imm,
    output [1:0] alu_src,
    output [4:0] Rs1_out,	
    output [4:0] Rs2_out,
    output [4:0] Rd_out
);

wire [6:0] opcode;
wire [2:0] funct3;
wire [3:0] alu_op_wire;    
wire write_enable_wire, mem_read_wire, mem_write_wire, branch_wire;
wire [1:0] alu_src_wire;
wire [31:0] imm_wire;

assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];  

    // Determine ALU operation based on opcode and funct3
assign alu_op_wire = 
    (opcode == `OPCODE_R_TYPE) ? `ALU_ADD :
    (opcode == `OPCODE_I_TYPE && funct3 == 3'b000) ? `ALU_ADDI :  // ADDI
    (opcode == `OPCODE_I_TYPE && funct3 == 3'b110) ? `ALU_OR :    // ORI
    (opcode == `OPCODE_R_TYPE && funct3 == 3'b111) ? `ALU_AND :   // AND
    (opcode == `OPCODE_I_TYPE) ? `ALU_LOAD :  // Other I-type instructions
    (opcode == `OPCODE_S_TYPE) ? `ALU_STORE :
    (opcode == `OPCODE_U_TYPE) ? `ALU_LUI :
    (opcode == `OPCODE_J_TYPE) ? `ALU_JUMP :
    (opcode == `OPCODE_B_TYPE) ? `ALU_BRANCH :  
    4'b1111;  // Use a 4-bit default value

    // Write enable for R-type, I-type, U-type, J-type instructions
assign write_enable_wire = 
    (opcode == `OPCODE_R_TYPE) || (opcode == `OPCODE_I_TYPE) || 
    (opcode == `OPCODE_U_TYPE) || (opcode == `OPCODE_J_TYPE);

assign mem_read_wire = (opcode == `OPCODE_I_TYPE);
assign mem_write_wire = (opcode == `OPCODE_S_TYPE);
assign branch_wire = (opcode == `OPCODE_B_TYPE) || (opcode == `OPCODE_J_TYPE);

assign alu_src_wire = 
    (opcode == `OPCODE_R_TYPE) ? 2'b00 :
    (opcode == `OPCODE_I_TYPE) ? 2'b10 :
    (opcode == `OPCODE_S_TYPE) ? 2'b10 :
    (opcode == `OPCODE_U_TYPE) ? 2'b01 :
    (opcode == `OPCODE_B_TYPE) ? 2'b10 :
    2'b00;

    // Immediate extraction based on opcode type
assign imm_wire = 
    (opcode == `OPCODE_I_TYPE) ? {{20{instruction[31]}}, instruction[31:20]} : // I-type sign extension
    (opcode == `OPCODE_S_TYPE) ? {{20{instruction[31]}}, instruction[31:25], instruction[11:7]} : // S-type
    (opcode == `OPCODE_B_TYPE) ? {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0} : // B-type
    (opcode == `OPCODE_U_TYPE) ? {instruction[31:12], 12'b0} : // U-type
    (opcode == `OPCODE_J_TYPE) ? {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0} : // J-type
    32'b0;

assign branch_target =
    (opcode == `OPCODE_J_TYPE) ? {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0} : // J-type
    (opcode == `OPCODE_B_TYPE) ? {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0} : // B-type
    32'b0; // default

assign branch_enable = branch_wire;


    // assignment logic
assign alu_op = alu_op_wire; 
assign we = write_enable_wire;      
assign mem_read = mem_read_wire;   
assign mem_write = mem_write_wire;        
assign imm = imm_wire;              
assign alu_src = alu_src_wire;  

assign Rs1_out = instruction[19:15]; 
assign Rs2_out = instruction[24:20]; 
assign Rd_out = instruction[11:7];    

endmodule
