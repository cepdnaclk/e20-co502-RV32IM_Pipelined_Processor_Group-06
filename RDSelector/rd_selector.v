module RD_SELECTOR (
    input [4:0] WRITE_REGISTER,
    input [6:0] OPCODE,
    output reg [4:0] RD
);

always @(*) begin
    case (OPCODE)
        7'b0100011, // S-type
        7'b1100011: // B-type
            RD = 5'b00000;
        default:
            RD = WRITE_REGISTER;
    endcase
end

endmodule