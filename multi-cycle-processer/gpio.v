`timescale 1us/100ns

module gpio(
	input clk,
	input rst,
	input [9:0] d_input,
	input we,
	output[9:0] out
);

register x0  (.d_input(d_input), .we(we),  .clk(clk), .rst(rst), .out(out));

endmodule
