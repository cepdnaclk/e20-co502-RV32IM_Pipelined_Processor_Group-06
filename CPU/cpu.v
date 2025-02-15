module CPU (
    input wire CLK,
    input wire RST
);

    // IF stage wires
    wire [31:0] IF_PC_out, NEXT_PC_in, IF_PC_PLUS4_out, IF_INSTRUCTION_out;

    // ID stage wires
    wire [31:0] IF_PC_in, IF_INSTRUCTION_in, IF_PC_PLUS4_in;
    wire [31:0] ID_PC_out, ID_PC_PLUS4_out, ID_READ_DATA1_out, ID_READ_DATA2_out, ID_IMMEDIATE_out;
    wire [4:0] ID_RD_out;
    wire [2:0] ID_FUNC3_out;
    wire [4:0] ID_ALU_CONTROL_out;
    wire ID_WRITE_ENABLE_out, ID_DATA_MEM_SELECT_out, ID_MEM_WRITE_out, ID_MEM_READ_out, ID_JAL_SELECT_out, ID_IMM_SELECT_out, ID_PC_SELECT_out, ID_BRANCH_out, ID_JUMP_out;

    // EX stage wires
    wire [31:0] ID_PC_in, ID_PC_PLUS4_in, ID_READ_DATA1_in, ID_READ_DATA2_in, ID_IMMEDIATE_in;
    wire [4:0] ID_RD_in;
    wire [2:0] ID_FUNC3_in;
    wire [4:0] ID_ALU_CONTROL_in;
    wire ID_WRITE_ENABLE_in, ID_DATA_MEM_SELECT_in, ID_MEM_WRITE_in, ID_MEM_READ_in, ID_JAL_SELECT_in, ID_IMM_SELECT_in, ID_PC_SELECT_in, ID_BRANCH_in, ID_JUMP_in;
    wire [2:0] EX_FUNC3_out;
    wire EX_WRITE_ENABLE_out, EX_DATA_MEM_SELECT_out, EX_MEM_WRITE_out, EX_MEM_READ_out;
    wire [31:0] EX_JAL_SELECTED_out;
    wire [31:0] EX_READ_DATA2_out;
    wire [4:0] EX_RD_out;
    wire [31:0] EX_PC_TARGET_out; // directly to PC
    wire EX_BRANCH_SELECT_out; // directly to PC
    wire BRANCH_PIPLINE_RESET_out; // directly to OR gate to reset pipelines 

    // BRANCH OR GATE
    reg BRANCH_OR_HARD_RESET_out; // directly to OR gate to reset pipelines( IF_ID and ID_EX) (reg is used to store the value)

    // MEM stage wires
    wire [2:0] EX_FUNC3_in;
    wire EX_WRITE_ENABLE_in, EX_DATA_MEM_SELECT_in, EX_MEM_WRITE_in, EX_MEM_READ_in;
    wire [31:0] EX_JAL_SELECTED_in, EX_READ_DATA2_in;
    wire [4:0] EX_RD_in;
    wire [2:0] MEM_FUNC3_out;
    wire MEM_WRITE_ENABLE_out, MEM_DATA_MEM_SELECT_out;
    wire [31:0] MEM_JAL_SELECTED_out, MEM_DATA_OUT_out;
    wire [4:0] MEM_RD_out;

    // WB stage wires
    wire [2:0] MEM_FUNC3_in;
    wire MEM_WRITE_ENABLE_in, MEM_DATA_MEM_SELECT_in;
    wire [31:0] MEM_JAL_SELECTED_in, MEM_DATA_OUT_in;
    wire [4:0] MEM_RD_in;
    wire WB_WRITE_ENABLE_out;
    wire [31:0] WB_WRITE_DATA_out;
    wire [4:0] WB_RD_out;

    // MUX TO SELECT NEXT INSTRUCTION
    MUX next_pc_mux (
        .IN0(IF_PC_PLUS4_out),
        .IN1(EX_PC_TARGET_out),
        .SEL(EX_BRANCH_SELECT_out),
        .OUT(NEXT_PC_in)
    );

    // OR GATE TO RESET PIPELINES
    // If BRANCH_PIPLINE_RESET_out or RESET is 1; then reset two previous pipelines (IF_ID and ID_EX) mannually created the OR gate
    always @(*) begin
        if (BRANCH_PIPLINE_RESET_out || RST) begin
            BRANCH_OR_HARD_RESET_out = 1'b1;
            end 
        else begin
            BRANCH_OR_HARD_RESET_out = 1'b0;
        end
    end

    // IF stage
    IF if_stage (
        .CLK(CLK),
        .RST(RST),
        .NEXT_PC(NEXT_PC_in),
        .IF_PC(IF_PC_out),
        .IF_PC_PLUS4(IF_PC_PLUS4_out),
        .IF_INSTRUCTION(IF_INSTRUCTION_out)
    );

    // IF_ID pipeline register
    IF_ID if_id (
        .CLK(CLK),
        .RST(BRANCH_OR_HARD_RESET_out),
        .IF_PC(IF_PC_out),
        .IF_INSTRUCTION(IF_INSTRUCTION_out),
        .IF_PC_PLUS4(IF_PC_PLUS4_out),
        .ID_PC(IF_PC_in),
        .ID_INSTRUCTION(IF_INSTRUCTION_in),
        .ID_PC_PLUS4(IF_PC_PLUS4_in)
    );
        
    // ID stage
    ID id_stage (
        .CLK(CLK),
        .RST(RST),
        .IF_PC(IF_PC_in),
        .IF_INSTRUCTION(IF_INSTRUCTION_in),
        .IF_PC_PLUS4(IF_PC_PLUS4_in),
        .WB_WRITE_DATA(WB_WRITE_DATA_out), /// directly from WB stage
        .WB_WRITE_ENABLE(WB_WRITE_ENABLE_out), /// directly from WB stage
        .WB_RD(WB_RD_out), /// directly from WB stage
        .ID_PC(ID_PC_out), 
        .ID_PC_PLUS4(ID_PC_PLUS4_out),
        .ID_READ_DATA1(ID_READ_DATA1_out),
        .ID_READ_DATA2(ID_READ_DATA2_out),
        .ID_IMMEDIATE(ID_IMMEDIATE_out),
        .ID_RD(ID_RD_out),
        .ID_FUNC3(ID_FUNC3_out),
        .ID_ALU_CONTROL(ID_ALU_CONTROL_out),
        .ID_WRITE_ENABLE(ID_WRITE_ENABLE_out),
        .ID_DATA_MEM_SELECT(ID_DATA_MEM_SELECT_out),
        .ID_MEM_WRITE(ID_MEM_WRITE_out),
        .ID_MEM_READ(ID_MEM_READ_out),
        .ID_JAL_SELECT(ID_JAL_SELECT_out),
        .ID_IMM_SELECT(ID_IMM_SELECT_out),
        .ID_PC_SELECT(ID_PC_SELECT_out),
        .ID_BRANCH(ID_BRANCH_out),
        .ID_JUMP(ID_JUMP_out)
    );

    // ID_EX pipeline register
    ID_EX id_ex (
        .CLK(CLK),
        .RST(BRANCH_OR_HARD_RESET_out),
        .ID_PC(ID_PC_out),
        .ID_READ_DATA1(ID_READ_DATA1_out),
        .ID_READ_DATA2(ID_READ_DATA2_out),
        .ID_IMMEDIATE(ID_IMMEDIATE_out),
        .ID_RD(ID_RD_out),
        .ID_FUNC3(ID_FUNC3_out),
        .ID_PC_PLUS4(ID_PC_PLUS4_out),
        .ID_ALU_CONTROL(ID_ALU_CONTROL_out),
        .ID_WRITE_ENABLE(ID_WRITE_ENABLE_out),
        .ID_DATA_MEM_SELECT(ID_DATA_MEM_SELECT_out),
        .ID_MEM_WRITE(ID_MEM_WRITE_out),
        .ID_MEM_READ(ID_MEM_READ_out),
        .ID_JAL_SELECT(ID_JAL_SELECT_out),
        .ID_IMM_SELECT(ID_IMM_SELECT_out),
        .ID_PC_SELECT(ID_PC_SELECT_out),
        .ID_BRANCH(ID_BRANCH_out),
        .ID_JUMP(ID_JUMP_out),
        .EX_PC(ID_PC_in),
        .EX_READ_DATA1(ID_READ_DATA1_in),
        .EX_READ_DATA2(ID_READ_DATA2_in),
        .EX_IMMEDIATE(ID_IMMEDIATE_in),
        .EX_RD(ID_RD_in),
        .EX_FUNC3(ID_FUNC3_in),
        .EX_PC_PLUS4(ID_PC_PLUS4_in),
        .EX_ALU_CONTROL(ID_ALU_CONTROL_in),
        .EX_WRITE_ENABLE(ID_WRITE_ENABLE_in),
        .EX_DATA_MEM_SELECT(ID_DATA_MEM_SELECT_in),
        .EX_MEM_WRITE(ID_MEM_WRITE_in),
        .EX_MEM_READ(ID_MEM_READ_in),
        .EX_JAL_SELECT(ID_JAL_SELECT_in),
        .EX_IMM_SELECT(ID_IMM_SELECT_in),
        .EX_PC_SELECT(ID_PC_SELECT_in),
        .EX_BRANCH(ID_BRANCH_in),
        .EX_JUMP(ID_JUMP_in)
    );

    // EX stage
    EX ex_stage (
        .CLK(CLK),
        .RST(RST),
        .ID_PC(ID_PC_in),
        .ID_PC_PLUS4(ID_PC_PLUS4_in),
        .ID_READ_DATA1(ID_READ_DATA1_in),
        .ID_READ_DATA2(ID_READ_DATA2_in),
        .ID_IMMEDIATE(ID_IMMEDIATE_in),
        .ID_RD(ID_RD_in),
        .ID_FUNC3(ID_FUNC3_in),
        .ID_ALU_CONTROL(ID_ALU_CONTROL_in),
        .ID_WRITE_ENABLE(ID_WRITE_ENABLE_in),
        .ID_DATA_MEM_SELECT(ID_DATA_MEM_SELECT_in),
        .ID_MEM_WRITE(ID_MEM_WRITE_in),
        .ID_MEM_READ(ID_MEM_READ_in),
        .ID_JAL_SELECT(ID_JAL_SELECT_in),
        .ID_IMM_SELECT(ID_IMM_SELECT_in),
        .ID_PC_SELECT(ID_PC_SELECT_in),
        .ID_BRANCH(ID_BRANCH_in),
        .ID_JUMP(ID_JUMP_in),
        .EX_FUNC3(EX_FUNC3_out),
        .EX_WRITE_ENABLE(EX_WRITE_ENABLE_out),
        .EX_DATA_MEM_SELECT(EX_DATA_MEM_SELECT_out),
        .EX_MEM_WRITE(EX_MEM_WRITE_out),
        .EX_MEM_READ(EX_MEM_READ_out),
        .EX_JAL_SELECTED(EX_JAL_SELECTED_out),
        .EX_READ_DATA2(EX_READ_DATA2_out),
        .EX_RD(EX_RD_out),
        .EX_PC_TARGET(EX_PC_TARGET_out),
        .EX_BRANCH_SELECT(EX_BRANCH_SELECT_out),
        .BRANCH_PIPLINE_RESET(BRANCH_PIPLINE_RESET_out)
    );

    EX_MEM ex_mem (
        .CLK(CLK),
        .RST(RST),
        .EX_JAL_SELECTED(EX_JAL_SELECTED_out),
        .EX_READ_DATA2(EX_READ_DATA2_out),
        .EX_RD(EX_RD_out),
        .EX_MEM_WRITE(EX_MEM_WRITE_out),
        .EX_MEM_READ(EX_MEM_READ_out),
        .EX_FUNC3(EX_FUNC3_out),
        .EX_WRITE_ENABLE(EX_WRITE_ENABLE_out),
        .EX_DATA_MEM_SELECT(EX_DATA_MEM_SELECT_out),
        .MEM_JAL_SELECTED(EX_JAL_SELECTED_in),
        .MEM_READ_DATA2(EX_READ_DATA2_in),
        .MEM_RD(EX_RD_in),
        .MEM_MEM_WRITE(EX),
        .MEM_MEM_READ(EX_MEM_READ_in),
        .MEM_FUNC3(EX_FUNC3_in),
        .MEM_WRITE_ENABLE(EX_WRITE_ENABLE_in),
        .MEM_DATA_MEM_SELECT(EX_DATA_MEM_SELECT_in)
    );

    // MEM stage
    MEM mem_stage (
        .CLK(CLK),
        .RST(RST),
        .EX_FUNC3(EX_FUNC3_in),
        .EX_WRITE_ENABLE(EX_WRITE_ENABLE_in),
        .EX_DATA_MEM_SELECT(EX_DATA_MEM_SELECT_in),
        .EX_MEM_WRITE(EX_MEM_WRITE_in),
        .EX_MEM_READ(EX_MEM_READ_in),
        .EX_JAL_SELECTED(EX_JAL_SELECTED_in),
        .EX_READ_DATA2(EX_READ_DATA2_in),
        .EX_RD(EX_RD_in),
        .MEM_FUNC3(MEM_FUNC3_out),
        .MEM_WRITE_ENABLE(MEM_WRITE_ENABLE_out),
        .MEM_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT_out),
        .MEM_JAL_SELECTED(MEM_JAL_SELECTED_out),
        .MEM_DATA_OUT(MEM_DATA_OUT_out),
        .MEM_RD(MEM_RD_out)
    );

    MEM_WB mem_wb (
        .CLK(CLK),
        .RST(RST),
        .MEM_JAL_SELECTED(MEM_JAL_SELECTED_out),
        .MEM_DATA_OUT(MEM_DATA_OUT_out),
        .MEM_RD(MEM_RD_out),
        .MEM_WRITE_ENABLE(MEM_WRITE_ENABLE_out),
        .MEM_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT_out),
        .MEM_FUNC3(MEM_FUNC3_out),
        .WB_JAL_SELECTED(MEM_JAL_SELECTED_in),
        .WB_DATA_OUT(MEM_DATA_OUT_in),
        .WB_RD(MEM_RD_in),
        .WB_WRITE_ENABLE(MEM_WRITE_ENABLE_in),
        .WB_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT_in),
        .WB_FUNC3(MEM_FUNC3_in)
    );

    // WB stage
    WB wb_stage (
        .CLK(CLK),
        .RST(RST),
        .MEM_FUNC3(MEM_FUNC3_in),
        .MEM_WRITE_ENABLE(MEM_WRITE_ENABLE_in),
        .MEM_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT_in),
        .MEM_JAL_SELECTED(MEM_JAL_SELECTED_in),
        .MEM_DATA_OUT(MEM_DATA_OUT_in),
        .MEM_RD(MEM_RD_in),
        .WB_WRITE_ENABLE(WB_WRITE_ENABLE_out),
        .WB_WRITE_DATA(WB_WRITE_DATA_out),
        .WB_RD(WB_RD_out)
    );

endmodule
