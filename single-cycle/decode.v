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
    output [1:0] rf_input_src,
    output [3:0] alu_op,
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

// Instruction fields
wire [6:0] opcode = instruction[6:0];
wire [2:0] funct3 = instruction[14:12];  
wire [6:0] funct7 = instruction[31:25];  // Extract funct7 for R-Type instructions

// Control wires
reg [3:0] alu_op_wire;    
reg write_enable_wire, mem_read_wire, mem_write_wire, branch_enable_wire;
reg [1:0] alu_src_wire;
reg [31:0] imm_wire;
reg [31:0] branch_wire;
reg [1:0] rf_input = 2'b11;

// Register addresses (default values)
reg [4:0] Rs1_out_reg, Rs2_out_reg, Rd_out_reg;

// Combinational logic for decoding
always @* begin
    // Default values to prevent latches
    alu_op_wire = 4'b1111;
    write_enable_wire = 1'b0;
    mem_read_wire = 1'b0;
    mem_write_wire = 1'b0;
    alu_src_wire = 2'b00;
    branch_wire = 32'b0;
    imm_wire = 32'b0;
    branch_enable_wire = 1'b0;

    // Default register outputs
    Rs1_out_reg = instruction[19:15]; // Default Rs1
    Rs2_out_reg = instruction[24:20]; // Default Rs2
    Rd_out_reg = instruction[11:7];   // Default Rd
    
    // Default control inputs
    rf_input = 2'b11;

    case (opcode)
        `OPCODE_R_TYPE: begin
            case (funct3)
                3'b000: begin
                    if (funct7 == 7'b0100000) // Check funct7 for 'sub'
                        alu_op_wire = `ALU_SUB;  // R-Type SUB
                    else
                        alu_op_wire = `ALU_ADD;  // R-Type ADD
                end
                3'b111: alu_op_wire = `ALU_AND;  // R-Type AND
                default: alu_op_wire = 4'b1111;  // Undefined R-Type operation
            endcase
            write_enable_wire = 1;
            alu_src_wire = 2'b00;
            // Rs1, Rs2, and Rd are already assigned above
        end

        `OPCODE_I_TYPE: begin
            case (funct3)
                3'b000: alu_op_wire = `ALU_ADDI; // I-Type ADDI
                3'b110: alu_op_wire = `ALU_OR;   // I-Type ORI
                default: alu_op_wire = `ALU_LOAD; // Default I-Type as LOAD
            endcase
            rf_input = 2'b10;
            write_enable_wire = 1;
            alu_src_wire = 2'b10;
            mem_read_wire = 0;
            imm_wire = {{20{instruction[31]}}, instruction[31:20]};  // I-type immediate
            // Rs1, Rs2, and Rd are already assigned above
        end

        `OPCODE_S_TYPE: begin
            alu_op_wire = `ALU_STORE;   // S-Type STORE
            alu_src_wire = 2'b10;
            mem_write_wire = 1'b1;
            imm_wire = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};  // S-type immediate
            // Rs1, Rs2, and Rd are not needed for S-Type, but Rs1 will be used
            Rs1_out_reg = instruction[19:15]; // Rs1 is used in Store
            Rs2_out_reg = instruction[24:20]; // Rs2 is used in Store
        end

        `OPCODE_B_TYPE: begin
            alu_op_wire = `ALU_BRANCH;  // B-Type BRANCH
            alu_src_wire = 2'b10;
            branch_enable_wire = 1'b1;
            imm_wire = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // B-type immediate
            branch_wire = imm_wire;
            // Rs1 and Rs2 are needed for comparison in branching
            Rs1_out_reg = instruction[19:15];
            Rs2_out_reg = instruction[24:20];
            Rd_out_reg = 5'b00000; // Branch does not use Rd
        end

        `OPCODE_U_TYPE: begin
            alu_op_wire = `ALU_LUI;     // U-Type LUI
            alu_src_wire = 2'b01;
            rf_input = 2'b01;
            write_enable_wire = 1;
            imm_wire = {instruction[31:12], 12'b0}; // U-type immediate
            // Rs1, Rs2, and Rd are not used in LUI (Rd is written to)
            Rs1_out_reg = 5'b00000; // LUI does not use Rs1
            Rs2_out_reg = 5'b00000; // LUI does not use Rs2
            Rd_out_reg = instruction[11:7]; // Rd is written to in LUI
        end

        `OPCODE_J_TYPE: begin
            alu_op_wire = `ALU_JUMP;    // J-Type JUMP
            alu_src_wire = 2'b10;
            write_enable_wire = 1;
            branch_enable_wire = 1'b1;
            imm_wire = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}; // J-type immediate
            branch_wire = imm_wire;
            // Rs1, Rs2, and Rd are not used in JUMP
            Rs1_out_reg = 5'b00000; // JUMP does not use Rs1
            Rs2_out_reg = 5'b00000; // JUMP does not use Rs2
            Rd_out_reg = instruction[11:7]; // Rd is written to in JUMP
        end

        default: begin
            // In case the opcode doesn't match any of the known types
            Rs1_out_reg = 5'b00000; // Default value for Rs1
            Rs2_out_reg = 5'b00000; // Default value for Rs2
            Rd_out_reg = 5'b00000;  // Default value for Rd
        end
    endcase
end

// Assignments to outputs
assign alu_op = alu_op_wire; 
assign we = write_enable_wire;      
assign mem_read = mem_read_wire;   
assign mem_write = mem_write_wire;        
assign imm = imm_wire;              
assign alu_src = alu_src_wire;  
assign branch_target = branch_wire;
assign branch_enable = branch_enable_wire;
assign rf_input_src = rf_input;

// Register addresses
assign Rs1_out = Rs1_out_reg;
assign Rs2_out = Rs2_out_reg;
assign Rd_out = Rd_out_reg;

endmodule
