module MEM_WB (
    input wire CLK,
    input wire RST,
    input wire [31:0] MEM_ALU_RESULT,
    input wire [31:0] MEM_READ_DATA,
    input wire [4:0] MEM_WRITE_ADDR,
    input wire MEM_WRITE_ENABLE,
    input wire MEM_DATA_MEM_SELECT,
    input wire [2:0] MEM_FUNC3,
    output reg [31:0] WB_ALU_RESULT,
    output reg [31:0] WB_READ_DATA,
    output reg [4:0] WB_WRITE_ADDR,
    output reg WB_WRITE_ENABLE,
    output reg WB_DATA_MEM_SELECT,
    output reg [2:0] WB_FUNC3
);

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            WB_ALU_RESULT <= 32'b0;
            WB_READ_DATA <= 32'b0;
            WB_WRITE_ADDR <= 5'b0;
            WB_WRITE_ENABLE <= 1'b0;
            WB_DATA_MEM_SELECT <= 1'b0;
            WB_FUNC3 <= 3'b0;
        end else begin
            WB_ALU_RESULT <= MEM_ALU_RESULT;
            WB_READ_DATA <= MEM_READ_DATA;
            WB_WRITE_ADDR <= MEM_WRITE_ADDR;
            WB_WRITE_ENABLE <= MEM_WRITE_ENABLE;
            WB_DATA_MEM_SELECT <= MEM_DATA_MEM_SELECT;
            WB_FUNC3 <= MEM_FUNC3;
        end
    end

endmodule
