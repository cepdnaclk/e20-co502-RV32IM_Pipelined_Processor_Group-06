`timescale 1ns / 1ps
`include "forwarding_control_unit.v"

module FORWARDING_CONTROL_UNIT_tb;

    // Inputs
    reg [1:0] WB_FORWARD_EN;
    reg [1:0] MEM_FORWARD_EN;
    reg [31:0] WB_RD_DATA;
    reg [31:0] MEM_RD_DATA;

    // Outputs
    wire OUT1_FORWARD_EN;
    wire OUT2_FORWARD_EN;
    wire [31:0] OUT1_FORWARD_DATA;
    wire [31:0] OUT2_FORWARD_DATA;

    // Instantiate the Unit Under Test (UUT)
    FORWARDING_CONTROL_UNIT uut (
        .WB_FORWARD_EN(WB_FORWARD_EN),
        .MEM_FORWARD_EN(MEM_FORWARD_EN),
        .WB_RD_DATA(WB_RD_DATA),
        .MEM_RD_DATA(MEM_RD_DATA),
        .OUT1_FORWARD_EN(OUT1_FORWARD_EN),
        .OUT2_FORWARD_EN(OUT2_FORWARD_EN),
        .OUT1_FORWARD_DATA(OUT1_FORWARD_DATA),
        .OUT2_FORWARD_DATA(OUT2_FORWARD_DATA)
    );

    initial begin
        // Initialize Inputs
        WB_FORWARD_EN = 2'b00;
        MEM_FORWARD_EN = 2'b00;
        WB_RD_DATA = 32'hAAAAAAAA;
        MEM_RD_DATA = 32'h55555555;

        // Wait for global reset
        #10;

        // Test case 1: No forwarding
        WB_FORWARD_EN = 2'b00;
        MEM_FORWARD_EN = 2'b00;
        #10;

        // Test case 2: Forward from MEM to OUT1
        WB_FORWARD_EN = 2'b00;
        MEM_FORWARD_EN = 2'b01;
        #10;

        // Test case 3: Forward from MEM to OUT2
        WB_FORWARD_EN = 2'b00;
        MEM_FORWARD_EN = 2'b10;
        #10;

        // Test case 4: Forward from MEM to both OUT1 and OUT2
        WB_FORWARD_EN = 2'b00;
        MEM_FORWARD_EN = 2'b11;
        #10;

        // Test case 5: Forward from WB to OUT1
        WB_FORWARD_EN = 2'b01;
        MEM_FORWARD_EN = 2'b00;
        #10;

        // Test case 6: Forward from WB to OUT1 and MEM to OUT2
        WB_FORWARD_EN = 2'b01;
        MEM_FORWARD_EN = 2'b01;
        #10;

        // Test case 7: Forward from WB to OUT1 and MEM to OUT2
        WB_FORWARD_EN = 2'b01;
        MEM_FORWARD_EN = 2'b10;
        #10;

        // Test case 8: Forward from WB to OUT1 and MEM to OUT2
        WB_FORWARD_EN = 2'b01;
        MEM_FORWARD_EN = 2'b11;
        #10;

        // Test case 9: Forward from WB to OUT2
        WB_FORWARD_EN = 2'b10;
        MEM_FORWARD_EN = 2'b00;
        #10;

        // Test case 10: Forward from MEM to OUT1 and WB to OUT2
        WB_FORWARD_EN = 2'b10;
        MEM_FORWARD_EN = 2'b01;
        #10;

        // Test case 11: Forward from WB to OUT2
        WB_FORWARD_EN = 2'b10;
        MEM_FORWARD_EN = 2'b10;
        #10;

        // Test case 12: Forward from MEM to OUT1 and WB to OUT2
        WB_FORWARD_EN = 2'b10;
        MEM_FORWARD_EN = 2'b11;
        #10;

        // Test case 13: Forward from WB to both OUT1 and OUT2
        WB_FORWARD_EN = 2'b11;
        MEM_FORWARD_EN = 2'b00;
        #10;

        // Test case 14: Forward from WB to OUT1 and MEM to OUT2
        WB_FORWARD_EN = 2'b11;
        MEM_FORWARD_EN = 2'b01;
        #10;

        // Test case 15: Forward from WB to both OUT1 and OUT2
        WB_FORWARD_EN = 2'b11;
        MEM_FORWARD_EN = 2'b10;
        #10;

        // Test case 16: Forward from WB to both OUT1 and OUT2
        WB_FORWARD_EN = 2'b11;
        MEM_FORWARD_EN = 2'b11;
        #10;

        // Finish simulation
        $finish;
    end

endmodule