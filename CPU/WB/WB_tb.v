`timescale 1ns / 1ps

module WB_tb;
    // Inputs
    reg CLK;
    reg RST;
    reg [2:0] MEM_FUNC3;
    reg MEM_WRITE_ENABLE;
    reg MEM_DATA_MEM_SELECT;
    reg [31:0] MEM_JAL_SELECTED;
    reg [31:0] MEM_DATA_OUT;
    reg [4:0] MEM_RD;

    // Outputs
    wire WB_WRITE_ENABLE;
    wire [31:0] WB_WRITE_DATA;
    wire [4:0] WB_RD;

    // Instantiate the Unit Under Test (UUT)
    WB uut (
        .CLK(CLK),
        .RST(RST),
        .MEM_FUNC3(MEM_FUNC3),
        .MEM_WRITE_ENABLE(MEM_WRITE_ENABLE),
        .MEM_DATA_MEM_SELECT(MEM_DATA_MEM_SELECT),
        .MEM_JAL_SELECTED(MEM_JAL_SELECTED),
        .MEM_DATA_OUT(MEM_DATA_OUT),
        .MEM_RD(MEM_RD),
        .WB_WRITE_ENABLE(WB_WRITE_ENABLE),
        .WB_WRITE_DATA(WB_WRITE_DATA),
        .WB_RD(WB_RD)
    );

    initial begin
        // Initialize Inputs
        CLK = 0;
        RST = 1;
        MEM_FUNC3 = 0;
        MEM_WRITE_ENABLE = 0;
        MEM_DATA_MEM_SELECT = 0;
        MEM_JAL_SELECTED = 0;
        MEM_DATA_OUT = 0;
        MEM_RD = 0;

        // Wait for global reset
        #10;
        RST = 0;

        // Test case 1: Write enable with data memory select (LW)
        MEM_FUNC3 = 3'b010; // LW
        MEM_WRITE_ENABLE = 1;
        MEM_DATA_MEM_SELECT = 1;
        MEM_JAL_SELECTED = 32'h00000004;
        MEM_DATA_OUT = 32'hDEADBEEF;
        MEM_RD = 5'b00001;
        #10;

        // Test case 2: Write enable with JAL selected
        MEM_DATA_MEM_SELECT = 0;
        MEM_JAL_SELECTED = 32'hCAFEBABE;
        #10;

        // Test case 3: Write disable
        MEM_WRITE_ENABLE = 0;
        #10;

        // Test case 4: Load Byte (LB)
        MEM_FUNC3 = 3'b000; // LB
        MEM_WRITE_ENABLE = 1;
        MEM_DATA_MEM_SELECT = 1;
        MEM_DATA_OUT = 32'h000A00FA;
        MEM_RD = 5'b00010;
        #10;

        // Test case 5: Load Halfword (LH)
        MEM_FUNC3 = 3'b001; // LH
        MEM_WRITE_ENABLE = 1;
        MEM_DATA_MEM_SELECT = 1;
        MEM_DATA_OUT = 32'h0F00FAFF;
        MEM_RD = 5'b00011;
        #10;

        // Test case 6: Load Byte Unsigned (LBU)
        MEM_FUNC3 = 3'b100; // LBU
        MEM_WRITE_ENABLE = 1;
        MEM_DATA_MEM_SELECT = 1;
        MEM_DATA_OUT = 32'h000000FF;
        MEM_RD = 5'b00100;
        #10;

        // Test case 7: Load Halfword Unsigned (LHU)
        MEM_FUNC3 = 3'b101; // LHU
        MEM_WRITE_ENABLE = 1;
        MEM_DATA_MEM_SELECT = 1;
        MEM_DATA_OUT = 32'h0000FFFF;
        MEM_RD = 5'b00101;
        #10;

        // Finish simulation
        $finish;
    end

    // Clock generation
    always #5 CLK = ~CLK;

    // Dump waveform
    initial begin
        $dumpfile("WB_tb.vcd");
        $dumpvars(0, WB_tb);
    end

endmodule

// command to run simulation
// iverilog -o WB_tb.vvp WB_tb.v WB.v ../../LoadProcessingUnit/LOAD_PROCESSING_UNIT.v ../../MUX/MUX.v
// vvp WB_tb.vvp
// gtkwave WB_tb.vcd