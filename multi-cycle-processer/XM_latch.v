`timescale 1us/100ns

module latch(
    input [31:0] d_input1,   // ALU_output 0-31	
    input [31:0] d_input2,   // immediate value 32-63
    input [1:0] d_input3,    // rf_input mux select 64-65
    input we,                // Write enable
    input clk,               // Clock signal
    input rst,               // Reset signal
    output [65:0] out        // Output data
);

    wire [65:0] dff;         // D-flip flop outputs

    // D-flip flops instantiation with write enable accounted for
    dflop flop0 (.q(dff[0]), .d(we ? d_input1[0] : dff[0]), .clk(clk), .rst(rst));
    dflop flop1 (.q(dff[1]), .d(we ? d_input1[1] : dff[1]), .clk(clk), .rst(rst));
    dflop flop2 (.q(dff[2]), .d(we ? d_input1[2] : dff[2]), .clk(clk), .rst(rst));
    dflop flop3 (.q(dff[3]), .d(we ? d_input1[3] : dff[3]), .clk(clk), .rst(rst));
    dflop flop4 (.q(dff[4]), .d(we ? d_input1[4] : dff[4]), .clk(clk), .rst(rst));
    dflop flop5 (.q(dff[5]), .d(we ? d_input1[5] : dff[5]), .clk(clk), .rst(rst));
    dflop flop6 (.q(dff[6]), .d(we ? d_input1[6] : dff[6]), .clk(clk), .rst(rst));
    dflop flop7 (.q(dff[7]), .d(we ? d_input1[7] : dff[7]), .clk(clk), .rst(rst));
    dflop flop8 (.q(dff[8]), .d(we ? d_input1[8] : dff[8]), .clk(clk), .rst(rst));
    dflop flop9 (.q(dff[9]), .d(we ? d_input1[9] : dff[9]), .clk(clk), .rst(rst));
    dflop flop10(.q(dff[10]), .d(we ? d_input1[10] : dff[10]), .clk(clk), .rst(rst));
    dflop flop11(.q(dff[11]), .d(we ? d_input1[11] : dff[11]), .clk(clk), .rst(rst));
    dflop flop12(.q(dff[12]), .d(we ? d_input1[12] : dff[12]), .clk(clk), .rst(rst));
    dflop flop13(.q(dff[13]), .d(we ? d_input1[13] : dff[13]), .clk(clk), .rst(rst));
    dflop flop14(.q(dff[14]), .d(we ? d_input1[14] : dff[14]), .clk(clk), .rst(rst));
    dflop flop15(.q(dff[15]), .d(we ? d_input1[15] : dff[15]), .clk(clk), .rst(rst));
    dflop flop16(.q(dff[16]), .d(we ? d_input1[16] : dff[16]), .clk(clk), .rst(rst));
    dflop flop17(.q(dff[17]), .d(we ? d_input1[17] : dff[17]), .clk(clk), .rst(rst));
    dflop flop18(.q(dff[18]), .d(we ? d_input1[18] : dff[18]), .clk(clk), .rst(rst));
    dflop flop19(.q(dff[19]), .d(we ? d_input1[19] : dff[19]), .clk(clk), .rst(rst));
    dflop flop20(.q(dff[20]), .d(we ? d_input1[20] : dff[20]), .clk(clk), .rst(rst));
    dflop flop21(.q(dff[21]), .d(we ? d_input1[21] : dff[21]), .clk(clk), .rst(rst));
    dflop flop22(.q(dff[22]), .d(we ? d_input1[22] : dff[22]), .clk(clk), .rst(rst));
    dflop flop23(.q(dff[23]), .d(we ? d_input1[23] : dff[23]), .clk(clk), .rst(rst));
    dflop flop24(.q(dff[24]), .d(we ? d_input1[24] : dff[24]), .clk(clk), .rst(rst));
    dflop flop25(.q(dff[25]), .d(we ? d_input1[25] : dff[25]), .clk(clk), .rst(rst));
    dflop flop26(.q(dff[26]), .d(we ? d_input1[26] : dff[26]), .clk(clk), .rst(rst));
    dflop flop27(.q(dff[27]), .d(we ? d_input1[27] : dff[27]), .clk(clk), .rst(rst));
    dflop flop28(.q(dff[28]), .d(we ? d_input1[28] : dff[28]), .clk(clk), .rst(rst));
    dflop flop29(.q(dff[29]), .d(we ? d_input1[29] : dff[29]), .clk(clk), .rst(rst));
    dflop flop30(.q(dff[30]), .d(we ? d_input1[30] : dff[30]), .clk(clk), .rst(rst));
    dflop flop31(.q(dff[31]), .d(we ? d_input1[31] : dff[31]), .clk(clk), .rst(rst));
    dflop flop32(.q(dff[32]), .d(we ? d_input2[0] : dff[32]), .clk(clk), .rst(rst));
    dflop flop33(.q(dff[33]), .d(we ? d_input2[1] : dff[33]), .clk(clk), .rst(rst));
    dflop flop34(.q(dff[34]), .d(we ? d_input2[2] : dff[34]), .clk(clk), .rst(rst));
    dflop flop35(.q(dff[35]), .d(we ? d_input2[3] : dff[35]), .clk(clk), .rst(rst));
    dflop flop36(.q(dff[36]), .d(we ? d_input2[4] : dff[36]), .clk(clk), .rst(rst));
    dflop flop37(.q(dff[37]), .d(we ? d_input2[5] : dff[37]), .clk(clk), .rst(rst));
    dflop flop38(.q(dff[38]), .d(we ? d_input2[6] : dff[38]), .clk(clk), .rst(rst));
    dflop flop39(.q(dff[39]), .d(we ? d_input2[7] : dff[39]), .clk(clk), .rst(rst));
    dflop flop40(.q(dff[40]), .d(we ? d_input2[8] : dff[40]), .clk(clk), .rst(rst));
    dflop flop41(.q(dff[41]), .d(we ? d_input2[9] : dff[41]), .clk(clk), .rst(rst));
    dflop flop42(.q(dff[42]), .d(we ? d_input2[10] : dff[42]), .clk(clk), .rst(rst));
    dflop flop43(.q(dff[43]), .d(we ? d_input2[11] : dff[43]), .clk(clk), .rst(rst));
    dflop flop44(.q(dff[44]), .d(we ? d_input2[12] : dff[44]), .clk(clk), .rst(rst));
    dflop flop45(.q(dff[45]), .d(we ? d_input2[13] : dff[45]), .clk(clk), .rst(rst));
    dflop flop46(.q(dff[46]), .d(we ? d_input2[14] : dff[46]), .clk(clk), .rst(rst));
    dflop flop47(.q(dff[47]), .d(we ? d_input2[15] : dff[47]), .clk(clk), .rst(rst));
    dflop flop48(.q(dff[48]), .d(we ? d_input2[16] : dff[48]), .clk(clk), .rst(rst));
    dflop flop49(.q(dff[49]), .d(we ? d_input2[17] : dff[49]), .clk(clk), .rst(rst));
    dflop flop50(.q(dff[50]), .d(we ? d_input2[18] : dff[50]), .clk(clk), .rst(rst));
    dflop flop51(.q(dff[51]), .d(we ? d_input2[19] : dff[51]), .clk(clk), .rst(rst));
    dflop flop52(.q(dff[52]), .d(we ? d_input2[20] : dff[52]), .clk(clk), .rst(rst));
    dflop flop53(.q(dff[53]), .d(we ? d_input2[21] : dff[53]), .clk(clk), .rst(rst));
    dflop flop54(.q(dff[54]), .d(we ? d_input2[22] : dff[54]), .clk(clk), .rst(rst));
    dflop flop55(.q(dff[55]), .d(we ? d_input2[23] : dff[55]), .clk(clk), .rst(rst));
    dflop flop56(.q(dff[56]), .d(we ? d_input2[24] : dff[56]), .clk(clk), .rst(rst));
    dflop flop57(.q(dff[57]), .d(we ? d_input2[25] : dff[57]), .clk(clk), .rst(rst));
    dflop flop58(.q(dff[58]), .d(we ? d_input2[26] : dff[58]), .clk(clk), .rst(rst));
    dflop flop59(.q(dff[59]), .d(we ? d_input2[27] : dff[59]), .clk(clk), .rst(rst));
    dflop flop60(.q(dff[60]), .d(we ? d_input2[28] : dff[60]), .clk(clk), .rst(rst));
    dflop flop61(.q(dff[61]), .d(we ? d_input2[29] : dff[61]), .clk(clk), .rst(rst));
    dflop flop62(.q(dff[62]), .d(we ? d_input2[30] : dff[62]), .clk(clk), .rst(rst));
    dflop flop63(.q(dff[63]), .d(we ? d_input2[31] : dff[63]), .clk(clk), .rst(rst));
    dflop flop64(.q(dff[64]), .d(we ? d_input3[0] : dff[64]), .clk(clk), .rst(rst));
    dflop flop65(.q(dff[65]), .d(we ? d_input3[1] : dff[65]), .clk(clk), .rst(rst));

    // Output assignment
    assign out = dff;


endmodule
