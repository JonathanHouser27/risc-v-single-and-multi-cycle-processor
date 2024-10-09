`timescale 1us/100ns

module cpu(
  input wire clk,
  input wire rst
);

  // Internal signals
  wire [31:0] pc;                 // Program Counter value
  wire [31:0] next_pc;            // Next Program Counter value
  wire [31:0] inst_encoding;      // Instruction from IMEM
  wire [31:0] rf_out_0;           // Output from Register File (RF) - Source Register 1
  wire [31:0] rf_out_1;           // Output from Register File (RF) - Source Register 2
  wire next_pc_sel;               // Selection signal for next PC value
  wire [31:0] pc_plus_4;          // Incremented PC value

  // Program Counter instantiation
  Program_Counter pc_module(
    .clk(clk),
    .reset(rst),
    .PC_in(next_pc),          // Input: Next PC value
    .PC_out(pc)               // Output: Current PC value
  );

  // PCplus4 instantiation: Computes PC + 4
  PCplus4 pc_plus4_module(
    .fromPC(pc),               // Input: Current PC value
    .NexttoPC(pc_plus_4)       // Output: PC + 4
  );

  // Instruction Memory instantiation
  memory2c imem(
    .data_out(inst_encoding),         // Output: Instruction
    .data_in(32'b0),                  // No data input for instruction fetch
    .addr(pc),                        // Address: Current PC value
    .enable(1'b1),                    // Enable memory read
    .wr(1'b0),                        // No write operation
    .createdump(1'b0),                // No dump creation
    .clk(clk),
    .rst(rst)
  );

  // Decoder instantiation: Determines next PC selection
  decode decoder_module(
    .inst_encoding(inst_encoding),    // Input: Instruction
    .next_pc_sel(next_pc_sel)         // Output: Next PC select signal
  );

  reg_file my_reg_file (
    .data_in(data_in),         // Connect data input
    .Rs1(Rs1),                 // Connect Rs1 input
    .Rs2(Rs2),                 // Connect Rs2 input
    .Rd(Rd),                   // Connect Rd input
    .we(we),                   // Connect write enable
    .clk(clk),                 // Connect clock signal
    .rst(rst),                 // Connect reset signal
    .sign_extend(1'b0),       // Sign extension control (set as needed)
    .zero_extend(1'b0),       // Zero extension control (set as needed)
    .read_data1(read_data1),   // Connect read_data1 output
    .read_data2(read_data2)    // Connect read_data2 output
);

  // Next PC selection logic
  assign next_pc = (next_pc_sel == 1'b1) ? /* Placeholder for branch or jump target */ 32'b0 : pc_plus_4;
  
endmodule
