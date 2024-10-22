`timescale 1us/100ns
`define ALU_ADD    4'b0010
`define ALU_LOAD   4'b0001
`define ALU_STORE  4'b0001
`define ALU_LUI    4'b0011
`define ALU_JUMP   4'b0000
`define ALU_OR     4'b0100
`define ALU_ADDI   4'b0010

`define OPCODE_R_TYPE  7'b0110011
`define OPCODE_I_TYPE  7'b0010011
`define OPCODE_S_TYPE  7'b0100011
`define OPCODE_B_TYPE  7'b1100011
`define OPCODE_U_TYPE  7'b0110111
`define OPCODE_J_TYPE  7'b1101111

module decode (
    input clk,
    input rst,
    input [31:0] instruction,
    output [3:0] alu_op,
    output write_enable,
    output mem_read,
    output mem_write,
    output branch,
    output [4:0] Rs1,
    output [4:0] Rs2,
    output [4:0] Rd,
    output [31:0] imm,
    output [1:0] alu_src
);

    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [3:0] alu_op_wire;
    wire write_enable_wire, mem_read_wire, mem_write_wire, branch_wire;
    wire [1:0] alu_src_wire;

    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];  
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd = instruction[11:7];

    // Determine ALU operation based on opcode and funct3
    assign alu_op_wire = 
        (opcode == `OPCODE_R_TYPE) ? `ALU_ADD :
        (opcode == `OPCODE_I_TYPE && funct3 == 3'b000) ? `ALU_ADDI :  // ADDI
        (opcode == `OPCODE_I_TYPE && funct3 == 3'b110) ? `ALU_OR :    // ORI
        (opcode == `OPCODE_I_TYPE) ? `ALU_LOAD :  // Other I-type instructions
        (opcode == `OPCODE_S_TYPE) ? `ALU_STORE :
        (opcode == `OPCODE_U_TYPE) ? `ALU_LUI :
        (opcode == `OPCODE_J_TYPE) ? `ALU_JUMP :
        (opcode == `OPCODE_B_TYPE) ? `ALU_ADD :  
        4'b0000;

    // Write enable for R-type, I-type, U-type, J-type instructions
    assign write_enable_wire = 
        (opcode == `OPCODE_R_TYPE) || (opcode == `OPCODE_I_TYPE) || 
        (opcode == `OPCODE_U_TYPE) || (opcode == `OPCODE_J_TYPE);

    assign mem_read_wire = (opcode == `OPCODE_I_TYPE);
    assign mem_write_wire = (opcode == `OPCODE_S_TYPE);
    assign branch_wire = (opcode == `OPCODE_B_TYPE);

    assign alu_src_wire = 
        (opcode == `OPCODE_R_TYPE) ? 2'b00 :
        (opcode == `OPCODE_I_TYPE) ? 2'b10 :
        (opcode == `OPCODE_S_TYPE) ? 2'b10 :
        (opcode == `OPCODE_U_TYPE) ? 2'b01 :
        (opcode == `OPCODE_B_TYPE) ? 2'b10 :
        2'b00;

    assign alu_op = alu_op_wire;
    assign write_enable = write_enable_wire;
    assign mem_read = mem_read_wire;
    assign mem_write = mem_write_wire;
    assign branch = branch_wire;
    assign alu_src = alu_src_wire;
endmodule
