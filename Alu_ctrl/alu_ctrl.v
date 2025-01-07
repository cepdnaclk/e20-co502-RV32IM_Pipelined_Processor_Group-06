module ALUControl(
    input [6:0] FUNC7,
    input [2:0] FUNC3,
    input [2:0] ALUOP,
    output reg [3:0] ALU_CTRL
);

    always @(*) begin
        case (ALUOP)
            3'b000: // R-type instructions (opcode: 0110011)
                case ({FUNC3, FUNC7})
                    10'b000_0000000: ALU_CTRL = 4'b0010; // ADD
                    10'b000_0100000: ALU_CTRL = 4'b0011; // SUB
                    10'b111_0000000: ALU_CTRL = 4'b0000; // AND
                    10'b110_0000000: ALU_CTRL = 4'b0001; // OR
                    10'b001_0000000: ALU_CTRL = 4'b0100; // SLL
                    10'b010_0000000: ALU_CTRL = 4'b0101; // SLT
                    10'b011_0000000: ALU_CTRL = 4'b0110; // SLTU
                    10'b100_0000000: ALU_CTRL = 4'b0111; // XOR
                    10'b101_0000000: ALU_CTRL = 4'b1000; // SRL
                    10'b101_0100000: ALU_CTRL = 4'b1001; // SRA
                    default: ALU_CTRL = 4'b1111; // Invalid case
                endcase

            3'b001: // I-type instructions (opcode: 0000011)
                ALU_CTRL = 4'b0010; // ADD for load instructions

            3'b010: // JALR instruction (opcode: 1100111)
                ALU_CTRL = 4'b0010; // ADD for calculating the target address

            3'b011: // Immediate operation instructions
                case (FUNC3)
                    3'b000: ALU_CTRL = 4'b0010; // ADDI
                    3'b010: ALU_CTRL = 4'b0101; // SLTI
                    3'b011: ALU_CTRL = 4'b0110; // SLTIU
                    3'b100: ALU_CTRL = 4'b0111; // XORI
                    3'b110: ALU_CTRL = 4'b0001; // ORI
                    3'b111: ALU_CTRL = 4'b0000; // ANDI
                    3'b001: // SLLI
                        if (FUNC7 == 7'b0000000)
                            ALU_CTRL = 4'b0100;
                        else
                            ALU_CTRL = 4'b1111; // Invalid
                    3'b101: // SRLI/SRAI
                        if (FUNC7 == 7'b0000000)
                            ALU_CTRL = 4'b1000; // SRLI
                        else if (FUNC7 == 7'b0100000)
                            ALU_CTRL = 4'b1001; // SRAI
                        else
                            ALU_CTRL = 4'b1111; // Invalid
                    default: ALU_CTRL = 4'b1111; // Invalid case
                endcase

            default: ALU_CTRL = 4'b1111; // Invalid ALUOP
        endcase
    end

endmodule
