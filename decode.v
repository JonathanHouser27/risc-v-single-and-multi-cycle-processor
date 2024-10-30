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

wire [6:0] opcode = instruction[6:0];
wire [2:0] funct3 = instruction[14:12];  
reg [3:0] alu_op_wire;    
reg write_enable_wire, mem_read_wire, mem_write_wire, branch_enable_wire;
reg [1:0] alu_src_wire;
reg [31:0] imm_wire;
reg [31:0] branch_wire;

always @(*) begin
    // Default values to prevent latches
    alu_op_wire = 4'b1111;
    write_enable_wire = 1'b0;
    mem_read_wire = 1'b0;
    mem_write_wire = 1'b0;
    alu_src_wire = 2'b00;
    branch_wire = 32'b0;
    imm_wire = 32'b0;
    branch_enable_wire = 1'b0;

    casex (opcode)
        `OPCODE_R_TYPE: begin
            case (funct3)
                3'b000: alu_op_wire = `ALU_ADD;  // R-Type ADD
                3'b111: alu_op_wire = `ALU_AND;  // R-Type AND
                default: alu_op_wire = 4'b1111;  // Undefined R-Type operation
            endcase
            write_enable_wire = 1;
            alu_src_wire = 2'b00;
        end

        `OPCODE_I_TYPE: begin
            case (funct3)
                3'b000: alu_op_wire = `ALU_ADDI; // I-Type ADDI
                3'b110: alu_op_wire = `ALU_OR;   // I-Type ORI
                default: alu_op_wire = `ALU_LOAD; // Default I-Type as LOAD
            endcase
            write_enable_wire = 1;
            alu_src_wire = 2'b10;
            mem_read_wire = 1;
	    imm_wire = {{20{instruction[31]}}, instruction[31:20]};  // I-type
        end

        `OPCODE_S_TYPE: begin
            alu_op_wire = `ALU_STORE;   // S-Type STORE
            alu_src_wire = 2'b10;
            mem_write_wire = 1;
	    imm_wire = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};  // S-type
        end

        `OPCODE_B_TYPE: begin
            alu_op_wire = `ALU_BRANCH;  // B-Type BRANCH
            alu_src_wire = 2'b10;
            branch_enable_wire = 1'b1;
	    imm_wire = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // B-type
	    branch_wire = imm_wire;
        end

        `OPCODE_U_TYPE: begin
            alu_op_wire = `ALU_LUI;     // U-Type LUI
            alu_src_wire = 2'b01;
            write_enable_wire = 1;
	    imm_wire = {instruction[31:12], 12'b0}; // U-type
        end

        `OPCODE_J_TYPE: begin
            alu_op_wire = `ALU_JUMP;    // J-Type JUMP
            alu_src_wire = 2'b10;
            write_enable_wire = 1;
            branch_enable_wire = 1'b1;
	    imm_wire = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}; // J-type
	    branch_wire = imm_wire;
        end

    endcase
end

assign alu_op = alu_op_wire; 
assign we = write_enable_wire;      
assign mem_read = mem_read_wire;   
assign mem_write = mem_write_wire;        
assign imm = imm_wire;              
assign alu_src = alu_src_wire;  
assign branch_target = branch_wire;

// Register addresses
assign Rs1_out = instruction[19:15]; 
assign Rs2_out = instruction[24:20]; 
assign Rd_out = instruction[11:7];    

endmodule
