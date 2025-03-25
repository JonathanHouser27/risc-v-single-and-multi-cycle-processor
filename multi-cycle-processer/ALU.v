`timescale 1us/100ns

`include "Definition.v"

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
//	`ALU_ANDI: begin
//		out = A & imm;
//		branch_taken = 1'b0;
//	end
        `ALU_OR: begin
		out = A | B;
		branch_taken = 1'b0;
	end
//        `ALU_ORI: begin
//		out = A | imm;
//		branch_taken = 1'b0;
//	end
//        `ALU_XOR: begin
//		out = A ^ B;
//		branch_taken = 1'b0;
//	end
//        `ALU_XORI: begin
//		out = A ^ imm;
//		branch_taken = 1'b0;
//	end
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
