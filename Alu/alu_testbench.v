`timescale 1ns / 1ps

`include "alu.v"

module alu_tb;

    // Inputs
    reg [31:0] DATA1;
    reg [31:0] DATA2;
    reg [5:0] ALU_OPERATION;

    // Outputs
    wire [31:0] RESULT;

    // Instantiate the ALU
    ALU uut (
        .DATA1(DATA1),
        .DATA2(DATA2),
        .ALU_OPERATION(ALU_OPERATION),
        .RESULT(RESULT)
    );

    initial begin
        // Initialize Inputs
        DATA1 = 0;
        DATA2 = 0;
        ALU_OPERATION = 0;

        // Wait for global reset
        #100;

        // Test AND operation
        DATA1 = 32'hA5A5A5A5;
        DATA2 = 32'h5A5A5A5A;
        ALU_OPERATION = 5'b00000;
        #10;
        $display("AND Result: %h", RESULT);

        // Test OR operation
        ALU_OPERATION = 5'b00001;
        #10;
        $display("OR Result: %h", RESULT);

        // Test ADD operation
        ALU_OPERATION = 5'b00010;
        #10;
        $display("ADD Result: %h", RESULT);

        // Test SUB operation
        ALU_OPERATION = 5'b00011;
        #10;
        $display("SUB Result: %h", RESULT);

        // Test left shift operation
        ALU_OPERATION = 5'b00100;
        #10;
        $display("Left Shift Result: %h", RESULT);

        // Test set less than operation
        ALU_OPERATION = 5'b00101;
        #10;
        $display("Set Less Than Result: %h", RESULT);

        // Test set less than unsigned operation
        ALU_OPERATION = 5'b00110;
        #10;
        $display("Set Less Than Unsigned Result: %h", RESULT);

        // Test XOR operation
        ALU_OPERATION = 5'b00111;
        #10;
        $display("XOR Result: %h", RESULT);

        // Test logical shift right operation
        ALU_OPERATION = 5'b01000;
        #10;
        $display("Logical Shift Right Result: %h", RESULT);

        // Test arithmetic shift right operation
        ALU_OPERATION = 5'b01001;
        #10;
        $display("Arithmetic Shift Right Result: %h", RESULT);

        // Finish simulation
        $finish;
    end

endmodule