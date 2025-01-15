module IF (
    input wire CLK,
    input wire RST,
    input wire [31:0] NEXT_PC,
    output wire [31:0] IF_PC,
    output wire [31:0] IF_PC_PLUS4,
    output wire [31:0] IF_INSTRUCTION
);
    wire [31:0] PC;
    wire [31:0] PC_PLUS4;

    PROGRAM_COUNTER PC_INST (
        .CLK(CLK),
        .RST(RST),
        .NEXT_PC(NEXT_PC),
        .PC(PC),
        .PC_PLUS4(PC_PLUS4)
    );

    assign IF_PC = PC;
    assign IF_PC_PLUS4 = PC_PLUS4;

    // Instruction Memory
    INSTRUCTION_MEMORY instruction_memory (
        .ADDRESS(PC),
        .INSTRUCTION(IF_INSTRUCTION)
    );

endmodule
