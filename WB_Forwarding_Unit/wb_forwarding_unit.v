module FORWARDING_CONTROL_UNIT(
    input wire WRITE_EN,
    input wire [4:0] WB_REGISTER,ADDR1,ADDR2,
    output reg OUT1_FORWARD_EN, OUT2_FORWARD_EN,
);

always @(*) begin
    // Default values
    OUT1_FORWARD_EN = 1'b0;
    OUT2_FORWARD_EN = 1'b0;
    OUT1_FORWARD_DATA = 32'b0;
    OUT2_FORWARD_DATA = 32'b0;

    // Give the mux to select forward data
    //when the addresses match
    if (WRITE_EN == 1'b1) begin
        if (WB_REGISTER == ADDR1) begin
            OUT1_FORWARD_EN = 1'b1;
        end
        if (WB_REGISTER == ADDR2) begin
            OUT2_FORWARD_EN = 1'b1;
        end
    end
end

endmodule