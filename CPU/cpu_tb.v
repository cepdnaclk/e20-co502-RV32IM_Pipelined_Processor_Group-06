`timescale 1ns / 1ps

module cpu_tb;
    // Inputs
    reg CLK;
    reg RST;

    // Instantiate the Unit Under Test (UUT)
    CPU uut (
        .CLK(CLK),
        .RST(RST)
    );

    initial begin
        // Initialize Inputs
        CLK = 0;
        RST = 1;

        // Wait for global reset
        #10;
        RST = 0;

        // Add stimulus here
        // Test case 1: Normal operation
        #350;

        // Test case 2: Reset during operation
        RST = 1;
        #10;
        RST = 0;
        #100;

        // Test case 3: Another normal operation
        #100;

        // Finish simulation
        $finish;
    end

    // Clock generation
    always #5 CLK = ~CLK;


    integer i;
    // Dump waveform
    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);

        // Adding the register file inside REGISTERS to the GTKwave
        for (i=0; i<32; i=i+1)
            $dumpvars(1,cpu_tb.uut.id_stage.register_file.REGISTERS[i]);
    end

endmodule

// command to run simulation
// iverilog -o cpu_tb.vvp cpu_tb.v cpu.v IF/IF.v ID/ID.v EX/EX.v MEM/MEM.v WB/WB.v ../PipelineRegisters/IF_ID.v ../PipelineRegisters/ID_EX.v ../PipelineRegisters/EX_MEM.v ../PipelineRegisters/MEM_WB.v ../ProgramCounter/ProgramCounter.v ../InstructionMemory/InstructionMemory.v ../DataMemory/DataMemory.v ../Registers/RegisterFile.v ../ALU/ALU.v ../BranchControlUnit/branch_control_unit.v ../ControlUnit/control_unit.v ../LoadProcessingUnit/load_processing_unit.v ../MUX/MUX.v ../ImmidiatePick/Imm_pick.v ../Alu_ctrl/alu_ctrl.v
// vvp cpu_tb.vvp
// gtkwave cpu_tb.vcd
