`timescale 1us/100ns

module cpu (
    input wire clk,
    input wire rst
);


// Internal signals
wire [31:0] current_pc;
wire [31:0] inst_encoding;
wire [31:0] rf_out_0;
wire [31:0] rf_out_1;
wire [31:0] alu_out;
wire [31:0] dmem_out;
wire [31:0] branch_target;
wire alu_c_out;
wire branch_taken;

// From decode stage
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
wire [1:0] rf_select_in;
wire [31:0] rf_in;

// Program Counter instantiation
Program_Counter pc_module(
    .clk(clk),                         // Input
    .rst(rst),                         // Input
    .branch_addy(branch_target),       // Input (branch address)
    .branch_enable(branch_taken),      // Input (branch enable)
    .return_addr(current_pc + 32'd4),  // Link address to save in Ra
    .PC_out(current_pc)                // Output (current PC value)
);


// Instruction Memory instantiation
IMEM imem (
    .address(current_pc),
    .clock(clk),
    .q(inst_encoding)
);


// Decoder instantiation
decode decode(
    .clk(clk),
    .rst(rst),
    .instruction(inst_encoding),
    .rf_input_src(rf_select_in),
    .alu_op(alu_op),
    .we(reg_write),                    // Output (register file write enable)
    .mem_read(dmem_read),
    .mem_write(dmem_write),
    .branch_target(branch_target),
    .branch_enable(branch_enable),
    .imm(imm),
    .alu_src(alu_src),
    .Rs1_out(Rs1),    
    .Rs2_out(Rs2),
    .Rd_out(Rd)
);

// Register File instantiation
reg_file rf(
    .Rs1(Rs1),                         // Input (read from Rs1)
    .Rs2(Rs2),                         // Input (read from Rs2)
    .Rd(Rd),                           // Input (write to Rd)
    .data_in(rf_in),                   // Input (data to be written to RF)
    .we(reg_write),                    // Input (write enable)
    .read_data1(rf_out_0),             // Output (data from Rs1)
    .read_data2(rf_out_1),             // Output (data from Rs2)
    .clk(clk),                         // Input (clock)
    .rst(rst)                          // Input (reset)
);

// ALU instantiation
ALU alu(
    .A(rf_out_0),                      // Input (from Rs1)
    .B(rf_out_1),                      // Input (from Rs2)
    .imm(imm),                         // Input (immediate value)
    .alu_src(alu_src),                 // Input (ALU source selection)
    .func(alu_op),                     // Input (ALU operation code)
    .out(alu_out),                     // Output (ALU result)
    .c_out(alu_c_out),                 // Output (carry-out flag)
    .branch_taken(branch_taken)        // Output (branch taken flag)
);

latch XM(
    .d_input1(alu_out),   		// ALU_output 0-31	
    .d_input2(imm), 			// immediate value 32-63
    .d_input3(rf_select_in),		// rf_input mux select 64-65
    .we(reg_write),            		// Write enable
    .clk(clk),               		// Clock signal
    .rst(rst),               		// Reset signal
    .out(rf_in)        			// Output data
);


// Data Memory instantiation
DMEM dmem(
    .address(alu_out),
    .clock(clk),
    .data(alu_out),
    .wren(dmem_write),
    .q(dmem_out)
);


// Assigning proper value to rf_in based on memory read or ALU result
assign rf_in = (dmem_read) ? dmem_out : rf_in;  // Memory read data if dmem_read is high, else ALU output


endmodule
