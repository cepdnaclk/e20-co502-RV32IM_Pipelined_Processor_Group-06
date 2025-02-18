module ID_EX (
    input wire CLK,
    input wire RST,
    input wire [1:0] ID_MEM_FORWARD_EN,
    input wire [1:0] ID_WB_FORWARD_EN,
    input wire [31:0] ID_PC,
    input wire [31:0] ID_READ_DATA1,
    input wire [31:0] ID_READ_DATA2,
    input wire [31:0] ID_IMMEDIATE,
    input wire [4:0] ID_RD,
    input wire [2:0] ID_FUNC3,
    input wire [31:0] ID_PC_PLUS4,
    input wire [4:0] ID_ALU_CONTROL,
    input wire ID_WRITE_ENABLE,
    input wire ID_DATA_MEM_SELECT,
    input wire ID_MEM_WRITE,
    input wire ID_MEM_READ,
    input wire ID_JAL_SELECT,
    input wire ID_IMM_SELECT,
    input wire ID_PC_SELECT,
    input wire ID_BRANCH,
    input wire ID_JUMP,
    output reg [1:0] EX_MEM_FORWARD_EN,
    output reg [1:0] EX_WB_FORWARD_EN,
    output reg [31:0] EX_PC,
    output reg [31:0] EX_READ_DATA1,
    output reg [31:0] EX_READ_DATA2,
    output reg [31:0] EX_IMMEDIATE,
    output reg [4:0] EX_RD,
    output reg [2:0] EX_FUNC3,
    output reg [31:0] EX_PC_PLUS4,
    output reg [4:0] EX_ALU_CONTROL,
    output reg EX_WRITE_ENABLE,
    output reg EX_DATA_MEM_SELECT,
    output reg EX_MEM_WRITE,
    output reg EX_MEM_READ,
    output reg EX_JAL_SELECT,
    output reg EX_IMM_SELECT,
    output reg EX_PC_SELECT,
    output reg EX_BRANCH,
    output reg EX_JUMP
);

    always @(posedge CLK) begin
        if (RST) begin
            EX_MEM_FORWARD_EN <= 2'b0;
            EX_WB_FORWARD_EN <= 2'b0;
            EX_PC <= 32'b0;
            EX_READ_DATA1 <= 32'b0;
            EX_READ_DATA2 <= 32'b0;
            EX_IMMEDIATE <= 32'b0;
            EX_RD <= 5'b0;
            EX_FUNC3 <= 3'b0;
            EX_PC_PLUS4 <= 32'b0;
            EX_ALU_CONTROL <= 5'b0;
            EX_WRITE_ENABLE <= 1'b0;
            EX_DATA_MEM_SELECT <= 1'b0;
            EX_MEM_WRITE <= 1'b0;
            EX_MEM_READ <= 1'b0;
            EX_JAL_SELECT <= 1'b0;
            EX_IMM_SELECT <= 1'b0;
            EX_PC_SELECT <= 1'b0;
            EX_BRANCH <= 1'b0;
            EX_JUMP <= 1'b0;
        end else begin
            EX_MEM_FORWARD_EN <= ID_MEM_FORWARD_EN;
            EX_WB_FORWARD_EN <= ID_WB_FORWARD_EN;
            EX_PC <= ID_PC;
            EX_READ_DATA1 <= ID_READ_DATA1;
            EX_READ_DATA2 <= ID_READ_DATA2;
            EX_IMMEDIATE <= ID_IMMEDIATE;
            EX_RD <= ID_RD;
            EX_FUNC3 <= ID_FUNC3;
            EX_PC_PLUS4 <= ID_PC_PLUS4;
            EX_ALU_CONTROL <= ID_ALU_CONTROL;
            EX_WRITE_ENABLE <= ID_WRITE_ENABLE;
            EX_DATA_MEM_SELECT <= ID_DATA_MEM_SELECT;
            EX_MEM_WRITE <= ID_MEM_WRITE;
            EX_MEM_READ <= ID_MEM_READ;
            EX_JAL_SELECT <= ID_JAL_SELECT;
            EX_IMM_SELECT <= ID_IMM_SELECT;
            EX_PC_SELECT <= ID_PC_SELECT;
            EX_BRANCH <= ID_BRANCH;
            EX_JUMP <= ID_JUMP;
        end
    end

endmodule
