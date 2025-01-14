module load_processing_unit(
    input wire [2:0] FUNC3,
    input wire [31:0] DATA_OUT,
    output reg [31:0] PROCESSED_DATA_OUT
);

    always @(*) begin
        case (FUNC3)
            3'b000: // LB (Load Byte)
                PROCESSED_DATA_OUT = {{24{DATA_OUT[7]}}, DATA_OUT[7:0]};
            3'b001: // LH (Load Halfword)
                PROCESSED_DATA_OUT = {{16{DATA_OUT[15]}}, DATA_OUT[15:0]};
            3'b010: // LW (Load Word)
                PROCESSED_DATA_OUT = DATA_OUT;
            3'b100: // LBU (Load Byte Unsigned)
                PROCESSED_DATA_OUT = {24'b0, DATA_OUT[7:0]};
            3'b101: // LHU (Load Halfword Unsigned)
                PROCESSED_DATA_OUT = {16'b0, DATA_OUT[15:0]};
            default: // Default case
                PROCESSED_DATA_OUT = 32'b0;
        endcase
    end

endmodule
