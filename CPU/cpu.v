module CPU (
    input wire CLK,
    input wire RST
);

    // IF stage wires
    wire [31:0] IF_PC, IF_PC_PLUS4, IF_INSTRUCTION;

    // ID stage wires
    wire [31:0] ID_PC, ID_PC_PLUS4, ID_READ_DATA1, ID_READ_DATA2, ID_IMMEDIATE;
    wire [4:0] ID_RD;
    wire [2:0] ID_FUNC3, ID_ALU_CONTROL;
    wire ID_WRITE_ENABLE, ID_DATA_MEM_SELECT, ID_MEM_WRITE, ID_MEM_READ, ID_JAL_SELECT, ID_IMM_SELECT, ID_PC_SELECT, ID_BRANCH, ID_JUMP;

    // EX stage wires
    wire [31:0] EX_ALU_RESULT, EX_READ_DATA2;
    wire [4:0] EX_WRITE_ADDR;
    wire EX_MEM_WRITE, EX_MEM_READ, EX_WRITE_ENABLE, EX_DATA_MEM_SELECT;
    wire [2:0] EX_FUNC3;

    // MEM stage wires
    wire [31:0] MEM_ALU_RESULT, MEM_READ_DATA2, MEM_DATA_OUT;
    wire [4:0] MEM_WRITE_ADDR;
    wire MEM_MEM_WRITE, MEM_MEM_READ, MEM_WRITE_ENABLE, MEM_DATA_MEM_SELECT;
    wire [2:0] MEM_FUNC3;

    // WB stage wires
    wire [31:0] WB_WRITE_DATA;
    wire [4:0] WB_RD;
    wire WB_WRITE_ENABLE;

    // IF stage
    IF if_stage (
        .CLK(CLK),
        .RST(RST),
        .NEXT_PC(IF_PC_PLUS4),
        .IF_PC(IF_PC),
        .IF_PC_PLUS4(IF_PC_PLUS4),
        .IF_INSTRUCTION(IF_INSTRUCTION)
    );

    // ID stage
    ID id_stage (
        .CLK(CLK),
        .RST(RST),
        .IF_PC(IF_PC),
        .IF_INSTRUCTION(IF_INSTRUCTION),
        .IF_PC_PLUS4(IF_PC_PLUS4),
        .WB_WRITE_DATA(WB_WRITE_DATA),
        .WB_WRITE_ENABLE(WB_WRITE_ENABLE),
        .WB_RD(WB_RD),
        .ID_PC(ID_PC),
        .ID_PC_PLUS4(ID_PC_PLUS4),
        .ID_READ_DATA1(ID_READ_DATA1),
        .ID_READ_DATA2(ID_READ_DATA2),
        .ID_IMMEDIATE(ID_IMMEDIATE),
        .ID_RD(ID_RD),
        .ID_FUNC3(ID_FUNC3),
        .ID_ALU_CONTROL(ID_ALU_CONTROL),
        .ID_WRITE_ENABLE(ID_WRITE_ENABLE),
        .ID_DATA_MEM_SELECT(ID_DATA_MEM_SELECT),
        .ID_MEM_WRITE(ID_MEM_WRITE),
        .ID_MEM_READ(ID_MEM_READ),
        .ID_JAL_SELECT(ID_JAL_SELECT),
        .ID_IMM_SELECT(ID_IMM_SELECT),
        .ID_PC_SELECT(ID_PC_SELECT),
        .ID_BRANCH(ID_BRANCH),
        .ID_JUMP(ID_JUMP)
    );

    // EX stage
    EX_MEM ex_mem_stage (
        .CLK(CLK),
        .RST(RST),
        .EX_ALU_RESULT(EX_ALU_RESULT),
        .EX_READ_DATA2(EX_READ_DATA2),
        .EX_WRITE_ADDR(EX_WRITE_ADDR),
        .EX_MEM_WRITE(EX_MEM_WRITE),
        .EX_MEM_READ(EX_MEM_READ),
        .EX_FUNC3(EX_FUNC3),
        .EX_WRITE_ENABLE(EX_WRITE_ENABLE),
        .EX_DATA_MEM_SELECT(EX_DATA_MEM_SELECT),
        .MEM_ALU_RESULT(MEM_ALU_RESULT),
        .MEM_READ_DATA2(MEM_READ_DATA2),
        .MEM_WRITE_ADDR(MEM_WRITE_ADDR),
        .MEM_MEM_WRITE(MEM_MEM_WRITE),
        .MEM_MEM_READ(MEM_MEM_READ),
        .MEM_FUNC3(MEM_FUNC3),
        .MEM_WRITE_ENABLE(MEM_WRITE_ENABLE),
        .MEM_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT)
    );

    // MEM stage
    MEM_WB mem_wb_stage (
        .CLK(CLK),
        .RST(RST),
        .MEM_ALU_RESULT(MEM_ALU_RESULT),
        .MEM_READ_DATA(MEM_DATA_OUT),
        .MEM_WRITE_ADDR(MEM_WRITE_ADDR),
        .MEM_WRITE_ENABLE(MEM_WRITE_ENABLE),
        .MEM_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT),
        .MEM_FUNC3(MEM_FUNC3),
        .WB_ALU_RESULT(WB_WRITE_DATA),
        .WB_READ_DATA(MEM_DATA_OUT),
        .WB_WRITE_ADDR(WB_RD),
        .WB_WRITE_ENABLE(WB_WRITE_ENABLE),
        .WB_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT),
        .WB_FUNC3(MEM_FUNC3)
    );

    // WB stage
    WB wb_stage (
        .CLK(CLK),
        .RST(RST),
        .MEM_FUNC3(MEM_FUNC3),
        .MEM_WRITE_ENABLE(MEM_WRITE_ENABLE),
        .MEM_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT),
        .MEM_JAL_SELECTED(MEM_ALU_RESULT),
        .MEM_DATA_OUT(MEM_DATA_OUT),
        .MEM_RD(MEM_WRITE_ADDR),
        .WB_WRITE_ENABLE(WB_WRITE_ENABLE),
        .WB_WRITE_DATA(WB_WRITE_DATA),
        .WB_RD(WB_RD)
    );

endmodule
