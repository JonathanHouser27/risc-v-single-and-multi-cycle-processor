`timescale 1us/100ns

module Program_Counter(
    input clk,
    input rst,                // Reset signal
    input [31:0] branch_addy, // Address to jump to on a branch
    input branch_enable,      // Branch enable signal
    output [31:0] PC_out      // PC output as a wire
);

wire [31:0] next_PC;          // Next value of the program counter

assign next_PC = (rst) ? 32'b0 :		// Reset
		 (branch_enable) ? branch_addy:	// Branch
		 (PC_out + 32'd4);		// plus 4

register pc_register (
    .clk(clk),
    .rst(rst),
    .we(1'b1),
    .d_input(next_PC),
    .out(PC_out)
);

endmodule
