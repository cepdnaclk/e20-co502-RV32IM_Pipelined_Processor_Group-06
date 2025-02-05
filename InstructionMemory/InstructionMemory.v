// Instruction Memory module
// Group 06

module INSTRUCTION_MEMORY (
    input wire [31:0] ADDRESS, // Program Counter
    output wire [31:0] INSTRUCTION // Instruction
);

// Instruction Memory size
parameter MEM_SIZE = 1024;
reg [31:0] INSTRUCTIONS_MEM[0:MEM_SIZE-1];

// Initialize the Instruction Memory
initial begin 
    // Load the instructions to memory
    INSTRUCTIONS_MEM[0] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[4] <= 32'h00000093; // ADDI x1, x0, 0
    INSTRUCTIONS_MEM[8] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[12] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[16] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[20] <= 32'h00100113; // ADDI x2, x0, 1
    INSTRUCTIONS_MEM[24] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[28] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[32] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[36] <= 32'h002081B3; // ADD x3, x1, x2
    INSTRUCTIONS_MEM[40] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[44] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[48] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[52] <= 32'h00310133; // ADDI x2, x2, 3
    INSTRUCTIONS_MEM[56] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[60] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[64] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[68] <= 32'h4041A183; // SUB x3, x2, x1
    INSTRUCTIONS_MEM[72] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[76] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[80] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[84] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[88] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[92] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
end

// Read the Instruction from the Instruction Memory
assign INSTRUCTION = INSTRUCTIONS_MEM[ADDRESS];

endmodule



// INSTRUCTIONS_MEM[0] <= 32'b00000000000000000000000000010011; // ADDI x0, x0, 0 (NOP)
// INSTRUCTIONS_MEM[4] <= 32'b00000000000000000000000010010011; // ADDI x1, x0, 0

                           //IMM           rs1   func3 rd  opcode
// INSTRUCTIONS_MEM[8] <= 32'b000000000001_00000_000_00010_0010011; // ADDI x2, x0, 1


                            //FUNC7    rs2   rs1   FUNC3 rd  opcode
// INSTRUCTIONS_MEM[12] <= 32'b0000000_00010_00001_000_00011_0110011; // ADD x3, x1, x2


// INSTRUCTIONS_MEM[16] <= 32'b00000000001100010000000100110011; // ADDI x2, x2, 3

                            //FUNC7    rs2   rs1   FUNC3 rd  opcode
// INSTRUCTIONS_MEM[20] <= 32'b0100000_00100_00011_010_00011_0000011; // SUB x3, x2, x1