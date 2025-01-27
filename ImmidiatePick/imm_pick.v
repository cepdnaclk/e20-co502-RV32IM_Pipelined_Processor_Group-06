module IMM_PICK(
    input [31:0] INSTRUCTION,
    input [2:0] IMM_PICK,
    output reg [31:0] IMMEDIATE
);

always @(*) begin
    case (IMM_PICK)
        3'b000: // I-type
            IMMEDIATE = {{20{INSTRUCTION[31]}}, INSTRUCTION[31:20]};
        3'b001: // S-type
            IMMEDIATE = {{20{INSTRUCTION[31]}}, INSTRUCTION[31:25], INSTRUCTION[11:7]};
        3'b010: // U-type
            IMMEDIATE = {INSTRUCTION[31:12], 12'b0};
        3'b011: // B-type
            IMMEDIATE = {{19{INSTRUCTION[31]}}, INSTRUCTION[31], INSTRUCTION[7], INSTRUCTION[30:25], INSTRUCTION[11:8], 1'b0};
        3'b100: // J-type
            IMMEDIATE = {{11{INSTRUCTION[31]}}, INSTRUCTION[31], INSTRUCTION[19:12], INSTRUCTION[20], INSTRUCTION[30:21], 1'b0};
        default:// Default case
            IMMEDIATE = 32'b0;
    endcase
end

endmodule