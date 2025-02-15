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

    // R-type all instructions are tested
    // INSTRUCTIONS_MEM[0] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[4] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[8] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // ADDI
    // INSTRUCTIONS_MEM[12] <= 32'b000000000000_00000_000_00001_0010011; // ADDI x1, x0, 0
    // INSTRUCTIONS_MEM[16] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[20] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[24] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // ADDI
    // INSTRUCTIONS_MEM[28] <= 32'b000000000001_00000_000_00010_0010011; // ADDI x2, x0, 1
    // INSTRUCTIONS_MEM[32] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[36] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[40] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // ADD
    // INSTRUCTIONS_MEM[44] <= 32'b0000000_00010_00001_000_00011_0110011; // ADD x3, x1, x2
    // INSTRUCTIONS_MEM[48] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[52] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[56] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // ADDI
    // INSTRUCTIONS_MEM[60] <= 32'b000000000011_00010_000_00010_0010011; // ADDI x2, x2, 3
    // INSTRUCTIONS_MEM[64] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP) 
    // INSTRUCTIONS_MEM[68] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[72] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // SUB
    // INSTRUCTIONS_MEM[76] <= 32'b0100000_00010_00001_000_00011_0110011; // SUB x3, x1, x2
    // INSTRUCTIONS_MEM[80] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[84] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[88] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // SLL
    // INSTRUCTIONS_MEM[92] <= 32'b0000000_00010_00001_001_00011_0110011; // SLL x3, x1, x2
    // INSTRUCTIONS_MEM[96] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[100] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[104] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // SLT
    // INSTRUCTIONS_MEM[108] <= 32'b0000000_00010_00001_010_00011_0110011; // SLT x3, x1, x2
    // INSTRUCTIONS_MEM[112] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[116] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[120] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // SLTU
    // INSTRUCTIONS_MEM[124] <= 32'b0000000_00010_00001_011_00011_0110011; // SLTU x3, x1, x2
    // INSTRUCTIONS_MEM[128] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[132] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[136] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // XOR
    // INSTRUCTIONS_MEM[140] <= 32'b0000000_00010_00001_100_00011_0110011; // XOR x3, x1, x2
    // INSTRUCTIONS_MEM[144] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[148] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[152] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // SRL
    // INSTRUCTIONS_MEM[156] <= 32'b0000000_00010_00001_101_00011_0110011; // SRL x3, x1, x2
    // INSTRUCTIONS_MEM[160] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[164] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[168] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // SRA
    // INSTRUCTIONS_MEM[172] <= 32'b0100000_00010_00001_101_00011_0110011; // SRA x3, x1, x2
    // INSTRUCTIONS_MEM[176] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[180] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[184] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // OR
    // INSTRUCTIONS_MEM[188] <= 32'b0000000_00010_00001_110_00011_0110011; // OR x3, x1, x2
    // INSTRUCTIONS_MEM[192] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[196] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[200] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // // AND
    // INSTRUCTIONS_MEM[204] <= 32'b0000000_00010_00001_111_00011_0110011; // AND x3, x1, x2
    // INSTRUCTIONS_MEM[208] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[212] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // INSTRUCTIONS_MEM[216] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)

    // I-type all instructions
    INSTRUCTIONS_MEM[0] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[4] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[8] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // LB
    INSTRUCTIONS_MEM[12] <= 32'b000000000001_00000_000_00001_0000011; // LB x1, 1(x0)
    INSTRUCTIONS_MEM[16] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[20] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[24] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // LH
    INSTRUCTIONS_MEM[28] <= 32'b000000000010_00000_001_00010_0000011; // LH x2, 2(x0)
    INSTRUCTIONS_MEM[32] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[36] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[40] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // LW
    INSTRUCTIONS_MEM[44] <= 32'b000000000011_00000_010_00011_0000011; // LW x3, 3(x0)
    INSTRUCTIONS_MEM[48] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[52] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[56] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // LBU
    INSTRUCTIONS_MEM[60] <= 32'b000000000100_00000_100_00100_0000011; // LBU x4, 4(x0)
    INSTRUCTIONS_MEM[64] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[68] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[72] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // LHU
    INSTRUCTIONS_MEM[76] <= 32'b000000000110_00000_101_00110_0000011; // LHU x6, 6(x0)
    INSTRUCTIONS_MEM[80] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[84] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[88] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // ADDI
    INSTRUCTIONS_MEM[92] <= 32'b000000000001_00000_000_00001_0010011; // ADDI x1, x0, 1
    INSTRUCTIONS_MEM[96] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[100] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[104] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // SLTI
    INSTRUCTIONS_MEM[108] <= 32'b000000000010_00001_010_00011_0010011; // SLTI x3, x1, 2
    INSTRUCTIONS_MEM[112] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[116] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[120] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // SLTIU
    INSTRUCTIONS_MEM[124] <= 32'b000000000011_00001_011_00011_0010011; // SLTIU x3, x1, 3
    INSTRUCTIONS_MEM[128] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[132] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[136] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // XORI
    INSTRUCTIONS_MEM[140] <= 32'b000000000100_00001_100_00010_0010011; // XORI x2, x1, 4
    INSTRUCTIONS_MEM[144] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[148] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[152] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // ORI
    INSTRUCTIONS_MEM[156] <= 32'b000000000110_00001_110_00011_0010011; // ORI x3, x1, 6
    INSTRUCTIONS_MEM[160] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[164] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[168] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // ANDI
    INSTRUCTIONS_MEM[172] <= 32'b000000000111_00001_111_00010_0010011; // ANDI x2, x1, 7
    INSTRUCTIONS_MEM[176] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[180] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[184] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // SLLI
    INSTRUCTIONS_MEM[188] <= 32'b0000000_00001_00001_001_00011_0010011; // SLLI x3, x1, 1
    INSTRUCTIONS_MEM[192] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[196] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[200] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // SRLI
    INSTRUCTIONS_MEM[204] <= 32'b0000000_00010_00001_101_00010_0010011; // SRLI x2, x1, 2
    INSTRUCTIONS_MEM[208] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[212] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[216] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // SRAI
    INSTRUCTIONS_MEM[220] <= 32'b0100000_00100_00001_101_00011_0010011; // SRAI x3, x1, 4
    INSTRUCTIONS_MEM[224] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[228] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[232] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    // JALR
    INSTRUCTIONS_MEM[236] <= 32'b000000001011_00001_000_00010_1100111; // JALR x2, x1, 11 (x0 = PC + 4)
    INSTRUCTIONS_MEM[240] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[244] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)
    INSTRUCTIONS_MEM[248] <= 32'b000000000000_00000_000_00000_0010011; // ADDI x0, x0, 0 (NOP)

    // Jump 

end

// Read the Instruction from the Instruction Memory
assign INSTRUCTION = INSTRUCTIONS_MEM[ADDRESS];

endmodule