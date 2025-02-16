module FORWARDING_UNIT_TB;

    // Testbench signals
    reg [4:0] ADDR1;
    reg [4:0] ADDR2;
    reg [4:0] STAGE_RD;
    wire [1:0] FORWARD_EN;

    // Instantiate the Unit Under Test (UUT)
    FORWARDING_UNIT uut (
        .ADDR1(ADDR1),
        .ADDR2(ADDR2),
        .STAGE_RD(STAGE_RD),
        .FORWARD_EN(FORWARD_EN)
    );

    initial begin
        // Open VCD file for GTKWave
        $dumpfile("forwarding_unit_tb.vcd");
        $dumpvars(0, FORWARDING_UNIT_TB);

        // Initialize Inputs
        ADDR1 = 0;
        ADDR2 = 0;
        STAGE_RD = 0;

        // Wait for global reset
        #10;

        // Test case 1: No forwarding
        ADDR1 = 5'b00001;
        ADDR2 = 5'b00010;
        STAGE_RD = 5'b00000;
        #10;
        $display("Test case 1: FORWARD_EN = %b", FORWARD_EN);

        // Test case 2: Forward to both ADDR1 and ADDR2
        ADDR1 = 5'b00001;
        ADDR2 = 5'b00001;
        STAGE_RD = 5'b00001;
        #10;
        $display("Test case 2: FORWARD_EN = %b", FORWARD_EN);

        // Test case 3: Forward to ADDR1 only
        ADDR1 = 5'b00001;
        ADDR2 = 5'b00010;
        STAGE_RD = 5'b00001;
        #10;
        $display("Test case 3: FORWARD_EN = %b", FORWARD_EN);

        // Test case 4: Forward to ADDR2 only
        ADDR1 = 5'b00010;
        ADDR2 = 5'b00001;
        STAGE_RD = 5'b00001;
        #10;
        $display("Test case 4: FORWARD_EN = %b", FORWARD_EN);

        // Finish simulation
        $finish;
    end

endmodule


// ## Running the Forwarding Unit Test Bench

// To run the test bench for the `FORWARDING_UNIT` module, follow these steps:

// 1. Ensure you have a Verilog simulator installed, such as Icarus Verilog.
// 2. Open a terminal and navigate to the `ForwardingUnit` directory:
//     ```sh
//     cd /D:/My projects/e20-co502-RV32IM_Pipelined_Processor_Group-06/ForwardingUnit
//     ```
// 3. Compile the Verilog files using the simulator:
//     ```sh
//     iverilog -o forwarding_unit_tb forwarding_unit_tb.v forwarding_unit.v
//     ```
// 4. Run the compiled simulation:
//     ```sh
//     vvp forwarding_unit_tb
//     ```
// 5. To view the waveform, open the generated `forwarding_unit_tb.vcd` file with GTKWave:
//     ```sh
//     gtkwave forwarding_unit_tb.vcd
//     ```

// This will allow you to verify the functionality of the `FORWARDING_UNIT` module.