module FORWARDING_UNIT (
    input wire [4:0] ADDR1,
    input wire [4:0] ADDR2,
    input wire [4:0] STAGE_RD,
    output wire [1:0] FORWARD_EN,
);

always @(*) begin
    if (STAGE_RD == 5'b00000) begin
        FORWARD_EN = 3'b00;
    end else if (ADDR1 == STAGE_RD && ADDR2 == STAGE_RD) begin
        FORWARD_EN = 3'b11;
    end else if (ADDR1 == STAGE_RD) begin
        FORWARD_EN = 3'b01;
    end else if (ADDR2 == STAGE_RD) begin
        FORWARD_EN = 3'b10;
    end
end

endmodule