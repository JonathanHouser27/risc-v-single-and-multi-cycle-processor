`timescale 1us/100ns

module register(
    input [31:0] d_input,    // Input data	
    input we,                // Write enable
    input clk,               // Clock signal
    input rst,               // Reset signal
    output [31:0] out        // Output data
);

    wire [31:0] dff;         // D-flip flop outputs

    // D-flip flops instantiation with write enable accounted for
    dflop flop0 (.q(dff[0]), .d(we ? d_input[0] : dff[0]), .clk(clk), .rst(rst));
    dflop flop1 (.q(dff[1]), .d(we ? d_input[1] : dff[1]), .clk(clk), .rst(rst));
    dflop flop2 (.q(dff[2]), .d(we ? d_input[2] : dff[2]), .clk(clk), .rst(rst));
    dflop flop3 (.q(dff[3]), .d(we ? d_input[3] : dff[3]), .clk(clk), .rst(rst));
    dflop flop4 (.q(dff[4]), .d(we ? d_input[4] : dff[4]), .clk(clk), .rst(rst));
    dflop flop5 (.q(dff[5]), .d(we ? d_input[5] : dff[5]), .clk(clk), .rst(rst));
    dflop flop6 (.q(dff[6]), .d(we ? d_input[6] : dff[6]), .clk(clk), .rst(rst));
    dflop flop7 (.q(dff[7]), .d(we ? d_input[7] : dff[7]), .clk(clk), .rst(rst));
    dflop flop8 (.q(dff[8]), .d(we ? d_input[8] : dff[8]), .clk(clk), .rst(rst));
    dflop flop9 (.q(dff[9]), .d(we ? d_input[9] : dff[9]), .clk(clk), .rst(rst));
    dflop flop10(.q(dff[10]), .d(we ? d_input[10] : dff[10]), .clk(clk), .rst(rst));
    dflop flop11(.q(dff[11]), .d(we ? d_input[11] : dff[11]), .clk(clk), .rst(rst));
    dflop flop12(.q(dff[12]), .d(we ? d_input[12] : dff[12]), .clk(clk), .rst(rst));
    dflop flop13(.q(dff[13]), .d(we ? d_input[13] : dff[13]), .clk(clk), .rst(rst));
    dflop flop14(.q(dff[14]), .d(we ? d_input[14] : dff[14]), .clk(clk), .rst(rst));
    dflop flop15(.q(dff[15]), .d(we ? d_input[15] : dff[15]), .clk(clk), .rst(rst));
    dflop flop16(.q(dff[16]), .d(we ? d_input[16] : dff[16]), .clk(clk), .rst(rst));
    dflop flop17(.q(dff[17]), .d(we ? d_input[17] : dff[17]), .clk(clk), .rst(rst));
    dflop flop18(.q(dff[18]), .d(we ? d_input[18] : dff[18]), .clk(clk), .rst(rst));
    dflop flop19(.q(dff[19]), .d(we ? d_input[19] : dff[19]), .clk(clk), .rst(rst));
    dflop flop20(.q(dff[20]), .d(we ? d_input[20] : dff[20]), .clk(clk), .rst(rst));
    dflop flop21(.q(dff[21]), .d(we ? d_input[21] : dff[21]), .clk(clk), .rst(rst));
    dflop flop22(.q(dff[22]), .d(we ? d_input[22] : dff[22]), .clk(clk), .rst(rst));
    dflop flop23(.q(dff[23]), .d(we ? d_input[23] : dff[23]), .clk(clk), .rst(rst));
    dflop flop24(.q(dff[24]), .d(we ? d_input[24] : dff[24]), .clk(clk), .rst(rst));
    dflop flop25(.q(dff[25]), .d(we ? d_input[25] : dff[25]), .clk(clk), .rst(rst));
    dflop flop26(.q(dff[26]), .d(we ? d_input[26] : dff[26]), .clk(clk), .rst(rst));
    dflop flop27(.q(dff[27]), .d(we ? d_input[27] : dff[27]), .clk(clk), .rst(rst));
    dflop flop28(.q(dff[28]), .d(we ? d_input[28] : dff[28]), .clk(clk), .rst(rst));
    dflop flop29(.q(dff[29]), .d(we ? d_input[29] : dff[29]), .clk(clk), .rst(rst));
    dflop flop30(.q(dff[30]), .d(we ? d_input[30] : dff[30]), .clk(clk), .rst(rst));
    dflop flop31(.q(dff[31]), .d(we ? d_input[31] : dff[31]), .clk(clk), .rst(rst));

    // Output assignment
    assign out = dff;


endmodule
