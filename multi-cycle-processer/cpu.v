`timescale 1us/100ns

module cpu (
    input wire clk,
    input wire rst,
    output wire gpio_out
);

    // Signals
    wire [31:0] current_pc;
    wire [31:0] inst_encoding;
    wire [31:0] rf_out_1;
    wire [31:0] rf_out_2;
    wire [31:0] alu_out;
    wire [31:0] dmem_out;
    wire [31:0] branch_target;
    wire [31:0] rf_in_latch;
    wire branch_taken;
    wire [31:0] XM_alu_out;
    wire [31:0] XM_imm_out;
    wire [31:0] XM_mem_write_data;
    wire XM_rf_write_enable;
    wire XM_mem_write_enable;
    wire XM_mem_read_enable;
    wire [1:0] XM_rf_mux_control;
    wire [4:0] Rd_WB;
    wire reg_write;
    wire dmem_write;
    wire mem_read;
    wire [4:0] alu_op;
    wire [4:0] Rs1;
    wire [4:0] Rs2;
    wire [4:0] Rd;
    wire [31:0] imm;
    wire [1:0] rf_select_in;

    // GPIO Signals
    wire [3:0] gpio_leds;          // Output to LEDs
    wire [3:0] gpio_switches;      // Input from switches
    wire [7:0] gpio_address;       // Address for GPIO
    wire gpio_write_enable;        // Write enable for GPIO
    wire [3:0] gpio_write_data;    // Data to write to GPIO
    wire [3:0] gpio_read_data;     // Data read from GPIO

    // Program Counter
    Program_Counter pc_module(
        .clk(clk),
        .rst(rst),
        .branch_addy(branch_target),
        .branch_enable(branch_taken),
        .PC_out(current_pc)		//Output
    );

    // Instruction Memory
    IMEM imem (
        .address(current_pc[31:2]),
        .clock(clk),
        .q(inst_encoding)		//Output
    );

    // Decode Stage
    decode decode(
        .clk(clk),
        .rst(rst),
        .instruction(inst_encoding),	//Output
        .rf_input_src(rf_select_in),	//Output
        .alu_op(alu_op),		//Output
        .we(reg_write),			//Output
        .mem_write(dmem_write),		//Output
        .mem_read(mem_read),		//Output
        .branch_target(branch_target),	//Output
        .imm(imm),			//Output
        .Rs1_out(Rs1),			//Output
        .Rs2_out(Rs2),			//Output
        .Rd_out(Rd)			//Output
    );

    // Register File
    reg_file rf(
        .Rs1(Rs1),
        .Rs2(Rs2),
        .Rd(Rd_WB),
        .data_in(rf_in_latch),
        .we(XM_rf_write_enable),  
        .read_data1(rf_out_1),
        .read_data2(rf_out_2),
        .clk(clk),
        .rst(rst)
    );

    // ALU
    ALU alu(
        .A(rf_out_1),
        .B(rf_out_2),
        .imm(imm),
 	.func(alu_op),
        .out(alu_out),
        .branch_taken(branch_taken)  // Ensure this is correctly derived
    );

    // Execute-Memory Latch
    XM_Latch XM(
        .alu_out(alu_out),
        .imm_out(imm),
        .mem_write_data(rf_out_2),
        .rf_write_enable(reg_write),
        .mem_write_enable(dmem_write),
        .mem_read_enable(mem_read),
        .rf_mux_control(rf_select_in),
        .rd(Rd),
        .clk(clk),
        .rst(rst),
        .XM_alu_out(XM_alu_out),
        .XM_imm_out(XM_imm_out),
        .XM_mem_write_data(XM_mem_write_data),
        .XM_rf_write_enable(XM_rf_write_enable),
        .XM_mem_write_enable(XM_mem_write_enable),
        .XM_mem_read_enable(XM_mem_read_enable),
        .XM_rf_mux_control(XM_rf_mux_control),
        .Rd_WB(Rd_WB)
    );

    // Data Memory
    DMEM dmem(
        .address(XM_alu_out),
        .clock(clk),
        .data(XM_mem_write_data),
        .wren(XM_mem_write_enable & ! XM_alu_out[31]),
        .q(dmem_out)
    );

    // GPIO Module Instantiation
    gpio gpio_attempt (
        .clk(clk),
        .rst(rst),
	.d_input(XM_mem_write_data),
	.we(XM_mem_write_enable & XM_alu_out[31]),
	.out(gpio_out)
    );

    // Register File Mux
    mux_4to1 rf_mux_in(
        .in1(XM_alu_out),
        .in2(dmem_out),
        .in3(XM_imm_out),
        .in4(32'b0),		//.in4(gpio_read_data), // Include GPIO read data as an option
        .sel(XM_rf_mux_control),
        .Y(rf_in_latch)
    );

endmodule
