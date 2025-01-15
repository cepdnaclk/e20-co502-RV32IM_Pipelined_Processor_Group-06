`timescale 1ns / 1ps

module imm_pick_tb;
    // Inputs
    reg [31:0] INSTRUCTION;
    reg [2:0] IMM_PICK;

    // Outputs
    wire [31:0] IMMIDIATE;

    // Instantiate the Unit Under Test (UUT)
    IMM_PICK uut (
        .INSTRUCTION(INSTRUCTION), 
        .IMM_PICK(IMM_PICK), 
        .IMMIDIATE(IMMIDIATE)
    );

    initial begin
        // Open VCD file for GTKWave
        $dumpfile("imm_pick_tb.vcd");
        $dumpvars(0, imm_pick_tb);

        // Initialize Inputs
        INSTRUCTION = 32'b0;
        IMM_PICK = 3'b0;

        // Wait 100 ns for global reset to finish
        #10;

        // Test I-type IMMIDIATE 1
        INSTRUCTION = 32'b11111111111100000000000000000000; // (result - 11111111111111111111111111111111)
        IMM_PICK = 3'b000;
        #10;

        // Test I-type IMMIDIATE 2
        INSTRUCTION = 32'b00000000000011111111111111111111; // (result - 00000000000000000000000000000000)
        IMM_PICK = 3'b000;
        #10;

        // Test S-type IMMIDIATE 1
        INSTRUCTION = 32'b11111110000000000000111110000000; // (result - 11111111111111111111111111111111)
        IMM_PICK = 3'b001;
        #10;

        // Test S-type IMMIDIATE 2
        INSTRUCTION = 32'b00000001111111111111000001111111; // (result - 00000000000000000000000000000000)
        IMM_PICK = 3'b001;
        #10;

        // Test U-type IMMIDIATE 1
        INSTRUCTION = 32'b11111111111111111111000000000000; // (result - 11111111111111111111000000000000)
        IMM_PICK = 3'b010;
        #10;

        // Test U-type IMMIDIATE 2
        INSTRUCTION = 32'b00000000000000000000111111111111; // (result - 00000000000000000000000000000000)
        IMM_PICK = 3'b010;
        #10;

        // Test B-type IMMIDIATE
        INSTRUCTION = 32'b11111110000000000000111110000000; // (result - 11111111111111111111111111111110)
        IMM_PICK = 3'b011;
        #10;

        // Test B-type IMMIDIATE
        INSTRUCTION = 32'b00000001111111111111000001111111; // (result - 00000000000000000000000000000000)
        IMM_PICK = 3'b011;
        #10;

        // Test J-type IMMIDIATE
        INSTRUCTION = 32'h87654321; // Example INSTRUCTION
        IMM_PICK = 3'b100;
        #10;

        // Add more test cases as needed

        $finish;
    end
      
endmodule
