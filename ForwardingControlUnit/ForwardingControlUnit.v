module FORWARDING_CONTROL_UNIT(
    input wire [1:0] WB_FORWARD_EN, MEM_FORWARD_EN,
    input wire [31:0] WB_RD_DATA, MEM_RD_DATA,
    output reg OUT1_FORWARD_EN, OUT2_FORWARD_EN,
    output reg [31:0] OUT1_FORWARD_DATA, OUT2_FORWARD_DATA
);

always @(*) begin
    // Default values
    OUT1_FORWARD_EN = 1'b0;
    OUT2_FORWARD_EN = 1'b0;
    OUT1_FORWARD_DATA = 32'b0;
    OUT2_FORWARD_DATA = 32'b0;

    case ({WB_FORWARD_EN, MEM_FORWARD_EN})
        4'b0000: begin
            // No forwarding
        end
        4'b0001: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = MEM_RD_DATA;
        end
        4'b0010: begin
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = MEM_RD_DATA;
        end
        4'b0011: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = MEM_RD_DATA;
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = MEM_RD_DATA;
        end
        4'b0100: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = WB_RD_DATA;
        end
        4'b0101: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = MEM_RD_DATA;
        end
        4'b0110: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = WB_RD_DATA;
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = MEM_RD_DATA;
        end
        4'b0111: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = MEM_RD_DATA;
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = MEM_RD_DATA;
        end
        4'b1000: begin
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = WB_RD_DATA;
        end
        4'b1001: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = MEM_RD_DATA;
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = WB_RD_DATA;
        end
        4'b1010: begin
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = MEM_RD_DATA;
        end
        4'b1011: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = MEM_RD_DATA;
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = MEM_RD_DATA;
        end
        4'b1100: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = WB_RD_DATA;
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = WB_RD_DATA;
        end
        4'b1101: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = MEM_RD_DATA;
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = WB_RD_DATA;
        end
        4'b1110: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = WB_RD_DATA;
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = MEM_RD_DATA;
        end
        4'b1111: begin
            OUT1_FORWARD_EN = 1'b1;
            OUT1_FORWARD_DATA = MEM_RD_DATA;
            OUT2_FORWARD_EN = 1'b1;
            OUT2_FORWARD_DATA = MEM_RD_DATA;
        end
    endcase
end

endmodule