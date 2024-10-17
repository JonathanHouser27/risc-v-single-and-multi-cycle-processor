`define INST_ENCODING_JAL 32'bxxxxxxxxxxxxxxxxxxxxxxxxx1101111 // JAL
`define INST_ENCODING_RTYPE 32'bxxxxxxxxxxxxxxxxxxxxxxxxx0110011 // R-type
`define INST_ENCODING_ITYPE 32'bxxxxxxxxxxxxxxxxxxxxxxxxx0000011 // I-type

`define NEXT_PC_FROM_JAL_IMM 1'b1
`define NEXT_PC_PLUS_4 1'b0

module decode(
    input wire [31:0] inst_encoding,
    output reg next_pc_sel,
    output reg reg_write,
    output reg [1:0] alu_src,
    output reg [3:0] alu_op
);

    always @(*) begin
        casex(inst_encoding)
            `INST_ENCODING_JAL: begin
                next_pc_sel = `NEXT_PC_FROM_JAL_IMM;
                reg_write = 1'b1; // JAL writes to the register
                alu_src = 2'b00;   // No immediate for JAL
                alu_op = 4'bxxxx;  // Not used in JAL
            end
            `INST_ENCODING_RTYPE: begin
                next_pc_sel = `NEXT_PC_PLUS_4;
                reg_write = 1'b1; // R-type writes to the register
                alu_src = 2'b00;   // Both operands from registers
                alu_op = 4'b0010;  // Example ALU operation 
            end
            `INST_ENCODING_ITYPE: begin
                next_pc_sel = `NEXT_PC_PLUS_4;
                reg_write = 1'b1; // I-type writes to the register
                alu_src = 2'b01;   // Second operand is an immediate
                alu_op = 4'b0010;  // Example ALU operation 
            end
            default: begin
                next_pc_sel = `NEXT_PC_PLUS_4;
                reg_write = 1'b0; // Default: no register write
                alu_src = 2'b00;   // Default: no immediate
                alu_op = 4'b0000;  // Default ALU operation
            end
        endcase
    end

endmodule
