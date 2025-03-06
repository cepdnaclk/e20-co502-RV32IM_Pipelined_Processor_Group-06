module LOAD_USE_DETECTOR(
    input wire [16:0] INSTRUCTION,
    input wire [4:0] RD,
    input wire LOAD_SELECTED,
    output reg LOAD_USE,
    output reg LOAD_USE_MUX
    );

    // default values
    LOAD_USE_MUX = 1'b1;
    LOAD_USE = 1'b0;

    always @(*) begin

        if (INSTRUCTION[6:0] == 7'b0110011 && (LOAD_SELECTED) && (INSTRUCTION[11:7] == RD || INSTRUCTION[16:12] == RD))begin
            LOAD_USE_MUX = 1'b0;
            LOAD_USE = 1'b1;
        end
    end

endmodule