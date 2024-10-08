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

    wire [31:0] reg_out [31:0]; // Output wires for each register

    // Instantiate each register explicitly
    register reg0 (.in(data_in), .we(we && (Rd == 5'b00000)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(32'b0));
    register reg1 (.in(data_in), .we(we && (Rd == 5'b00001)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[1]));
    register reg2 (.in(data_in), .we(we && (Rd == 5'b00010)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[2]));
    register reg3 (.in(data_in), .we(we && (Rd == 5'b00011)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[3]));
    register reg4 (.in(data_in), .we(we && (Rd == 5'b00100)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[4]));
    register reg5 (.in(data_in), .we(we && (Rd == 5'b00101)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[5]));
    register reg6 (.in(data_in), .we(we && (Rd == 5'b00110)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[6]));
    register reg7 (.in(data_in), .we(we && (Rd == 5'b00111)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[7]));
    register reg8 (.in(data_in), .we(we && (Rd == 5'b01000)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[8]));
    register reg9 (.in(data_in), .we(we && (Rd == 5'b01001)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[9]));
    register reg10(.in(data_in), .we(we && (Rd == 5'b01010)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[10]));
    register reg11(.in(data_in), .we(we && (Rd == 5'b01011)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[11]));
    register reg12(.in(data_in), .we(we && (Rd == 5'b01100)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[12]));
    register reg13(.in(data_in), .we(we && (Rd == 5'b01101)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[13]));
    register reg14(.in(data_in), .we(we && (Rd == 5'b01110)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[14]));
    register reg15(.in(data_in), .we(we && (Rd == 5'b01111)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[15]));
    register reg16(.in(data_in), .we(we && (Rd == 5'b10000)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[16]));
    register reg17(.in(data_in), .we(we && (Rd == 5'b10001)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[17]));
    register reg18(.in(data_in), .we(we && (Rd == 5'b10010)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[18]));
    register reg19(.in(data_in), .we(we && (Rd == 5'b10011)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[19]));
    register reg20(.in(data_in), .we(we && (Rd == 5'b10100)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[20]));
    register reg21(.in(data_in), .we(we && (Rd == 5'b10101)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[21]));
    register reg22(.in(data_in), .we(we && (Rd == 5'b10110)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[22]));
    register reg23(.in(data_in), .we(we && (Rd == 5'b10111)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[23]));
    register reg24(.in(data_in), .we(we && (Rd == 5'b11000)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[24]));
    register reg25(.in(data_in), .we(we && (Rd == 5'b11001)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[25]));
    register reg26(.in(data_in), .we(we && (Rd == 5'b11010)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[26]));
    register reg27(.in(data_in), .we(we && (Rd == 5'b11011)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[27]));
    register reg28(.in(data_in), .we(we && (Rd == 5'b11100)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[28]));
    register reg29(.in(data_in), .we(we && (Rd == 5'b11101)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[29]));
    register reg30(.in(data_in), .we(we && (Rd == 5'b11110)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[30]));
    register reg31(.in(data_in), .we(we && (Rd == 5'b11111)), .clk(clk), .rst(rst), .sign_extend(sign_extend), .zero_extend(zero_extend), .out(reg_out[31]));

    // Instantiate 32:1 mux for read_data1 (using Rs1 to select)
    mux32_to_1 mux1 (
        .sel(Rs1),        // Select input Rs1
        .in0(reg_out[0]),  .in1(reg_out[1]),  .in2(reg_out[2]),  .in3(reg_out[3]),
        .in4(reg_out[4]),  .in5(reg_out[5]),  .in6(reg_out[6]),  .in7(reg_out[7]),
        .in8(reg_out[8]),  .in9(reg_out[9]),  .in10(reg_out[10]), .in11(reg_out[11]),
        .in12(reg_out[12]), .in13(reg_out[13]), .in14(reg_out[14]), .in15(reg_out[15]),
        .in16(reg_out[16]), .in17(reg_out[17]), .in18(reg_out[18]), .in19(reg_out[19]),
        .in20(reg_out[20]), .in21(reg_out[21]), .in22(reg_out[22]), .in23(reg_out[23]),
        .in24(reg_out[24]), .in25(reg_out[25]), .in26(reg_out[26]), .in27(reg_out[27]),
        .in28(reg_out[28]), .in29(reg_out[29]), .in30(reg_out[30]), .in31(reg_out[31]),
        .out(read_data1)   // Output is connected to read_data1
    );

    // Instantiate 32:1 mux for read_data2 (using Rs2 to select)
    mux32_to_1 mux2 (
        .sel(Rs2),        // Select input Rs2
        .in0(reg_out[0]),  .in1(reg_out[1]),  .in2(reg_out[2]),  .in3(reg_out[3]),
        .in4(reg_out[4]),  .in5(reg_out[5]),  .in6(reg_out[6]),  .in7(reg_out[7]),
        .in8(reg_out[8]),  .in9(reg_out[9]),  .in10(reg_out[10]), .in11(reg_out[11]),
        .in12(reg_out[12]), .in13(reg_out[13]), .in14(reg_out[14]), .in15(reg_out[15]),
        .in16(reg_out[16]), .in17(reg_out[17]), .in18(reg_out[18]), .in19(reg_out[19]),
        .in20(reg_out[20]), .in21(reg_out[21]), .in22(reg_out[22]), .in23(reg_out[23]),
        .in24(reg_out[24]), .in25(reg_out[25]), .in26(reg_out[26]), .in27(reg_out[27]),
        .in28(reg_out[28]), .in29(reg_out[29]), .in30(reg_out[30]), .in31(reg_out[31]),
        .out(read_data2)   // Output is connected to read_data2
    );

endmodule
