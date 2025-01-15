// Instruction Memory module
// Group 06

module InstructionMemory (
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
    INSTRUCTIONS_MEM[8] <= 32'h00100113; // ADDI x2, x0, 1
    INSTRUCTIONS_MEM[12] <= 32'h002081B3; // ADD x3, x1, x2
    INSTRUCTIONS_MEM[16] <= 32'h00310133; // ADDI x2, x2, 3
    INSTRUCTIONS_MEM[20] <= 32'h4041A183; // SUB x3, x2, x1
end

// Read the Instruction from the Instruction Memory
assign INSTRUCTION = INSTRUCTIONS_MEM[ADDRESS];

endmodule

