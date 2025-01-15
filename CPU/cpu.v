module CPU (
    input wire CLK,
    input wire RST
);
    // IF stage
    wire [31:0] IF_PC, IF_INSTRUCTION, IF_PC_PLUS4;
    wire [31:0] ID_PC, ID_INSTRUCTION, ID_PC_PLUS4;

    // ID stage
    wire [31:0] ID_READ_DATA1, ID_READ_DATA2, ID_IMMEDIATE;
    wire [4:0] ID_RD;
    wire [2:0] ID_FUNC3;
    wire [6:0] ID_FUNC7;
    wire [2:0] ID_ALU_CONTROL;
    wire ID_WRITE_ENABLE, ID_DATA_MEM_SELECT, ID_MEM_WRITE, ID_MEM_READ, ID_JAL_SELECT, ID_IMM_SELECT, ID_PC_SELECT, ID_BRANCH, ID_JUMP;

    // EX stage
    wire [31:0] EX_PC, EX_READ_DATA1, EX_READ_DATA2, EX_IMMEDIATE, EX_PC_PLUS4;
    wire [4:0] EX_RD;
    wire [2:0] EX_FUNC3;
    wire [2:0] EX_ALU_CONTROL;
    wire EX_WRITE_ENABLE, EX_DATA_MEM_SELECT, EX_MEM_WRITE, EX_MEM_READ, EX_JAL_SELECT, EX_IMM_SELECT, EX_PC_SELECT, EX_BRANCH, EX_JUMP;
    wire [31:0] EX_ALU_RESULT;

    // MEM stage
    wire [31:0] MEM_ALU_RESULT, MEM_READ_DATA2;
    wire [4:0] MEM_RD;
    wire MEM_MEM_WRITE, MEM_MEM_READ, MEM_WRITE_ENABLE, MEM_DATA_MEM_SELECT;
    wire [2:0] MEM_FUNC3;

    // WB stage
    wire [31:0] WB_ALU_RESULT, WB_READ_DATA;
    wire [4:0] WB_RD;
    wire WB_WRITE_ENABLE, WB_DATA_MEM_SELECT;
    wire [2:0] WB_FUNC3;

    // Program Counter
    wire [31:0] NEXT_PC;
    wire [31:0] PC;
    wire [31:0] PC_PLUS4;

    PROGRAM_COUNTER PC_INST (
        .CLK(CLK),
        .RST(RST),
        .NEXT_PC(NEXT_PC),
        .PC(PC),
        .PC_PLUS4(PC_PLUS4)
    );

    // Instantiate pipeline registers
    IF_ID IF_ID (
        .CLK(CLK),
        .RST(RST),
        .IF_PC(IF_PC),
        .IF_INSTRUCTION(IF_INSTRUCTION),
        .IF_PC_PLUS4(IF_PC_PLUS4),
        .ID_PC(ID_PC),
        .ID_INSTRUCTION(ID_INSTRUCTION),
        .ID_PC_PLUS4(ID_PC_PLUS4)
    );

    ID_EX ID_EX (
        .CLK(CLK),
        .RST(RST),
        .ID_PC(ID_PC),
        .ID_READ_DATA1(ID_READ_DATA1),
        .ID_READ_DATA2(ID_READ_DATA2),
        .ID_IMMEDIATE(ID_IMMEDIATE),
        .ID_WRITE_ADDR(ID_RD),
        .ID_FUNC3(ID_FUNC3),
        .ID_PC_PLUS4(ID_PC_PLUS4),
        .ID_ALU_CONTROL(ID_ALU_CONTROL),
        .ID_WRITE_ENABLE(ID_WRITE_ENABLE),
        .ID_DATA_MEM_SELECT(ID_DATA_MEM_SELECT),
        .ID_MEM_WRITE(ID_MEM_WRITE),
        .ID_MEM_READ(ID_MEM_READ),
        .ID_JAL_SELECT(ID_JAL_SELECT),
        .ID_IMM_SELECT(ID_IMM_SELECT),
        .ID_PC_SELECT(ID_PC_SELECT),
        .ID_BRANCH(ID_BRANCH),
        .ID_JUMP(ID_JUMP),
        .EX_PC(EX_PC),
        .EX_READ_DATA1(EX_READ_DATA1),
        .EX_READ_DATA2(EX_READ_DATA2),
        .EX_IMMEDIATE(EX_IMMEDIATE),
        .EX_WRITE_ADDR(EX_RD),
        .EX_FUNC3(EX_FUNC3),
        .EX_PC_PLUS4(EX_PC_PLUS4),
        .EX_ALU_CONTROL(EX_ALU_CONTROL),
        .EX_WRITE_ENABLE(EX_WRITE_ENABLE),
        .EX_DATA_MEM_SELECT(EX_DATA_MEM_SELECT),
        .EX_MEM_WRITE(EX_MEM_WRITE),
        .EX_MEM_READ(EX_MEM_READ),
        .EX_JAL_SELECT(EX_JAL_SELECT),
        .EX_IMM_SELECT(EX_IMM_SELECT),
        .EX_PC_SELECT(EX_PC_SELECT),
        .EX_BRANCH(EX_BRANCH),
        .EX_JUMP(EX_JUMP)
    );

    EX_MEM EX_MEM (
        .CLK(CLK),
        .RST(RST),
        .EX_ALU_RESULT(EX_ALU_RESULT),
        .EX_READ_DATA2(EX_READ_DATA2),
        .EX_WRITE_ADDR(EX_RD),
        .EX_MEM_WRITE(EX_MEM_WRITE),
        .EX_MEM_READ(EX_MEM_READ),
        .EX_FUNC3(EX_FUNC3),
        .EX_WRITE_ENABLE(EX_WRITE_ENABLE),
        .EX_DATA_MEM_SELECT(EX_DATA_MEM_SELECT),
        .MEM_ALU_RESULT(MEM_ALU_RESULT),
        .MEM_READ_DATA2(MEM_READ_DATA2),
        .MEM_WRITE_ADDR(MEM_RD),
        .MEM_MEM_WRITE(MEM_MEM_WRITE),
        .MEM_MEM_READ(MEM_MEM_READ),
        .MEM_FUNC3(MEM_FUNC3),
        .MEM_WRITE_ENABLE(MEM_WRITE_ENABLE),
        .MEM_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT)
    );

    MEM_WB MEM_WB (
        .CLK(CLK),
        .RST(RST),
        .MEM_ALU_RESULT(MEM_ALU_RESULT),
        .MEM_READ_DATA(MEM_READ_DATA),
        .MEM_WRITE_ADDR(MEM_RD),
        .MEM_WRITE_ENABLE(MEM_WRITE_ENABLE),
        .MEM_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT),
        .MEM_FUNC3(MEM_FUNC3),
        .WB_ALU_RESULT(WB_ALU_RESULT),
        .WB_READ_DATA(WB_READ_DATA),
        .WB_WRITE_ADDR(WB_RD),
        .WB_WRITE_ENABLE(WB_WRITE_ENABLE),
        .WB_DATA_MEM_SELECT(WB_DATA_MEM_SELECT),
        .WB_FUNC3(WB_FUNC3)
    );

    // Data Memory
    wire [31:0] MEM_READ_DATA;
    DATA_MEMORY DATA_MEMORY (
        .CLK(CLK),
        .ADDRESS(MEM_ALU_RESULT),
        .WRITE_DATA(MEM_READ_DATA2),
        .MEM_WRITE(MEM_MEM_WRITE),
        .MEM_READ(MEM_MEM_READ),
        .FUNC3(MEM_FUNC3),
        .READ_DATA(MEM_READ_DATA)
    );

    // Instantiate other components
    // Instruction Fetch Unit
    // ...existing code...

    // Instruction Decode Unit
    // ...existing code...

    // Execute Unit
    // ...existing code...

    // Memory Access Unit
    // ...existing code...

    // Write Back Unit
    // ...existing code...

endmodule
