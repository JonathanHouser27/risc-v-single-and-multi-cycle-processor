module reg_file(
    input [31:0] data_in,       // Data input for registers
    input [4:0] Rs1,            // Read register 1 address
    input [4:0] Rs2,            // Read register 2 address
    input [4:0] Rd,             // Write register address
    input we,                   // Write enable
    input clk,                  // Clock signal
    input rst,                  // Reset signal
    input sign_extend,          // Sign extension control
    input zero_extend,          // Zero extension control
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

    
    // Instantiate each register explicitly
	register reg0 (.in(32'b0), .we(1'b0), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out0));
	register reg1 (.in(data_in), .we(we && (Rd == 5'b00001)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out1));
	register reg2 (.in(data_in), .we(we && (Rd == 5'b00010)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out2));
	register reg3 (.in(data_in), .we(we && (Rd == 5'b00011)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out3));
	register reg4 (.in(data_in), .we(we && (Rd == 5'b00100)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out4));
	register reg5 (.in(data_in), .we(we && (Rd == 5'b00101)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out5));
	register reg6 (.in(data_in), .we(we && (Rd == 5'b00110)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out6));
	register reg7 (.in(data_in), .we(we && (Rd == 5'b00111)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out7));
	register reg8 (.in(data_in), .we(we && (Rd == 5'b01000)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out8));
	register reg9 (.in(data_in), .we(we && (Rd == 5'b01001)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out9));
	register reg10(.in(data_in), .we(we && (Rd == 5'b01010)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out10));
	register reg11(.in(data_in), .we(we && (Rd == 5'b01011)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out11));
	register reg12(.in(data_in), .we(we && (Rd == 5'b01100)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out12));
	register reg13(.in(data_in), .we(we && (Rd == 5'b01101)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out13));
	register reg14(.in(data_in), .we(we && (Rd == 5'b01110)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out14));
	register reg15(.in(data_in), .we(we && (Rd == 5'b01111)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out15));
	register reg16(.in(data_in), .we(we && (Rd == 5'b10000)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out16));
	register reg17(.in(data_in), .we(we && (Rd == 5'b10001)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out17));
	register reg18(.in(data_in), .we(we && (Rd == 5'b10010)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out18));
	register reg19(.in(data_in), .we(we && (Rd == 5'b10011)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out19));
	register reg20(.in(data_in), .we(we && (Rd == 5'b10100)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out20));
	register reg21(.in(data_in), .we(we && (Rd == 5'b10101)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out21));
	register reg22(.in(data_in), .we(we && (Rd == 5'b10110)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out22));
	register reg23(.in(data_in), .we(we && (Rd == 5'b10111)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out23));
	register reg24(.in(data_in), .we(we && (Rd == 5'b11000)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out24));
	register reg25(.in(data_in), .we(we && (Rd == 5'b11001)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out25));
	register reg26(.in(data_in), .we(we && (Rd == 5'b11010)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out26));
	register reg27(.in(data_in), .we(we && (Rd == 5'b11011)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out27));
	register reg28(.in(data_in), .we(we && (Rd == 5'b11100)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out28));
	register reg29(.in(data_in), .we(we && (Rd == 5'b11101)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out29));
	register reg30(.in(data_in), .we(we && (Rd == 5'b11110)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out30));
	register reg31(.in(data_in), .we(we && (Rd == 5'b11111)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out31));

    // Instantiate 32:1 mux for read_data1 (using Rs1 to select)
    mux32_to_1 mux1 (
        .sel(Rs1),        // Select input Rs1
        .in0(reg_out0),  .in1(reg_out1),  .in2(reg_out2),  .in3(reg_out3),
        .in4(reg_out4),  .in5(reg_out5),  .in6(reg_out6),  .in7(reg_out7),
        .in8(reg_out8),  .in9(reg_out9),  .in10(reg_out10), .in11(reg_out11),
        .in12(reg_out12), .in13(reg_out13), .in14(reg_out14), .in15(reg_out15),
        .in16(reg_out16), .in17(reg_out17), .in18(reg_out18), .in19(reg_out19),
        .in20(reg_out20), .in21(reg_out21), .in22(reg_out22), .in23(reg_out23),
        .in24(reg_out24), .in25(reg_out25), .in26(reg_out26), .in27(reg_out27),
        .in28(reg_out28), .in29(reg_out29), .in30(reg_out30), .in31(reg_out31),
        .out(read_data1)   // Output is connected to read_data1
    );

    // Instantiate 32:1 mux for read_data2 (using Rs2 to select)
    mux32_to_1 mux2 (
        .sel(Rs2),        // Select input Rs2
        .in0(reg_out0),  .in1(reg_out1),  .in2(reg_out2),  .in3(reg_out3),
        .in4(reg_out4),  .in5(reg_out5),  .in6(reg_out6),  .in7(reg_out7),
        .in8(reg_out8),  .in9(reg_out9),  .in10(reg_out10), .in11(reg_out11),
        .in12(reg_out12), .in13(reg_out13), .in14(reg_out14), .in15(reg_out15),
        .in16(reg_out16), .in17(reg_out17), .in18(reg_out18), .in19(reg_out19),
        .in20(reg_out20), .in21(reg_out21), .in22(reg_out22), .in23(reg_out23),
        .in24(reg_out24), .in25(reg_out25), .in26(reg_out26), .in27(reg_out27),
        .in28(reg_out28), .in29(reg_out29), .in30(reg_out30), .in31(reg_out31),
        .out(read_data2)   // Output is connected to read_data2
    );

endmodule
