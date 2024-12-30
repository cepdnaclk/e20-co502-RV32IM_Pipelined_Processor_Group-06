//Instrunction Memroy module
//Group 06

module InstrunctionMemory(
    input wire [31:0] pcAddress, //Program Counter
    output wire [31:0] instrunction //Instrunction
);

//Instrunction Memory size
parameter memSize = 1023;
reg [31:0] instructionsMemory [0:MemSize]; 

//Instrunction Memory - We use [31:0] because it shows [MSB:LSB] ordder. 
//so the fisrt bit numbered as 31 and the last bit numbered as 0 in the 32 bit Instrunction.

//Initialize the Instrunction Memory
initial begin 
    //load the instructions to memory
    instructionsMemory[0] <= 32'h00000000; //NOP
    instructionsMemory[1] <= 32'h00000000; //NOP
    instructionsMemory[2] <= 32'h00000000; //NOP
    instructionsMemory[3] <= 32'h00000000; //NOP
end

//Read the Instrunction from the Instrunction Memory
assign instruction = instructionsMemory[pcAddress];
endmodule

