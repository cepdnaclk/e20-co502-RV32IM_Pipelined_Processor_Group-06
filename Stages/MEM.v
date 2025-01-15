module MEM (
    input wire CLK,
    input wire RST,
    input wire [2:0] EX_FUNC3,
    input wire EX_WRITE_ENABLE,
    input wire EX_DATA_MEM_SELECT,
    input wire EX_MEM_WRITE,
    input wire EX_MEM_READ,
    input wire EX_JAL_SELECTED,
    input wire [31:0] EX_READ_DATA2,
    input wire [4:0] EX_RD,

    output wire [2:0] MEM_FUNC3,
    output wire MEM_WRITE_ENABLE,
    output wire MEM_DATA_MEM_SELECT,
    output wire [3MEM_JAL_SELECTED1:0] ,
    output wire [31:0] MEM_DATA_OUT,
    output wire [4:0] MEM_RD
);

    // Data Memory
    DATA_MEMORY data_memory (
        .CLK(CLK),
        .ADDRESS(EX_JAL_SELECTED),
        .WRITE_DATA(MEM_READ_DATA2),
        .MEM_WRITE(MEM_MEM_WRITE),
        .MEM_READ(MEM_MEM_READ),
        .FUNC3(MEM_FUNC3),
        .READ_DATA(MEM_DATA_OUT)
    );

    // Direct connections
    assign MEM_FUNC3 = EX_FUNC3;
    assign EX_RD = MEM_RD;

endmodule
