module ID (
    input wire CLK,
    input wire RST,
    input wire [31:0] IF_PC,
    input wire [31:0] IF_INSTRUCTION,
    input wire [31:0] IF_PC_PLUS4,
    input wire [31:0] WB_WRITE_DATA,
    input wire WB_WRITE_ENABLE,
    input wire [4:0] WB_RD,
    output wire [31:0] ID_PC,
    output wire [31:0] ID_PC_PLUS4,
    output wire [31:0] ID_READ_DATA1,
    output wire [31:0] ID_READ_DATA2,
    output wire [31:0] ID_IMMEDIATE,
    output wire [4:0] ID_RD,
    output wire [2:0] ID_FUNC3,
    output wire [2:0] ID_ALU_CONTROL,
    output wire ID_WRITE_ENABLE,
    output wire ID_DATA_MEM_SELECT,
    output wire ID_MEM_WRITE,
    output wire ID_MEM_READ,
    output wire ID_JAL_SELECT,
    output wire ID_IMM_SELECT,
    output wire ID_PC_SELECT,
    output wire ID_BRANCH,
    output wire ID_JUMP
);

    wire [2:0] IMM_PICK;
    wire [2:0] ALU_OP;

    // Control Unit
    CONTROL_UNIT control_unit (
        .OPCODE(IF_INSTRUCTION[6:0]),
        .FUNC3(IF_INSTRUCTION[14:12]),
        .FUNC7(IF_INSTRUCTION[31:25]),
        .WRITE_EN(ID_WRITE_ENABLE),
        .MEM_WRITE(ID_MEM_WRITE),
        .MEM_READ(ID_MEM_READ),
        .BRANCH(ID_BRANCH),
        .JUMP(ID_JUMP),
        .PC_SELECT(ID_PC_SELECT),
        .IMM_SELECT(ID_IMM_SELECT),
        .JAL_SELECT(ID_JAL_SELECT),
        .DATA_MEM_SELECT(ID_DATA_MEM_SELECT),
        .ALU_OP(ALU_OP),
        .IMM_PICK(IMM_PICK)
    );

    // Register File
    REGISTER_FILE register_file (
        .CLK(CLK),
        .RST(RST),
        .WRITE_ENABLE(WB_WRITE_ENABLE),
        .READ_REG1(IF_INSTRUCTION[19:15]),
        .READ_REG2(IF_INSTRUCTION[24:20]),
        .WRITE_REG(WB_RD),
        .WRITE_DATA(WB_WRITE_DATA),
        .READ_DATA1(ID_READ_DATA1),
        .READ_DATA2(ID_READ_DATA2)
    );

    // Immediate Generator
    IMMEDIATE_GENERATOR immediate_generator (
        .INSTRUCTION(IF_INSTRUCTION),
        .IMM_PICK(IMM_PICK),
        .IMMEDIATE(ID_IMMEDIATE)
    );

    // ALU Control
    ALU_CONTROL alu_control (
        .FUNC3(IF_INSTRUCTION[14:12]),
        .FUNC7(IF_INSTRUCTION[31:25]),
        .ALU_OP(ALU_OP),
        .ALU_CTRL(ID_ALU_CONTROL)
    );

    // Direct connections
    assign ID_PC = IF_PC;
    assign ID_PC_PLUS4 = IF_PC_PLUS4;
    assign ID_RD = IF_INSTRUCTION[11:7];
    assign ID_FUNC3 = IF_INSTRUCTION[14:12];

endmodule
