module MUX (
    input wire [31:0] IN0,
    input wire [31:0] IN1,
    input wire SEL,
    output wire [31:0] OUT
);

    assign OUT = SEL ? IN1 : IN0;

endmodule
