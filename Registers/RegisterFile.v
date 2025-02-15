module REGISTER_FILE (
    input wire CLK,                    // Clock signal
    input wire RST,                    // Reset signal
    input wire WRITE_ENABLE,              // Write enable signal
    input wire [4:0] READ_REG1,        // Read register 1 address
    input wire [4:0] READ_REG2,        // Read register 2 address
    input wire [4:0] WRITE_REG,        // Write register address
    input wire [31:0] WRITE_DATA,      // Data to write
    output wire [31:0] READ_DATA1,     // Data from read register 1
    output wire [31:0] READ_DATA2      // Data from read register 2
);

    // Register array (32 registers of 32 bits)
    reg [31:0] REGISTERS [31:0];

    // Declare loop variable outside the procedural block for Verilog compatibility
    integer i;

    // Read logic
    assign READ_DATA1 = (READ_REG1 != 0) ? REGISTERS[READ_REG1] : 32'b0; // R0 is always 0
    assign READ_DATA2 = (READ_REG2 != 0) ? REGISTERS[READ_REG2] : 32'b0;

    // Write logic
    always @(posedge CLK) begin // changed to work only in clk posd edge,  not when RST is high
        if (RST) begin
            // Reset all registers to 0
            for (i = 0; i < 32; i = i + 1) begin
                REGISTERS[i] <= 32'b0;
            end
        end else if (WRITE_ENABLE && WRITE_REG != 0) begin
            // Write to the register if enabled and not writing to R0
            REGISTERS[WRITE_REG] <= WRITE_DATA;
        end
    end

endmodule
