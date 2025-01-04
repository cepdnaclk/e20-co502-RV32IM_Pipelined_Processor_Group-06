
module control_unit(OPCODE, FUNC3, FUNC7, WRITE_EN, MEM_WRITE, MEM_READ, BRANCH, JUMP, PC_SELECT, IMM_SELECT, JALR_SELECT, DATA_MEM_SELECT);
    input [7:0] OPCODE, FUNC3, FUNC7;                         // mux 1  // mux 2         // select pc+4 // mux 4  
    output reg WRITE_EN, MEM_WRITE, MEM_READ, BRANCH, JUMP, PC_SELECT, IMM_SELECT, JALR_SELECT,         DATA_MEM_SELECT;

    // always block * to run the block whenever any input changes  
    always @(*)
    begin
        // #1 // Decorder delay
        // Default values
        WRITE_EN = 1'b0;
        MEM_WRITE = 1'b0;
        MEM_READ = 1'b0;
        BRANCH = 1'b0;
        JUMP = 1'b0;
        PC_SELECT = 1'b0;
        IMM_SELECT = 1'b0;
        JALR_SELECT = 1'b0;
        DATA_MEM_SELECT = 1'b0;

        case (OPCODE)

        // R-type
        8'b0110011: 
            begin
                WRITE_EN = 1'b1;
            end
            // just incase for mult others needed
            // case ({FUNC3, FUNC7})
            // 11'b000_0000000: // ADD
            // begin
            //     WRITE_EN = 1'b1;
            // end
            // 11'b000_0100000: // SUB
            // begin
            //     WRITE_EN = 1'b1;
            // end
            // 11'b001_0000000: // SLL
            // begin
            //     WRITE_EN = 1'b1;
            // end
            // endcase

        // I-type
        8'b0000011: 
            if (FUNC3 == 3'b000 || // LB,
                FUNC3 == 3'b001 || // LH
                FUNC3 == 3'b010 || // LW
                FUNC3 == 3'b100 || // LBU
                FUNC3 == 3'b101)    // LHU
                begin
                    IMM_SELECT = 1'b1;
                    WRITE_EN = 1'b1;
                    MEM_READ = 1'b1;
                end
        8'b1100111: 
            case (FUNC3)
            3'b000: // JALR
            begin
                WRITE_EN = 1'b1;
                JALR_SELECT = 1'b1;
                IMM_SELECT = 1'b1;
                JUMP = 1'b1;

            end
            endcase
        8'b0010011:
            if (FUNC3 == 3'b000 || // ADDI
                FUNC3 == 3'b010 || // SLTI
                FUNC3 == 3'b011 || // SLTIU
                FUNC3 == 3'b100 || // XORI
                FUNC3 == 3'b110 || // ORI
                FUNC3 == 3'b111)   // ANDI
            begin
                WRITE_EN = 1'b1;
                IMM_SELECT = 1'b1;
            end
            
            case ({FUNC7, FUNC3})
            3'b0000000_001: // SLLI
            begin
                WRITE_EN = 1'b1;
                IMM_SELECT = 1'b1;
            end
            3'b0000000_101: // SRLI
            begin
                WRITE_EN = 1'b1;
                IMM_SELECT = 1'b1;
            end
            3'b0100000_101: // SRAI  
            begin
                WRITE_EN = 1'b1;
                IMM_SELECT = 1'b1;
            end
            endcase


        // S-type
        8'b0100011: 
            case (FUNC3)
            3'b000: // SB
            begin
                MEM_WRITE = 1'b1;
            end
            3'b001: // SH
            begin
                MEM_WRITE = 1'b1;
            end
            3'b010: // SW
            begin
                MEM_WRITE = 1'b1;
            end
            endcase

        // U-type
        8'b0110111: // LUI
            begin
            WRITE_EN = 1'b1;
            end
        8'b0010111: // AUIPC
            begin
            WRITE_EN = 1'b1;
            end

        // B-type
        8'b1100011: 
            case (FUNC3)
            3'b000: // BEQ
            begin
                BRANCH = 1'b1;
            end
            3'b001: // BNE
            begin
                BRANCH = 1'b1;
            end
            3'b100: // BLT
            begin
                BRANCH = 1'b1;
            end
            3'b101: // BGE
            begin
                BRANCH = 1'b1;
            end
            3'b110: // BLTU
            begin
                BRANCH = 1'b1;
            end
            3'b111: // BGEU
            begin
                BRANCH = 1'b1;
            end
            endcase

        // J-type
        8'b1101111: // JAL
            begin
            JUMP = 1'b1;
            end

        endcase


    end 

endmodule

