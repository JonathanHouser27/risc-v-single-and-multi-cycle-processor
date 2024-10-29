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
    // wire [31:0] next_pc; 10/29
wire [31:0] pc_plus_4;
wire [31:0] alu_out;
wire [31:0] dmem_out;
wire alu_c_out;

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

// Calculate PC + 4
//assign pc_plus_4 = current_pc + 4; 10/29

// Program Counter instantiation
Program_Counter pc_module(
    .clk(clk),
    .rst(rst),
    .branch_addy(alu_out),  // Use ALU output for branch address
    .branch_enable(branch_enable),
    .PC_out(current_pc)
);

// Instruction Memory instantiation
memory2c imem(
    .data_out(inst_encoding),
    .data_in(32'b0),
    .addr(current_pc),
    .enable(1'b1),
    .wr(1'b0),
    .createdump(1'b0),
    .clk(clk),
    .rst(rst)
);

// decoder instantiation
decode decode(
    .instruction(inst_encoding),
    .clk(clk),
    .rst(rst),
  //  .Rs1(Rs1), 10/29 have the rf separate these
  //  .Rs2(Rs2),
  //  .Rd(Rd),
    .alu_op(alu_op),
    .imm(imm),  // Single immediate output
    .alu_src(alu_src),
    .write_enable(reg_write),
    .mem_read(dmem_read),
    .mem_write(dmem_write),
    .branch(branch_enable)
);

assign rf_data_in = dmem_read ? dmem_out : alu_out;
    
// Register File instantiation
reg_file rf(
    .Rs1(inst_encoding[19:15]),
    .Rs2(inst_encoding[24:20]),
    .Rd(inst_encoding[11:7]),
    .data_in(rf_data_in),  // move logic to the top 10/29
    .we(reg_write),
    .read_data1(rf_out_0),
    .read_data2(rf_out_1),
    .clk(clk),
    .rst(rst)
);

// ALU instantiation
ALU alu(
    .A(rf_out_0),
    .B(rf_out_1),
    .imm(imm),
    .alu_src(alu_src),
    .func(alu_op),
    .out(alu_out),
    .c_out(alu_c_out)
);

// DMEM instantiation
memory2c dmem(
    .data_out(dmem_out),
    .data_in(rf_out_1),  // Store data from register
    .addr(alu_out),      // Use ALU output as address
    .enable(dmem_read | dmem_write),  // Enable on read or write
    .wr(dmem_write),
    .createdump(1'b0),
    .clk(clk),
    .rst(rst)
);

endmodule
