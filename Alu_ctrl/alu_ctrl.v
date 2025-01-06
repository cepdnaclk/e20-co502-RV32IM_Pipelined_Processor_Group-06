module (FUNC3, FUNC7, ALUOP, ALU_CTRL);

    input [6:0] FUNC7;
    input [2:0] FUNC3;
    input [2:0] ALUOP;

    output reg [3:0] ALU_CTRL;

    always @(FUNC3, FUNC7, ALUOP) begin
        case (ALUOP);
            3'b000: // R type instructions
                case ({FUNC3, FUNC7});
                    10'b000_0000000: ALU_CTRL = 5'b00010; //ADD
                    10'b000_0100000: ALU_CTRL = 5'b00011; //SUB
                    10'b111_0000000: ALU_CTRL = 5'b00000; //AND
                    10'b110_0000000: ALU_CTRL = 5'b00001; //OR
                    10'b001_0000000: ALU_CTRL = 5'b00100; //SLL
                    10'b010_0000000: ALU_CTRL = 5'b00101; //SLT
                    10'b011_0000000: ALU_CTRL = 5'b00110; //SLTU
                    10'b100_0000000: ALU_CTRL = 5'b00111; //XOR
                    10'b101_0000000: ALU_CTRL = 5'b01000; //SRL
                    10'b101_0100000: ALU_CTRL = 5'b01001; //SRA
                endcase
        endcase
            3'b001: //

    end
endmodule