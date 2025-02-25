`timescale 1us/100ns

module Program_Counter(
    input clk,                          // Clock signal
    input rst,                          // Reset signal
    input [31:0] branch_addy,           // Address to jump to on a branch
    input branch_enable,                // Branch enable signal
    output [31:0] PC_out                
);

wire [31:0] next_PC;                    // Next value of the program counter
wire [31:0] current_pc;

// Determine next PC based on jump or branch
assign next_PC = (rst) ? 32'b0 :       			// Reset to 0 (or another value)
	         (branch_enable) ? current_pc + branch_addy :	// Branch
                 (current_pc + 32'd4);           		// Normal PC increment

// Program Counter Register
register pc_register (
    .clk(clk),
    .rst(rst),                           // Reset signal passed to register
    .we(1'b1),                           // Always write-enable
    .d_input(next_PC),                   // Input to PC register (next_PC)
    .out(current_pc)                      // Output of PC register
);

// Output PC as the full 32-bit value
assign PC_out = next_PC;

endmodule
