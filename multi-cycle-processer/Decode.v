`timescale 1us/100ns

`include "Definition_List.v"

module decode (
    input clk,
    input rst,
    input [31:0] instruction,
    output reg [1:0] rf_input_src,
    output reg [4:0] alu_op,
    output reg we,
    output reg mem_write,
    output reg mem_read,
    output reg [31:0] branch_target,
    output reg [31:0] imm,
    output reg [4:0] Rs1_out,    
    output reg [4:0] Rs2_out,
    output reg [4:0] Rd_out
);

    // Instruction fields
    wire [6:0] opcode = instruction[6:0];
    wire [2:0] funct3 = instruction[14:12];  
    wire [6:0] funct7 = instruction[31:25];

    always @(*) begin    
            // Assign values specific to each opcode
            case (opcode)
                // R-Type Instructions
                `OPCODE_R_TYPE: begin
                    Rs1_out <= instruction[19:15]; // Rs1 for R-type
                    Rs2_out <= instruction[24:20]; // Rs2 for R-type
                    Rd_out <= instruction[11:7];   // Rd for R-type
		    alu_op <= 5'bxxxxx;
                    case (funct3)
                        `FUNCT3_ADD: alu_op <= (funct7 == `FUNCT7_SUB) ? `ALU_SUB : `ALU_ADD;
                        `FUNCT3_AND: alu_op <= `ALU_AND;
                        `FUNCT3_OR:  alu_op <= `ALU_OR;
			`FUNCT3_XOR: alu_op <= `ALU_XOR;
                        `FUNCT3_SLT: alu_op <= `ALU_SLT;
                        default:     alu_op <= 5'b11111; // Undefined
                    endcase
                    rf_input_src <= 2'b00; // ALU output to regfile
                    we <= 1'b1;
		    branch_target <= 32'b0;
		    mem_read <= 1'b0;
		    mem_write <= 1'b0;
		    imm <= 32'b0;
                end

                // I-Type Instructions
                `OPCODE_I_TYPE: begin
                    Rs1_out <= instruction[19:15]; // Rs1 for I-type
                    Rs2_out <= 5'b0;               // No Rs2 for I-type
                    Rd_out <= instruction[11:7];   // Rd for I-type
		    alu_op <= 5'b00000;
                    case (funct3)
                        `FUNCT3_ADDI: alu_op <= `ALU_ADDI;
                        `FUNCT3_ORI:  alu_op <= `ALU_ORI;
                        `FUNCT3_LW:   alu_op <= `ALU_LOAD;
                        `FUNCT3_SLTI: alu_op <= `ALU_SLTI;
			`FUNCT3_XORI: alu_op <= `ALU_XORI;
			`FUNCT3_ANDI: alu_op <= `ALU_ANDI;
                        default:      alu_op <= 5'b11111; // Undefined
                    endcase
                    rf_input_src <= 2'b00; 
                    we <= 1'b1;
                    mem_read <= 1'b1;      // Enable memory read
		    mem_write <= 1'b0;
		    imm <= {{20{instruction[31]}}, instruction[31:20]};
		    branch_target <= 32'b0;
                end

                // S-Type Instructions
                `OPCODE_S_TYPE: begin
                    Rs1_out <= instruction[19:15]; // Rs1 for S-type
                    Rs2_out <= instruction[24:20]; // Rs2 for S-type
                    Rd_out <= 5'b0;               // No Rd for S-type
                    alu_op <= `ALU_STORE;         // ALU operation for store
                    imm <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // Sign-extend immediate
                    mem_write <= 1'b1;            // Enable memory write
		    branch_target <= 32'b0;
                    rf_input_src <= 2'b01; // DMEM read to regfile
                    we <= 1'b1;
                    mem_read <= 1'b1;      // Enable memory read
                end

                // B-Type Instructions
                `OPCODE_B_TYPE: begin
                    Rs1_out <= instruction[19:15]; // Rs1 for B-type
                    Rs2_out <= instruction[24:20]; // Rs2 for B-type
                    Rd_out <= 5'b0;                // No Rd for B-type
		    alu_op <= 5'b00000;
                    case (funct3)
                        `FUNCT3_BEQ: alu_op <= `ALU_BEQ;
                        `FUNCT3_BNE: alu_op <= `ALU_BNE;
                        `FUNCT3_BLT: alu_op <= `ALU_BLT;
                        `FUNCT3_BGE: alu_op <= `ALU_BGE;
                        default:     alu_op <= `ALU_BRANCH; // Undefined
                    endcase
                    branch_target <= {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // Calculate branch target
		    imm <= 32'b0;
		    we <= 1'b0;
		    rf_input_src <= 2'b11;
		    mem_write <= 1'b0;
		    mem_read <= 1'b0;

                end

                // J-Type Instructions
                `OPCODE_J_TYPE: begin
                    Rs1_out <= 5'b0;               // No Rs1 for J-type
                    Rs2_out <= 5'b0;               // No Rs2 for J-type
                    Rd_out <= instruction[11:7];   // Rd for J-type
		    alu_op <= `ALU_JUMP;
                    branch_target <= {{13{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21]};
		    mem_write <= 1'b0;
		    mem_read <= 1'b0;
		    rf_input_src <= 2'bxx;
		    imm <= 32'b0;
		    we = 1'b0;
                end

   		`OPCODE_U_TYPE: begin
            	    alu_op = `ALU_LUI;     // U-Type LUI
            	    branch_target = 32'b0;
            	    rf_input_src = 2'b10;
            	    mem_write = 1'b0;
		    mem_read = 1'b0;
            	    imm = {instruction[31:12], 12'b0}; // U-type immediate
            	    Rs1_out = 5'bxxxxx; // LUI does not use Rs1
            	    Rs2_out = 5'bxxxxx; // LUI does not use Rs2
            	    Rd_out = instruction[11:7]; // Rd is written to in LUI
		    we = 1'b1;	    
        	end
                default: begin
                    // Handle unexpected opcodes
                    Rs1_out <= 5'bxxxxx;               
                    Rs2_out <= 5'bxxxxx;               
                    Rd_out <= 5'bxxxxx;		       
		    alu_op <= 5'bxxxxx;
                    branch_target <= 32'bx;
		    mem_write <= 1'b0;
		    mem_read <= 1'bx;
		    rf_input_src <= 2'bxx;
		    imm <= 32'bx;
		    we = 1'b0;
                end
            endcase
        end
endmodule
