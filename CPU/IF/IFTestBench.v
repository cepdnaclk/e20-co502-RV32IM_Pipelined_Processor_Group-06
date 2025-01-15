module IFTestBench;

    // Testbench signals
    reg CLK;
    reg RST;
    reg [31:0] PCADDRESS; // Program Counter
    wire [31:0] INSTRUCTION; // Instruction output
    wire [31:0] PCPLUS4; // Program Counter + 4
    wire [31:0] IF_PC; // IF module PC output

    // Instantiate the IF module
    IF UUT (
        .CLK(CLK),
        .RST(RST),
        .NEXT_PC(PCADDRESS),
        .IF_PC(IF_PC),
        .IF_PC_PLUS4(PCPLUS4),
        .IF_INSTRUCTION(INSTRUCTION)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    // Test sequence
    initial begin
        // Open VCD file for GTKWave
        $dumpfile("IFTESTBENCH.vcd");
        $dumpvars(0, IFTestBench);

        // Monitor signals in the simulation
        $monitor("Time = %0d, PC Address = %h, Instruction = %h, PC + 4 = %h", $time, PCADDRESS, INSTRUCTION, PCPLUS4);

        // Initialize signals
        RST = 1;
        PCADDRESS = 0;
        #10;
        RST = 0;

        // Test case 1: Access instruction at address 0
        PCADDRESS = 0;
        #10;

        // Test case 2: Access instruction at address 4
        PCADDRESS = 4;
        #10;

        // Test case 3: Access instruction at address 8
        PCADDRESS = 8;
        #10;

        // Test case 4: Access instruction at address 12
        PCADDRESS = 12;
        #10;

        // Test case 5: Access instruction at address 16
        PCADDRESS = 16;
        #10;

        // Test case 6: Access instruction at address 20
        PCADDRESS = 20;
        #10;

        $finish;
    end
endmodule

// # Navigate to the directory containing your Verilog files
// cd /d:/My projects/e20-co502-RV32IM_Pipelined_Processor_Group-06/CPU/IF/

// # Compile the Verilog files with correct paths
// iverilog -o IFTestBench.vvp IF.v IFTestBench.v ../../ProgramCounter/ProgramCounter.v ../../InstructionMemory/InstructionMemory.v

// # Run the simulation
// vvp IFTestBench.vvp

// # View the waveform using GTKWave (optional)
// gtkwave IFTESTBENCH.vcd