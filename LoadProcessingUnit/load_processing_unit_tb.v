`timescale 1ns / 1ps

module load_processing_unit_tb;
    // Inputs
    reg [2:0] FUNC3;
    reg [31:0] DATA_OUT;

    // Outputs
    wire [31:0] PROCESSED_DATA_OUT;

    // Instantiate the Unit Under Test (UUT)
    load_processing_unit uut (
        .FUNC3(FUNC3),
        .DATA_OUT(DATA_OUT),
        .PROCESSED_DATA_OUT(PROCESSED_DATA_OUT)
    );

    initial begin
        // Open VCD file for GTKWave
        $dumpfile("load_processing_unit_tb.vcd");
        $dumpvars(0, load_processing_unit_tb);

        // Initialize Inputs
        FUNC3 = 3'b000;
        DATA_OUT = 32'h12345678;

        // Test LB (Load Byte)
        #10 FUNC3 = 3'b000; DATA_OUT = 32'b11111111111111111111111111111111; #10;

        // Test LH (Load Halfword)
        #10 FUNC3 = 3'b001; DATA_OUT = 32'b11111111111111111111111111111111; #10;

        // Test LW (Load Word)
        #10 FUNC3 = 3'b010; DATA_OUT = 32'b11111111111111111111111111111111; #10;

        // Test LBU (Load Byte Unsigned)
        #10 FUNC3 = 3'b100; DATA_OUT = 32'b11111111111111111111111111111111; #10;

        // Test LHU (Load Halfword Unsigned)
        #10 FUNC3 = 3'b101; DATA_OUT = 32'b11111111111111111111111111111111; #10;

        // Finish the simulation
        $finish;
    end
      
endmodule
