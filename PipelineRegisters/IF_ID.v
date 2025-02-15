module IF_ID (
    input wire CLK,
    input wire RST,
    input wire [31:0] IF_PC,
    input wire [31:0] IF_INSTRUCTION,
    input wire [31:0] IF_PC_PLUS4,
    output reg [31:0] ID_PC,
    output reg [31:0] ID_INSTRUCTION,
    output reg [31:0] ID_PC_PLUS4
);

    always @(posedge CLK) begin
        if (RST) begin
            ID_PC <= 32'b0;
            ID_INSTRUCTION <= 32'b0;
            ID_PC_PLUS4 <= 32'b0;
        end else begin
            ID_PC <= IF_PC;
            ID_INSTRUCTION <= IF_INSTRUCTION;
            ID_PC_PLUS4 <= IF_PC_PLUS4;
        end
    end

endmodule
