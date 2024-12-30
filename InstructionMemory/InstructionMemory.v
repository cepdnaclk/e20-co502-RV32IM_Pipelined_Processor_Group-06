//Instrunction Memroy module
//Group 06

module InstructionMemory(
    input wire [31:0] pcAddress, //Program Counter
    output wire [31:0] instruction //Instrunction
);

//Instrunction Memory size
parameter memSize = 1023;
reg [31:0] instructionsMemory [0:memSize]; 

//Instrunction Memory - We use [31:0] because it shows [MSB:LSB] ordder. 
//so the fisrt bit numbered as 31 and the last bit numbered as 0 in the 32 bit Instrunction.

//Initialize the Instrunction Memory
initial begin 
    //load the instructions to memory
    instructionsMemory[0] <= 32'h00000013; // ADDI x0, x0, 0 (NOP)
    instructionsMemory[4] <= 32'h00000093; // ADDI x1, x0, 0
    instructionsMemory[8] <= 32'h00100113; // ADDI x2, x0, 1
    instructionsMemory[12] <= 32'h002081B3; // ADD x3, x1, x2
    instructionsMemory[16] <= 32'h00310133; // ADDI x2, x2, 3
    instructionsMemory[20] <= 32'h4041A183; // SUB x3, x2, x1
end

//Read the Instrunction from the Instrunction Memory
assign instruction = instructionsMemory[pcAddress];
endmodule

