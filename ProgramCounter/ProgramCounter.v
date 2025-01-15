module PROGRAM_COUNTER (
    input wire CLK,
    input wire RST,
    input wire [31:0] NEXT_PC,
    output reg [31:0] PC,
    output wire [31:0] PC_PLUS4
);

always @(posedge CLK or posedge RST) begin
    if (RST)
        PC <= 32'b0;
    else
        PC <= NEXT_PC;
end

assign PC_PLUS4 = PC + 4;

endmodule
