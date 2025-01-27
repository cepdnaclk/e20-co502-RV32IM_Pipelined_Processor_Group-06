module MEM_WB (
    input wire CLK,
    input wire RST,
    input wire [31:0] MEM_JAL_SELECTED,
    input wire [31:0] MEM_DATA_OUT,
    input wire [4:0] MEM_RD,
    input wire MEM_WRITE_ENABLE,
    input wire MEM_DATA_MEM_SELECT,
    input wire [2:0] MEM_FUNC3,
    output reg [31:0] WB_JAL_SELECTED,
    output reg [31:0] WB_DATA_OUT,
    output reg [4:0] WB_RD,
    output reg WB_WRITE_ENABLE,
    output reg WB_DATA_MEM_SELECT,
    output reg [2:0] WB_FUNC3
);

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            WB_JAL_SELECTED <= 32'b0;
            WB_DATA_OUT <= 32'b0;
            WB_RD <= 5'b0;
            WB_WRITE_ENABLE <= 1'b0;
            WB_DATA_MEM_SELECT <= 1'b0;
            WB_FUNC3 <= 3'b0;
        end else begin
            WB_JAL_SELECTED <= MEM_JAL_SELECTED;
            WB_DATA_OUT <= MEM_DATA_OUT;
            WB_RD <= MEM_RD;
            WB_WRITE_ENABLE <= MEM_WRITE_ENABLE;
            WB_DATA_MEM_SELECT <= MEM_DATA_MEM_SELECT;
            WB_FUNC3 <= MEM_FUNC3;
        end
    end

endmodule
