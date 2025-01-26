module IDTestBench;

    // Inputs
    reg CLK;
    reg RST;
    reg [31:0] IF_PC;
    reg [31:0] IF_INSTRUCTION;
    reg [31:0] IF_PC_PLUS4;
    reg [31:0] WB_WRITE_DATA;
    reg WB_WRITE_ENABLE;
    reg [4:0] WB_RD;

    // Outputs
    wire [31:0] ID_PC;
    wire [31:0] ID_PC_PLUS4;
    wire [31:0] ID_READ_DATA1;
    wire [31:0] ID_READ_DATA2;
    wire [31:0] ID_IMMEDIATE;
    wire [4:0] ID_RD;
    wire [2:0] ID_FUNC3;
    wire [2:0] ID_ALU_CONTROL;
    wire ID_WRITE_ENABLE;
    wire ID_DATA_MEM_SELECT;
    wire ID_MEM_WRITE;
    wire ID_MEM_READ;
    wire ID_JAL_SELECT;
    wire ID_IMM_SELECT;
    wire ID_PC_SELECT;
    wire ID_BRANCH;
    wire ID_JUMP;

    // Instantiate the Unit Under Test (UUT)
    ID uut (
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

    initial begin
        // Initialize Inputs
        CLK = 0;
        RST = 1;
        IF_PC = 0;
        IF_INSTRUCTION = 0;
        IF_PC_PLUS4 = 0;
        WB_WRITE_DATA = 0;
        WB_WRITE_ENABLE = 0;
        WB_RD = 0;

        // Wait for global reset
        #100;
        RST = 0;

        // Add stimulus here
        // Example instruction: ADD x1, x2, x3
        IF_INSTRUCTION = 32'b0000000_00011_00010_000_00001_0110011; // ADD x1, x2, x3
        IF_PC = 32'h00000004;
        IF_PC_PLUS4 = 32'h00000008;
        WB_WRITE_DATA = 32'h0000000A;
        WB_WRITE_ENABLE = 1;
        WB_RD = 5'b00001;

        #20;
        // Check outputs
        // Add more test cases as needed

        $stop;
    end

    always #10 CLK = ~CLK;

endmodule


// iverilog -o IDTestBench.vvp ID.v IDTestBench.v ../../ControlUnit/control_unit.v ../../Registers/RegisterFile.v IMMEDIATE_GENERATOR.v ALU_CONTROL.v ../../Programcounter/ProgramCounter.v ../../Memory/InstructionMemory.v