module (FUNC3, FUNC7, ALUOP);

    input [6:0] FUNC7;
    input [2:0] FUNC3;
    output reg [3:0] ALUOP;

    always @(FUNC3, FUNC7) begin

        case ({FUNC3, FUNC7});

            10'b000_0000000: ALUOP = 4'b0010; //ADD
            10'b000_0100000: ALUOP = 4'b0110; //SUB
            10'b111_0000000: ALUOP = 4'b0000; //AND
            10'b110_0000000: ALUOP = 4'b0001; //OR
            
        
        endcase

    end
endmodule