module EX (
    input wire CLK,
    input wire RST,
    input wire [1:0] ID_MEM_FORWARD_EN,
    input wire [1:0] ID_WB_FORWARD_EN,
    input wire [31:0] WB_RD_DATA,
    input wire [31:0] MEM_RD_DATA,
    input wire [31:0] ID_PC,
    input wire [31:0] ID_PC_PLUS4,
    input wire [31:0] ID_READ_DATA1,
    input wire [31:0] ID_READ_DATA2,
    input wire [31:0] ID_IMMEDIATE,
    input wire [4:0] ID_RD,
    input wire [2:0] ID_FUNC3,
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
    output wire [2:0] EX_FUNC3,
    output wire EX_WRITE_ENABLE,
    output wire EX_DATA_MEM_SELECT,
    output wire EX_MEM_WRITE,
    output wire EX_MEM_READ,
    output wire [31:0] EX_JAL_SELECTED,
    output wire [31:0] EX_READ_DATA2,
    output wire [4:0] EX_RD,
    output wire [31:0] EX_PC_TARGET, // directly to PC
    output wire EX_BRANCH_SELECT,  // direcly to PC
    output wire BRANCH_PIPLINE_RESET
);
    // Internal signals
    wire [31:0] PC_SELECTED, IMM_SELECTED, ALU_RESULT, OUT1_FORWARD_DATA, OUT2_FORWARD_DATA, FORWARD_SELECTED_READ_DATA1, FORWARD_SELECTED_READ_DATA2;
    wire OUT1_FORWARD_EN, OUT2_FORWARD_EN;

    FORWARDING_CONTROL_UNIT forwarding_control_unit (
        .WB_FORWARD_EN(ID_WB_FORWARD_EN),
        .MEM_FORWARD_EN(ID_MEM_FORWARD_EN),
        .WB_RD_DATA(WB_RD_DATA), // directly from WB
        .MEM_RD_DATA(MEM_RD_DATA), // directly from MEM
        .OUT1_FORWARD_EN(OUT1_FORWARD_EN),
        .OUT2_FORWARD_EN(OUT2_FORWARD_EN),
        .OUT1_FORWARD_DATA(OUT1_FORWARD_DATA),
        .OUT2_FORWARD_DATA(OUT2_FORWARD_DATA)
    );

    // Out 1 Forwarding Mux
    MUX out1_forwarding_mux (
        .IN0(ID_READ_DATA1),
        .IN1(OUT1_FORWARD_DATA),
        .SEL(OUT1_FORWARD_EN),
        .OUT(FORWARD_SELECTED_READ_DATA1)/////
    );

    // Out 2 Forwarding Mux
    MUX out2_forwarding_mux (
        .IN0(ID_READ_DATA2),
        .IN1(OUT2_FORWARD_DATA),
        .SEL(OUT2_FORWARD_EN),
        .OUT(FORWARD_SELECTED_READ_DATA2)/////
    );

    // Immediate Select Mux
    MUX imm_select (
        .IN0(FORWARD_SELECTED_READ_DATA2),
        .IN1(ID_IMMEDIATE),
        .SEL(ID_IMM_SELECT),
        .OUT(IMM_SELECTED)
    );

    // PC Select Mux
    MUX pc_select (
        .IN0(FORWARD_SELECTED_READ_DATA1),
        .IN1(ID_PC),
        .SEL(ID_PC_SELECT),
        .OUT(PC_SELECTED)
    );

    // ALU JAL SELECT MUX
    MUX jal_select (
        .IN0(ALU_RESULT),
        .IN1(ID_PC_PLUS4),
        .SEL(ID_JAL_SELECT),
        .OUT(EX_JAL_SELECTED)
    );

    // ALU
    ALU alu (
        .DATA1(PC_SELECTED),
        .DATA2(IMM_SELECTED),
        .ALU_OPERATION(ID_ALU_CONTROL),
        .RESULT(ALU_RESULT)
    );

    // Branch Control Unit
    BRANCH_CONTROL_UNIT branch_control_unit (
        .JUMP(ID_JUMP),
        .BRANCH(ID_BRANCH),
        .FUNC3(ID_FUNC3),
        .OUT1(FORWARD_SELECTED_READ_DATA1),
        .OUT2(FORWARD_SELECTED_READ_DATA2),
        .ALU_RESULT(ALU_RESULT),
        .TARGET_ADDRESS(EX_PC_TARGET),
        .BRANCH_SELECT(EX_BRANCH_SELECT),
        .RESET(BRANCH_PIPLINE_RESET)
    );

    // Output assignments
    assign EX_READ_DATA2 = FORWARD_SELECTED_READ_DATA2;
    assign EX_RD = ID_RD;
    assign EX_FUNC3 = ID_FUNC3;
    assign EX_WRITE_ENABLE = ID_WRITE_ENABLE;
    assign EX_DATA_MEM_SELECT = ID_DATA_MEM_SELECT;
    assign EX_MEM_WRITE = ID_MEM_WRITE;
    assign EX_MEM_READ = ID_MEM_READ;

endmodule
