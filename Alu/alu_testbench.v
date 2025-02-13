`timescale 1ns / 1ps

`include "alu.v"

module alu_tb;

    // Inputs
    reg [31:0] DATA1;
    reg [31:0] DATA2;
    reg [4:0] ALU_OPERATION;

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

        // Wait 100 ns for global reset to finish
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
        DATA1 = 32'h00000010;
        DATA2 = 32'h00000020;
        ALU_OPERATION = 5'b00010;
        #10;
        $display("ADD Result: %h", RESULT);

        // Test SUB operation
        ALU_OPERATION = 5'b00011;
        #10;
        $display("SUB Result: %h", RESULT);

        // Test left shift operation
        DATA1 = 32'h00000001;
        DATA2 = 32'h00000002;
        ALU_OPERATION = 5'b00100;
        #10;
        $display("Left Shift Result: %h", RESULT);

        // Test set less than operation
        DATA1 = 32'h00000001;
        DATA2 = 32'h00000002;
        ALU_OPERATION = 5'b00101;
        #10;
        $display("Set Less Than Result: %h", RESULT);

        // Test set less than unsigned operation
        DATA1 = 32'hFFFFFFFF;
        DATA2 = 32'h00000001;
        ALU_OPERATION = 5'b00110;
        #10;
        $display("Set Less Than Unsigned Result: %h", RESULT);

        // Test XOR operation
        DATA1 = 32'hA5A5A5A5;
        DATA2 = 32'h5A5A5A5A;
        ALU_OPERATION = 5'b00111;
        #10;
        $display("XOR Result: %h", RESULT);

        // Test logical shift right operation
        DATA1 = 32'h80000000;
        DATA2 = 32'h00000001;
        ALU_OPERATION = 5'b01000;
        #10;
        $display("Logical Shift Right Result: %h", RESULT);

        // Test arithmetic shift right operation
        ALU_OPERATION = 5'b01001;
        #10;
        $display("Arithmetic Shift Right Result: %h", RESULT);

        // Test multiplication operation
        DATA1 = 32'h00000010;
        DATA2 = 32'h00000010;
        ALU_OPERATION = 5'b01010;
        #10;
        $display("Multiplication Result: %h", RESULT);

        // Test MULH operation
        DATA1 = 32'h80000000;
        DATA2 = 32'h00000002;
        ALU_OPERATION = 5'b01011;
        #10;
        $display("MULH Result: %h", RESULT);

        // Test MULHSU operation
        ALU_OPERATION = 5'b01100;
        #10;
        $display("MULHSU Result: %h", RESULT);

        // Test MULHU operation
        ALU_OPERATION = 5'b01101;
        #10;
        $display("MULHU Result: %h", RESULT);

        // Test DIV operation
        DATA1 = 32'h00000010;
        DATA2 = 32'h00000002;
        ALU_OPERATION = 5'b01110;
        #10;
        $display("DIV Result: %h", RESULT);

        // Test DIVU operation
        ALU_OPERATION = 5'b01111;
        #10;
        $display("DIVU Result: %h", RESULT);

        // Test REM operation
        DATA1 = 32'h00000011;
        DATA2 = 32'h00000002;
        ALU_OPERATION = 5'b10000;
        #10;
        $display("REM Result: %h", RESULT);

        // Test REMU operation
        ALU_OPERATION = 5'b10001;
        #10;
        $display("REMU Result: %h", RESULT);

        $stop;
    end
      
endmodule