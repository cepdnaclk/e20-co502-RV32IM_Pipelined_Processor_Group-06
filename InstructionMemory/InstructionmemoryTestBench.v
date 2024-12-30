module InstructionMemoryTestBench;

    // Testbench signals
    reg [31:0] pcAddress; // Program Counter
    wire [31:0] instruction; // Instruction output

    // Instantiate the Instruction Memory module
    InstructionMemory uut (
        .pcAddress(pcAddress),
        .instruction(instruction)
    );

    // Test sequence
    initial begin
        // Open VCD file for GTKWave
        $dumpfile("InstructionMemoryTestBench.vcd");
        $dumpvars(0, InstructionMemoryTestBench);

        // Monitor signals in the simulation
        $monitor("Time = %0d, PC Address = %h, Instruction = %h", $time, pcAddress, instruction);

        // Test case 1: Access instruction at address 0
        pcAddress = 0;
        #10;

        // Test case 2: Access instruction at address 1
        pcAddress = 4;
        #10;

        // Test case 3: Access instruction at address 2
        pcAddress = 8;
        #10;

        // Test case 4: Access instruction at address 3
        pcAddress = 12;
        #10;

        // Test case 5: Access instruction at address 4
        pcAddress = 16;
        #10;

        // Test case 6: Access instruction at address 5
        pcAddress = 20;
        #10;

        $finish;
    end
endmodule
