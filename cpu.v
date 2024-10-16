`timescale 1us/100ns

module cpu(
	input wire clk,
	input wire rst

);

// Internal signals
wire [31:0] next_pc;            // Next Program Counter value
wire [31:0] inst_encoding;      // Instruction from IMEM
wire [31:0] rf_out_0;           // Output from Register File (RF) - Source Register 1
wire [31:0] rf_out_1;           // Output from Register File (RF) - Source Register 2
wire next_pc_sel;               // Selection signal for next PC value
wire [31:0] pc_plus_4;          // Incremented PC value
wire [31:0] alu_in_2;		// alu input from 3:1 mux
wire [31:0] alu_out;		// output from alu

  // Program Counter instantiation
Program_Counter pc_module(
	.clk(clk),
	.rst(rst),
	.branch_addy(next_pc),
	.branch_enable(1'b0),
	.PC_out(next_pc)               // Output: Current PC value
);


  // Instruction Memory instantiation
memory2c imem(
	.data_out(inst_encoding),  // Output: Instruction
	.data_in(32'b0),           // No data input for instruction fetch
	.addr(pc),                 // Address: Current PC value
	.enable(1'b1),             // Enable memory read
	.wr(1'b0),                 // No write operation
	.createdump(1'b0),         // No dump creation
	.clk(clk),
	.rst(rst)
);

  

  // Register File instantiation
reg_file rf(
	.Rs1(inst_encoding[19:15]),  	// Source register 1 address (decode)
	.Rs2(inst_encoding[24:20]),  	// Source register 2 address (decode)
	.Rd(inst_encoding[11:7]),	// Destination register address (decode)
	.data_in(32'b0),            	// Data to write (defaulting to zero for now)
	.we(1'b0),                 	// Write enable (defaulting to zero for now)
	.read_data1(rf_out_0),        	// Output: Source register 1 data
	.read_data2(rf_out_1),         	// Output: Source register 2 data
	.alu_src(2'b0),
	.sign_extend(1'b0),
	.zero_extend(1'b0),
	.clk(clk),
	.rst(rst)
);

ALU alu(
	.A(read_data1),               // First operand
	.B(alu_in_2),     	      // Second operand
	.func(data_out),              // Function select
	.out(alu_out)	              // ALU output
	//output c_out                // Carry out, don't need?
);

// DMEM
memory2c dmem(
	.data_out(inst_encoding),  // Output: Instruction
	.data_in(alu_out),         // No data input for instruction fetch
	.addr(pc),                 // Address: Current PC value
	.enable(1'b1),             // Enable memory read
	.wr(1'b0),                 // No write operation
	.createdump(1'b0),         // No dump creation
	.clk(clk),
	.rst(rst)
);

// Next PC selection logic
assign next_pc = (next_pc_sel == 1'b1) ? /* Placeholder for branch or jump target */ 32'b0 : pc_plus_4;

endmodule
