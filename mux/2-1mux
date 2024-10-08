`timescale 1us/100ns

module mux_2to1(
	input [31:0] in1, 
	input [31:0] in2,
	input sel,
	output [31:0] Y
);

	// use ternary operators, because that is easiest
	assign Y = (sel == 1'b0) ? in1 : in2;

endmodule
