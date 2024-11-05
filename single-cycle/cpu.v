`timescale 1us/100ns

module cpu(
    input wire clk,
    input wire rst
);

// Internal signals
wire [31:0] current_pc;
wire [31:0] inst_encoding;
wire [31:0] rf_out_0;
wire [31:0] rf_out_1;
wire [31:0] rf_data_in;
wire [31:0] pc_plus_4;
wire [31:0] alu_out;
wire [31:0] dmem_out;
wire [31:0] branch_target;
wire alu_c_out;
wire branch_taken;

// from decode
wire reg_write;
wire [1:0] alu_src;
wire [3:0] alu_op;
wire dmem_write;
wire dmem_read;
wire [4:0] Rs1;
wire [4:0] Rs2;
wire [4:0] Rd;
wire branch_enable;
wire [31:0] imm;


// Program Counter instantiation
Program_Counter pc_module(
    .clk(clk),				// Input
    .rst(rst),				// Input
    .branch_addy(branch_target),	// Input
    .branch_enable(branch_taken),	// Input
    .PC_out(current_pc)			// Output
);

// Instruction Memory instantiation
memory2c imem(
    .data_out(inst_encoding),		// Output
    .data_in(32'b0),			// Input
    .addr(current_pc),			// Input
    .enable(1'b1),			// Input
    .wr(1'b0),				// Input
    .createdump(1'b0),			// Input
    .clk(clk),				// Input
    .rst(rst)				// Input
);

// decoder instantiation
decode decode(
    .instruction(inst_encoding),	// Input
    .Rs1_out(Rs1),			// Output
    .Rs2_out(Rs2),			// Output
    .Rd_out(Rd),			// Output
    .clk(clk),				// Input
    .rst(rst),				// Input
    .alu_op(alu_op),			// Output
    .imm(imm),  			// Output
    .alu_src(alu_src),			// Output
    .we(reg_write),			// Output
    .mem_read(dmem_read),		// Output
    .mem_write(dmem_write),		// Output
    .branch_target(branch_target),	// Output
    .branch_enable(branch_enable)	// Output
);


// Register File instantiation
reg_file rf(
    .Rs1(Rs1),				// Input
    .Rs2(Rs2),				// Input
    .Rd(Rd),				// Input
    .data_in(rf_data_in),		// Input
    .we(reg_write),			// Input
    .read_data1(rf_out_0),		// Output
    .read_data2(rf_out_1),		// Output
    .clk(clk),				// Input
    .rst(rst)				// Input
);

// ALU instantiation
ALU alu(
    .A(rf_out_0),			// Input
    .B(rf_out_1),			// Input
    .imm(imm),				// Input
    .alu_src(alu_src),			// Input
    .func(alu_op),			// Input
    .out(alu_out),			// Output
    .c_out(alu_c_out),			// Output
    .branch_taken(branch_taken)		// Output
);

// DMEM instantiation
memory2c dmem(
    .data_out(dmem_out),		// Output
    .data_in(alu_out),  		// Input
    .addr(alu_out), 			// Input   
    .enable(dmem_read),  		// Input
    .wr(dmem_write),			// Input
    .createdump(1'b0),			// Input
    .clk(clk),				// Input
    .rst(rst)				// Input
);

assign rf_data_in = dmem_read ? dmem_out : alu_out;

endmodule
