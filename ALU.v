`timescale 1us/100ns

module ALU (
	input [31:0] A,                // First operand
	input [31:0] B,                // Second operand
	input [2:0] func,              // Function select
	output [31:0] out,             // ALU output
	output c_out                   // Carry out
);

// Intermediate signals
wire [31:0] add_result;
wire [31:0] sub_result;
wire add_c_out;
wire sub_c_out;

// Addition and Subtraction with carry out
assign {add_c_out, add_result} = A + B;         // ADD
assign {sub_c_out, sub_result} = A - B;         // SUBTRACT

// ALU output and carry out logic
assign out = (func == 3'b000) ? add_result :    // ADD
             (func == 3'b001) ? sub_result :    // SUBTRACT
             (func == 3'b010) ? A & B :         // AND
             (func == 3'b011) ? A | B :         // OR
             (func == 3'b100) ? A ^ B :         // XOR
             (func == 3'b101) ? ~A :            // NOT
	     (func == 3'b110) ? A >> 1:		// Shift right 1	
             32'b0;                             // Default

assign c_out = (func == 3'b000) ? add_c_out :   // Carry out for ADD
               (func == 3'b001) ? sub_c_out :   // Carry out for SUBTRACT
               1'b0;                            // No carry out for other operations

endmodule
