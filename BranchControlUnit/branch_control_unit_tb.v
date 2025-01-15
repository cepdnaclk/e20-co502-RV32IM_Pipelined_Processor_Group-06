`timescale 1ns / 1ps

module branch_control_unit_tb;
    // Inputs
    reg JUMP;
    reg BRANCH;
    reg [2:0] FUNC3;
    reg [31:0] OUT1;
    reg [31:0] OUT2;
    reg [31:0] ALU_RESULT;

    // Outputs
    wire [31:0] TARGET_ADDRESS;
    wire BRANCH_SELECT;

    // Instantiate the Unit Under Test (UUT)
    BRANCH_CONTROL_UNIT uut (
        .JUMP(JUMP),
        .BRANCH(BRANCH),
        .FUNC3(FUNC3),
        .OUT1(OUT1),
        .OUT2(OUT2),
        .ALU_RESULT(ALU_RESULT),
        .TARGET_ADDRESS(TARGET_ADDRESS),
        .BRANCH_SELECT(BRANCH_SELECT)
    );

    initial begin
        // Open VCD file for GTKWave
        $dumpfile("branch_control_unit_tb.vcd");
        $dumpvars(0, branch_control_unit_tb);

        // Initialize Inputs
        JUMP = 0;
        BRANCH = 0;
        FUNC3 = 3'b000;
        OUT1 = 32'b0;
        OUT2 = 32'b0;
        ALU_RESULT = 32'b0;

        // Test JUMP instruction
        #10 JUMP = 1; ALU_RESULT = 32'h00000010; #10;
        JUMP = 0;

        // Test BEQ instruction
        #10 BRANCH = 1; FUNC3 = 3'b000; OUT1 = 32'h00000001; OUT2 = 32'h00000001; ALU_RESULT = 32'h00000020; #10;
        BRANCH = 0;

        // Test BNE instruction
        #10 BRANCH = 1; FUNC3 = 3'b001; OUT1 = 32'h00000001; OUT2 = 32'h00000002; ALU_RESULT = 32'h00000030; #10;
        BRANCH = 0;

        // Test BLT instruction
        #10 BRANCH = 1; FUNC3 = 3'b100; OUT1 = 32'h00000001; OUT2 = 32'h00000002; ALU_RESULT = 32'h00000040; #10;
        BRANCH = 0;

        // Test BGE instruction
        #10 BRANCH = 1; FUNC3 = 3'b101; OUT1 = 32'h00000002; OUT2 = 32'h00000001; ALU_RESULT = 32'h00000050; #10;
        BRANCH = 0;

        // Test BLTU instruction
        #10 BRANCH = 1; FUNC3 = 3'b110; OUT1 = 32'h00000001; OUT2 = 32'h00000002; ALU_RESULT = 32'h00000060; #10;
        BRANCH = 0;

        // Test BGEU instruction
        #10 BRANCH = 1; FUNC3 = 3'b111; OUT1 = 32'h00000002; OUT2 = 32'h00000001; ALU_RESULT = 32'h00000070; #10;
        BRANCH = 0;

        // Test JAL instruction
        #10 JUMP = 1; ALU_RESULT = 32'h00000080; #10;
        JUMP = 0;

        // Finish the simulation
        $finish;
    end
      
endmodule
