module WB (
    input wire CLK,
    input wire RST,
    input wire [2:0] MEM_FUNC3,
    input wire MEM_WRITE_ENABLE,
    input wire MEM_DATA_MEM_SELECT,
    input wire [31:0] MEM_JAL_SELECTED,
    input wire [31:0] MEM_DATA_OUT,
    input wire [4:0] MEM_RD,

    output wire WB_WRITE_ENABLE,
    output wire [31:0] WB_WRITE_DATA,
    output wire [4:0] WB_RD
);

    wire [31:0] PROCESSED_DATA_OUT;

    // Load Processing Unit
    LOAD_PROCESSING_UNIT load_processing_unit (
        .FUNC3(MEM_FUNC3),
        .DATA_OUT(MEM_DATA_OUT),
        .PROCESSED_DATA_OUT(PROCESSED_DATA_OUT)
    );

    // MUX
    MUX data_mem_select (
        .IN0(MEM_JAL_SELECTED),
        .IN1(PROCESSED_DATA_OUT),
        .SEL(MEM_DATA_MEM_SELECT),
        .OUT(WB_WRITE_DATA)
    );

    // Output assignments
    assign WB_WRITE_ENABLE = MEM_WRITE_ENABLE;
    assign WB_RD = MEM_RD;

endmodule
