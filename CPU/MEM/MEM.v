module MEM (
    input wire CLK,
    input wire RST,
    input wire [2:0] EX_FUNC3,
    input wire EX_WRITE_ENABLE,
    input wire EX_DATA_MEM_SELECT,
    input wire EX_MEM_WRITE,
    input wire EX_MEM_READ,
    input wire [31:0] EX_JAL_SELECTED,
    input wire [31:0] EX_READ_DATA2,
    input wire [4:0] EX_RD,

    output wire [2:0] MEM_FUNC3,
    output wire MEM_WRITE_ENABLE,
    output wire MEM_DATA_MEM_SELECT,
    output wire [31:0] MEM_JAL_SELECTED,
    output wire [31:0] MEM_DATA_OUT,
    output wire [4:0] MEM_RD
);

    // Data Memory
    DATA_MEMORY data_memory (
        .CLK(CLK),
        .ADDRESS(EX_JAL_SELECTED),
        .WRITE_DATA(EX_READ_DATA2),
        .MEM_WRITE(EX_MEM_WRITE),
        .MEM_READ(EX_MEM_READ),
        .FUNC3(EX_FUNC3),
        .READ_DATA(MEM_DATA_OUT)
    );

    // Direct connections
    assign MEM_FUNC3 = EX_FUNC3;
    assign MEM_WRITE_ENABLE = EX_WRITE_ENABLE;
    assign MEM_DATA_MEM_SELECT = EX_DATA_MEM_SELECT;
    assign MEM_JAL_SELECTED = EX_JAL_SELECTED;
    assign MEM_RD = EX_RD;
endmodule
