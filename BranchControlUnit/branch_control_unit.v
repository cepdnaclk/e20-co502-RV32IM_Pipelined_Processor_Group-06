module BRANCH_CONTROL_UNIT(
    input wire JUMP,
    input wire BRANCH,
    input wire [2:0] FUNC3,
    input wire [31:0] OUT1,
    input wire [31:0] OUT2,
    input wire [31:0] ALU_RESULT,
    output reg [31:0] TARGET_ADDRESS,
    output reg BRANCH_SELECT
);

    always @(*) begin
        // Default values
        TARGET_ADDRESS = 32'b0;
        BRANCH_SELECT = 1'b0;

        if (JUMP) begin
            // For jump instructions, the target address is the ALU result
            TARGET_ADDRESS = ALU_RESULT;
            BRANCH_SELECT = 1'b1;
        end else if (BRANCH) begin
            // For branch instructions, determine if the branch should be taken
            case (FUNC3)
                3'b000: begin // BEQ
                    if (OUT1 == OUT2) begin
                        TARGET_ADDRESS = ALU_RESULT;
                        BRANCH_SELECT = 1'b1;
                    end
                end
                3'b001: begin // BNE
                    if (OUT1 != OUT2) begin
                        TARGET_ADDRESS = ALU_RESULT;
                        BRANCH_SELECT = 1'b1;
                    end
                end
                3'b100: begin // BLT
                    if ($signed(OUT1) < $signed(OUT2)) begin
                        TARGET_ADDRESS = ALU_RESULT;
                        BRANCH_SELECT = 1'b1;
                    end
                end
                3'b101: begin // BGE
                    if ($signed(OUT1) >= $signed(OUT2)) begin
                        TARGET_ADDRESS = ALU_RESULT;
                        BRANCH_SELECT = 1'b1;
                    end
                end
                3'b110: begin // BLTU
                    if (OUT1 < OUT2) begin
                        TARGET_ADDRESS = ALU_RESULT;
                        BRANCH_SELECT = 1'b1;
                    end
                end
                3'b111: begin // BGEU
                    if (OUT1 >= OUT2) begin
                        TARGET_ADDRESS = ALU_RESULT;
                        BRANCH_SELECT = 1'b1;
                    end
                end
                default: begin
                    TARGET_ADDRESS = 32'b0;
                    BRANCH_SELECT = 1'b0;
                end
            endcase
        end
    end

endmodule
