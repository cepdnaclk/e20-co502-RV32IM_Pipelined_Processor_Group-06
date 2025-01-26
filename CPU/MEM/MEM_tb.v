`timescale 1ns / 1ps

module MEM_tb;
    // Inputs
    reg CLK;
    reg RST;
    reg [2:0] EX_FUNC3;
    reg EX_WRITE_ENABLE;
    reg EX_DATA_MEM_SELECT;
    reg EX_MEM_WRITE;
    reg EX_MEM_READ;
    reg [31:0] EX_JAL_SELECTED;
    reg [31:0] EX_READ_DATA2;
    reg [4:0] EX_RD;

    // Outputs
    wire [2:0] MEM_FUNC3;
    wire MEM_WRITE_ENABLE;
    wire MEM_DATA_MEM_SELECT;
    wire [31:0] MEM_JAL_SELECTED;
    wire [31:0] MEM_DATA_OUT;
    wire [4:0] MEM_RD;

    // Instantiate the Unit Under Test (UUT)
    MEM uut (
        .CLK(CLK),
        .RST(RST),
        .EX_FUNC3(EX_FUNC3),
        .EX_WRITE_ENABLE(EX_WRITE_ENABLE),
        .EX_DATA_MEM_SELECT(EX_DATA_MEM_SELECT),
        .EX_MEM_WRITE(EX_MEM_WRITE),
        .EX_MEM_READ(EX_MEM_READ),
        .EX_JAL_SELECTED(EX_JAL_SELECTED),
        .EX_READ_DATA2(EX_READ_DATA2),
        .EX_RD(EX_RD),
        .MEM_FUNC3(MEM_FUNC3),
        .MEM_WRITE_ENABLE(MEM_WRITE_ENABLE),
        .MEM_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT),
        .MEM_JAL_SELECTED(MEM_JAL_SELECTED),
        .MEM_DATA_OUT(MEM_DATA_OUT),
        .MEM_RD(MEM_RD)
    );

    initial begin
        // Initialize Inputs
        CLK = 0;
        RST = 1;
        EX_FUNC3 = 0;
        EX_WRITE_ENABLE = 0;
        EX_DATA_MEM_SELECT = 0;
        EX_MEM_WRITE = 0;
        EX_MEM_READ = 0;
        EX_JAL_SELECTED = 0;
        EX_READ_DATA2 = 0;
        EX_RD = 0;

        // Wait for global reset
        #10;
        RST = 0;

        // Test write operation_____________________________________________________ Test 1 
        EX_JAL_SELECTED = 32'h00000004;
        EX_READ_DATA2 = 32'hDEADBEEF;
        EX_MEM_WRITE = 1;
        EX_FUNC3 = 3'b010; // SW
        #10;
        EX_MEM_WRITE = 0;

        // Test read operation
        EX_MEM_READ = 1;
        #10;
        EX_MEM_READ = 0;

        // Test another write operation____________________________________________ Test 2
        EX_JAL_SELECTED = 32'h00000008;
        EX_READ_DATA2 = 32'hCAFEBABE;
        EX_MEM_WRITE = 1;
        EX_FUNC3 = 3'b010; // SW
        #10;
        EX_MEM_WRITE = 0;

        // Test another read operation
        EX_MEM_READ = 1;
        #10;
        EX_MEM_READ = 0;

        // Test half-word write operation___________________________________________ Test 3
        EX_JAL_SELECTED = 32'h0000000C;
        EX_READ_DATA2 = 32'h00C0BEEF;
        EX_MEM_WRITE = 1;
        EX_FUNC3 = 3'b001; // SH
        #10;
        EX_MEM_WRITE = 0;

        // Test half-word read operation
        EX_MEM_READ = 1;
        EX_FUNC3 = 3'b001; // LH
        #10;
        EX_MEM_READ = 0;

        // Test byte write operation_______________________________________________ Test 4
        EX_JAL_SELECTED = 32'h00000010;
        EX_READ_DATA2 = 32'h000000EF;
        EX_MEM_WRITE = 1;
        EX_FUNC3 = 3'b000; // SB
        #10;
        EX_MEM_WRITE = 0;

        // Test byte read operation
        EX_MEM_READ = 1;
        EX_FUNC3 = 3'b000; // LB
        #10;
        EX_MEM_READ = 0;

        // Test half-word write operation___________________________________________ Test 5
        EX_JAL_SELECTED = 32'h00000014;
        EX_READ_DATA2 = 32'h0000BEEF;
        EX_MEM_WRITE = 1;
        EX_FUNC3 = 3'b001; // SH
        #10;
        EX_MEM_WRITE = 0;

        // Test half-word read operation
        EX_MEM_READ = 1;
        EX_FUNC3 = 3'b001; // LH
        #10;
        EX_MEM_READ = 0;

        // Test word write operation_______________________________________________ Test 6
        EX_JAL_SELECTED = 32'h00000018;
        EX_READ_DATA2 = 32'hDEADBEEF;
        EX_MEM_WRITE = 1;
        EX_FUNC3 = 3'b010; // SW
        #10;
        EX_MEM_WRITE = 0;

        // Test word read operation
        EX_MEM_READ = 1;
        EX_FUNC3 = 3'b010; // LW
        #10;
        EX_MEM_READ = 0;

        // Test word read operation_________________________________________________ Test 7
        EX_JAL_SELECTED = 32'h00000008;
        EX_MEM_READ = 1;
        EX_FUNC3 = 3'b001; // LH
        #10;
        EX_MEM_READ = 0;
        
        // Test word read operation_________________________________________________ Test 7
        EX_JAL_SELECTED = 32'h00000008;
        EX_MEM_READ = 1;
        EX_FUNC3 = 3'b001; // LH
        #10;
        EX_MEM_READ = 0;

        
        // Finish simulation
        $finish;
    end

    // Clock generation
    always #5 CLK = ~CLK;

    // Dump waveform
    initial begin
        $dumpfile("MEM_tb.vcd");
        $dumpvars(0, MEM_tb);
    end

endmodule


// Commands to run simulation:
// iverilog -o MEM_tb.vvp MEM.v MEM_tb.v ../../DataMemory/DataMemory.v
// vvp MEM_tb.vvp
// gtkwave MEM_tb.vcd 