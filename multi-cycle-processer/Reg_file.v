`timescale 1us/100ns

module reg_file(
        input [31:0] data_in,       // Data input for registers
        input [4:0] Rs1,            // Read register 1 address
        input [4:0] Rs2,            // Read register 2 address
        input [4:0] Rd,             // Write register address
        input we,                   // Write enable
        input clk,                  // Clock signal
        input rst,                  // Reset signal
        output [31:0] read_data1,   // Data output for register 1
        output [31:0] read_data2    // Data output for register 2
);

    // Output wires for each register
    wire [31:0] reg_out0, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5;
    wire [31:0] reg_out6, reg_out7, reg_out8, reg_out9, reg_out10, reg_out11;
    wire [31:0] reg_out12, reg_out13, reg_out14, reg_out15, reg_out16, reg_out17;
    wire [31:0] reg_out18, reg_out19, reg_out20, reg_out21, reg_out22, reg_out23;
    wire [31:0] reg_out24, reg_out25, reg_out26, reg_out27, reg_out28, reg_out29;
    wire [31:0] reg_out30, reg_out31;
    wire [31:0] read_data_out_1, read_data_out_2;
    
    // Instantiate each register explicitly with reset functionality
    register x0  (.d_input(32'b0),       .we(we && (Rd == 5'b00000)),     .clk(clk), .rst(rst), .out(reg_out0));  // x0 is hardwired to 0
    register x1  (.d_input(data_in),     .we(we && (Rd == 5'b00001)), .clk(clk), .rst(rst), .out(reg_out1));
    register sp  (.d_input(data_in),     .we(we && (Rd == 5'b00010)), .clk(clk), .rst(rst), .out(reg_out2));
    register x3  (.d_input(data_in),     .we(we && (Rd == 5'b00011)), .clk(clk), .rst(rst), .out(reg_out3));
    register x4  (.d_input(data_in),     .we(we && (Rd == 5'b00100)), .clk(clk), .rst(rst), .out(reg_out4));
    register x5  (.d_input(data_in),     .we(we && (Rd == 5'b00101)), .clk(clk), .rst(rst), .out(reg_out5));
    register x6  (.d_input(data_in),     .we(we && (Rd == 5'b00110)), .clk(clk), .rst(rst), .out(reg_out6));
    register x7  (.d_input(data_in),     .we(we && (Rd == 5'b00111)), .clk(clk), .rst(rst), .out(reg_out7));
    register x8  (.d_input(data_in),     .we(we && (Rd == 5'b01000)), .clk(clk), .rst(rst), .out(reg_out8));
    register x9  (.d_input(data_in),     .we(we && (Rd == 5'b01001)), .clk(clk), .rst(rst), .out(reg_out9));
    register x10 (.d_input(data_in),     .we(we && (Rd == 5'b01010)), .clk(clk), .rst(rst), .out(reg_out10));
    register x11 (.d_input(data_in),     .we(we && (Rd == 5'b01011)), .clk(clk), .rst(rst), .out(reg_out11));
    register x12 (.d_input(data_in),     .we(we && (Rd == 5'b01100)), .clk(clk), .rst(rst), .out(reg_out12));
    register x13 (.d_input(data_in),     .we(we && (Rd == 5'b01101)), .clk(clk), .rst(rst), .out(reg_out13));
    register x14 (.d_input(data_in),     .we(we && (Rd == 5'b01110)), .clk(clk), .rst(rst), .out(reg_out14));
    register x15 (.d_input(data_in),     .we(we && (Rd == 5'b01111)), .clk(clk), .rst(rst), .out(reg_out15));
    register x16 (.d_input(data_in),     .we(we && (Rd == 5'b10000)), .clk(clk), .rst(rst), .out(reg_out16));
    register x17 (.d_input(data_in),     .we(we && (Rd == 5'b10001)), .clk(clk), .rst(rst), .out(reg_out17));
    register x18 (.d_input(data_in),     .we(we && (Rd == 5'b10010)), .clk(clk), .rst(rst), .out(reg_out18));
    register x19 (.d_input(data_in),     .we(we && (Rd == 5'b10011)), .clk(clk), .rst(rst), .out(reg_out19));
    register x20 (.d_input(data_in),     .we(we && (Rd == 5'b10100)), .clk(clk), .rst(rst), .out(reg_out20));
    register x21 (.d_input(data_in),     .we(we && (Rd == 5'b10101)), .clk(clk), .rst(rst), .out(reg_out21));
    register x22 (.d_input(data_in),     .we(we && (Rd == 5'b10110)), .clk(clk), .rst(rst), .out(reg_out22));
    register x23 (.d_input(data_in),     .we(we && (Rd == 5'b10111)), .clk(clk), .rst(rst), .out(reg_out23));
    register x24 (.d_input(data_in),     .we(we && (Rd == 5'b11000)), .clk(clk), .rst(rst), .out(reg_out24));
    register x25 (.d_input(data_in),     .we(we && (Rd == 5'b11001)), .clk(clk), .rst(rst), .out(reg_out25));
    register x26 (.d_input(data_in),     .we(we && (Rd == 5'b11010)), .clk(clk), .rst(rst), .out(reg_out26));
    register x27 (.d_input(data_in),     .we(we && (Rd == 5'b11011)), .clk(clk), .rst(rst), .out(reg_out27));
    register x28 (.d_input(data_in),     .we(we && (Rd == 5'b11100)), .clk(clk), .rst(rst), .out(reg_out28));
    register x29 (.d_input(data_in),     .we(we && (Rd == 5'b11101)), .clk(clk), .rst(rst), .out(reg_out29));
    register x30 (.d_input(data_in),     .we(we && (Rd == 5'b11110)), .clk(clk), .rst(rst), .out(reg_out30));
    register x31 (.d_input(data_in),     .we(we && (Rd == 5'b11111)), .clk(clk), .rst(rst), .out(reg_out31));

    // Instantiate 32:1 mux for read_data1 (using Rs1 to select)
    mux32_to_1 mux1 (
        .sel(Rs1),        // Select input Rs1
        .in0(reg_out0),   .in1(reg_out1),   .in2(reg_out2),   .in3(reg_out3),
        .in4(reg_out4),   .in5(reg_out5),   .in6(reg_out6),   .in7(reg_out7),
        .in8(reg_out8),   .in9(reg_out9),   .in10(reg_out10), .in11(reg_out11),
        .in12(reg_out12), .in13(reg_out13), .in14(reg_out14), .in15(reg_out15),
        .in16(reg_out16), .in17(reg_out17), .in18(reg_out18), .in19(reg_out19),
        .in20(reg_out20), .in21(reg_out21), .in22(reg_out22), .in23(reg_out23),
        .in24(reg_out24), .in25(reg_out25), .in26(reg_out26), .in27(reg_out27),
        .in28(reg_out28), .in29(reg_out29), .in30(reg_out30), .in31(reg_out31),
        .Y(read_data_out_1)   // Output is connected to read_data1
    );

    // Instantiate 32:1 mux for read_data2 (using Rs2 to select)
    mux32_to_1 mux2 (
        .sel(Rs2),        // Select input Rs2
        .in0(reg_out0),   .in1(reg_out1),   .in2(reg_out2),   .in3(reg_out3),
        .in4(reg_out4),   .in5(reg_out5),   .in6(reg_out6),   .in7(reg_out7),
        .in8(reg_out8),   .in9(reg_out9),   .in10(reg_out10), .in11(reg_out11),
        .in12(reg_out12), .in13(reg_out13), .in14(reg_out14), .in15(reg_out15),
        .in16(reg_out16), .in17(reg_out17), .in18(reg_out18), .in19(reg_out19),
        .in20(reg_out20), .in21(reg_out21), .in22(reg_out22), .in23(reg_out23),
        .in24(reg_out24), .in25(reg_out25), .in26(reg_out26), .in27(reg_out27),
        .in28(reg_out28), .in29(reg_out29), .in30(reg_out30), .in31(reg_out31),
        .Y(read_data_out_2)   // Output is connected to read_data2
    );

assign read_data1 = read_data_out_1;
assign read_data2 = read_data_out_2;

endmodule
