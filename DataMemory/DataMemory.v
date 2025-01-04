module DataMemory (
    input wire clk,                     // Clock signal
    input wire [31:0] address,          // Address for data memory
    input wire [31:0] writeData,        // Data to write into memory
    input wire memWrite,                // Write enable signal
    input wire memRead,                 // Read enable signal
    output reg [31:0] readData          // Data read from memory
);
    // Data Memory size
    parameter memSize = 1024;
    reg [31:0] dataMem[0:memSize-1];

    // Memory write operation
    always @(posedge clk) begin
        if (memWrite) begin
            dataMem[address[11:2]] <= writeData; // Write data to indexed memory
        end
    end

    // Memory read operation
    always @(*) begin
        if (memRead) begin
            readData = dataMem[address[11:2]]; // Asynchronous read
        end else begin
            readData = 32'b0; // Default value when read is disabled
        end
    end
endmodule
