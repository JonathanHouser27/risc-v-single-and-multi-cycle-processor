`timescale 1us/100ns

module mux_4to1(
	input [31:0] in1,		
	input [31:0] in2,		
	input [31:0] in3,		
	input [31:0] in4,		
	input [1:0] sel,	// selector
	output [31:0] Y		// output 'Y'
);

	// use ternary operators, because that is easiest
    	assign Y = (sel == 2'b00) ? in1 :
		(sel == 2'b01) ? in2 :
                (sel == 2'b10) ? in3 :
                (sel == 2'b11) ? in4 : 32'b0; // Default to 0


endmodule
