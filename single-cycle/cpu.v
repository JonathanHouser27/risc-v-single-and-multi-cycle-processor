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
wire [1:0] rf_select_in;
wire [31:0] imm_ext;         // Extended Immediate value
wire [31:0] rf_in;

// Program Counter instantiation
Program_Counter pc_module(
    .clk(clk),                         // Input
    .rst(rst),                         // Input
    .branch_addy(branch_target),       // Input
    .branch_enable(branch_taken),      // Input
    .return_addr(current_pc + 4),      // Link address to save in Ra
    .PC_out(current_pc)                // Output
);

// Instruction Memory instantiation
memory2c imem(
    .data_out(inst_encoding),          // Output
    .data_in(32'b0),                   // Input (unused for read)
    .addr(current_pc),                 // Input (PC address)
    .enable(1'b1),                     // Input (enable memory access)
    .wr(1'b0),                         // Input (write disable for instruction memory)
    .createdump(1'b0),                 // Input (disable memory dump)
    .clk(clk),                         // Input (clock)
    .rst(rst)                          // Input (reset)
);

// Decoder instantiation
decode decode(
    .clk(clk),
    .rst(rst),
    .instruction(inst_encoding),
    .rf_input_src(rf_select_in),
    .alu_op(alu_op),
    .we(reg_write),
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
    .Rs1(Rs1),                         // Input
    .Rs2(Rs2),                         // Input
    .Rd(Rd),                           // Input
    .data_in(rf_in),                   // Input
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
    .imm(imm),                          // Input (immediate value)
    .alu_src(alu_src),                  // Input (ALU source selection)
    .func(alu_op),                      // Input (ALU operation code)
    .out(alu_out),                      // Output (ALU result)
    .c_out(alu_c_out),                  // Output (carry-out flag)
    .branch_taken(branch_taken)        // Output (branch taken flag)
);

// Data Memory instantiation
memory2c dmem(
    .data_out(dmem_out),                // Output (data from memory)
    .data_in(alu_out),                  // Input (data to memory)
    .addr(alu_out),                     // Input (address to memory)
    .enable(dmem_read),                 // Input (memory read enable)
    .wr(dmem_write),                    // Input (memory write enable)
    .createdump(1'b0),                  // Input (disable memory dump)
    .clk(clk),                          // Input (clock)
    .rst(rst)                           // Input (reset)
);

// Output selection based on memory read or ALU result
assign rf_in = (dmem_read) ? dmem_out : alu_out;

endmodule
