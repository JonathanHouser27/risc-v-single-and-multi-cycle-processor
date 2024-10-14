`timescale 1us/100ns

module Program_Counter(
	input clk, rst,		// clock and reset signals
	input [31:0] branch_addy,		// address to jump to on a branch
	input branch_enable,		// branch enable signal
	output [31:0] PC_out
);

wire[31:0] pc_next;
wire[31:0] pc_plus4;

// PC + 4 logic
assign pc_plus4 = PC_out + 32'd4; // increment pc by 4


// 2:1 MUX to select between PC+4 and a branch address
assign pc_next = (branch_enable) ? branch_addy : pc_plus4;

// dflop register
Register pc_register (
	.clk(clk),
	.rst(rst),
	.d_in(pc_next),
	.q_out(PC_out)
);

endmodule
