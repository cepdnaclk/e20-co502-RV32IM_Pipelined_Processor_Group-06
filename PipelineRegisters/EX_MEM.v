module EX_MEM (
    input wire CLK,
    input wire RST,
    input wire [31:0] EX_ALU_RESULT,
    input wire [31:0] EX_READ_DATA2,
    input wire [4:0] EX_WRITE_ADDR,
    input wire EX_MEM_WRITE,
    input wire EX_MEM_READ,
    input wire [2:0] EX_FUNC3,
    input wire EX_WRITE_ENABLE,
    input wire EX_DATA_MEM_SELECT,
    output reg [31:0] MEM_ALU_RESULT,
    output reg [31:0] MEM_READ_DATA2,
    output reg [4:0] MEM_WRITE_ADDR,
    output reg MEM_MEM_WRITE,
    output reg MEM_MEM_READ,
    output reg [2:0] MEM_FUNC3,
    output reg MEM_WRITE_ENABLE,
    output reg MEM_DATA_MEM_SELECT
);

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            MEM_ALU_RESULT <= 32'b0;
            MEM_READ_DATA2 <= 32'b0;
            MEM_WRITE_ADDR <= 5'b0;
            MEM_MEM_WRITE <= 1'b0;
            MEM_MEM_READ <= 1'b0;
            MEM_REG_WRITE <= 1'b0;
            MEM_MEM_TO_REG <= 1'b0;
            MEM_FUNC3 <= 3'b0;
            MEM_WRITE_ENABLE <= 1'b0;
            MEM_DATA_MEM_SELECT <= 1'b0;
        end else begin
            MEM_ALU_RESULT <= EX_ALU_RESULT;
            MEM_READ_DATA2 <= EX_READ_DATA2;
            MEM_WRITE_ADDR <= EX_WRITE_ADDR;
            MEM_MEM_WRITE <= EX_MEM_WRITE;
            MEM_MEM_READ <= EX_MEM_READ;
            MEM_REG_WRITE <= EX_REG_WRITE;
            MEM_MEM_TO_REG <= EX_MEM_TO_REG;
            MEM_FUNC3 <= EX_FUNC3;
            MEM_WRITE_ENABLE <= EX_WRITE_ENABLE;
            MEM_DATA_MEM_SELECT <= EX_DATA_MEM_SELECT;
        end
    end

endmodule
