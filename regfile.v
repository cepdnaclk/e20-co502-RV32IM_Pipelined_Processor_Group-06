module RegisterFile (
    input wire clk,                    // Clock signal
    input wire rst,                    // Reset signal
    input wire regWrite,               // Write enable signal
    input wire [4:0] readReg1,         // Read register 1 address
    input wire [4:0] readReg2,         // Read register 2 address
    input wire [4:0] writeReg,         // Write register address
    input wire [31:0] writeData,       // Data to write
    output wire [31:0] readData1,      // Data from read register 1
    output wire [31:0] readData2       // Data from read register 2
);

    // Register array (32 registers of 32 bits)
    reg [31:0] registers [31:0];

    // Read logic
    assign readData1 = (readReg1 != 0) ? registers[readReg1] : 32'b0; // R0 is always 0
    assign readData2 = (readReg2 != 0) ? registers[readReg2] : 32'b0;

    // Write logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers to 0
            integer i;
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (regWrite && writeReg != 0) begin
            // Write to the register if enabled and not writing to R0
            registers[writeReg] <= writeData;
        end
    end

endmodule
