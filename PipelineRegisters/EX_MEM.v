module EX_MEM (
    input wire CLK,
    input wire RST,
    input wire [31:0] EX_JAL_SELECTED,
    input wire [31:0] EX_READ_DATA2,
    input wire [4:0] EX_RD,
    input wire EX_MEM_WRITE,
    input wire EX_MEM_READ,
    input wire [2:0] EX_FUNC3,
    input wire EX_WRITE_ENABLE,
    input wire EX_DATA_MEM_SELECT,
    output reg [31:0] MEM_JAL_SELECTED,
    output reg [31:0] MEM_READ_DATA2,
    output reg [4:0] MEM_RD,
    output reg MEM_MEM_WRITE,
    output reg MEM_MEM_READ,
    output reg [2:0] MEM_FUNC3,
    output reg MEM_WRITE_ENABLE,
    output reg MEM_DATA_MEM_SELECT
);

    always @(posedge CLK) begin
        if (RST) begin
            MEM_JAL_SELECTED <= 32'b0;
            MEM_READ_DATA2 <= 32'b0;
            MEM_RD <= 5'b0;
            MEM_MEM_WRITE <= 1'b0;
            MEM_MEM_READ <= 1'b0;
            MEM_FUNC3 <= 3'b0;
            MEM_WRITE_ENABLE <= 1'b0;
            MEM_DATA_MEM_SELECT <= 1'b0;
        end else begin
            MEM_JAL_SELECTED <= EX_JAL_SELECTED;
            MEM_READ_DATA2 <= EX_READ_DATA2;
            MEM_RD <= EX_RD;
            MEM_MEM_WRITE <= EX_MEM_WRITE;
            MEM_MEM_READ <= EX_MEM_READ;
            MEM_FUNC3 <= EX_FUNC3;
            MEM_WRITE_ENABLE <= EX_WRITE_ENABLE;
            MEM_DATA_MEM_SELECT <= EX_DATA_MEM_SELECT;
        end
    end

endmodule
