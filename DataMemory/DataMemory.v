// module DATA_MEMORY (
//     input wire CLK,                     // Clock signal
//     input wire [31:0] ADDRESS,          // Address for data memory
//     input wire [31:0] WRITE_DATA,       // Data to write into memory
//     input wire MEM_WRITE,               // Write enable signal
//     input wire MEM_READ,                // Read enable signal
//     input wire [2:0] FUNC3,             // Function code to determine store type
//     output reg [31:0] READ_DATA         // Data read from memory
// );
//     // Data Memory size
//     parameter MEM_SIZE = 1024;
//     reg [31:0] DATA_MEM[0:MEM_SIZE-1];

//     // Memory write operation
//     always @(posedge CLK) begin
//         if (MEM_WRITE) begin
//             case (FUNC3)
//                 3'b000: DATA_MEM[ADDRESS[11:2]][7:0] <= WRITE_DATA[7:0];   // SB
//                 3'b001: DATA_MEM[ADDRESS[11:2]][15:0] <= WRITE_DATA[15:0]; // SH
//                 3'b010: DATA_MEM[ADDRESS[11:2]] <= WRITE_DATA;             // SW
//                 default: DATA_MEM[ADDRESS[11:2]] <= WRITE_DATA;            // Default to SW
//             endcase
//         end
//     end

//     // Memory read operation
//     always @(*) begin
//         if (MEM_READ) begin
//             READ_DATA = DATA_MEM[ADDRESS[11:2]]; // Asynchronous read
//         end else begin
//             READ_DATA = 32'b0; // Default value when read is disabled
//         end
//     end
// endmodule

module DATA_MEMORY (
    input wire CLK,                     // Clock signal
    input wire [31:0] ADDRESS,          // Address for data memory
    input wire [31:0] WRITE_DATA,       // Data to write into memory
    input wire MEM_WRITE,               // Write enable signal
    input wire MEM_READ,                // Read enable signal
    input wire [2:0] FUNC3,             // Function code to determine store type
    output reg [31:0] READ_DATA         // Data read from memory
);
    // Data Memory size
    parameter MEM_SIZE = 1024;
    reg [31:0] DATA_MEM[0:MEM_SIZE-1];

    // Initialize memory to zero and preload specific values
    integer i;
    initial begin
        // Set all memory locations to zero
        for (i = 0; i < MEM_SIZE; i = i + 1) begin
            DATA_MEM[i] = 32'b0;
        end

        // Preload specific test values (modify as needed)
        DATA_MEM[0]  = 32'b00000000_00000000_00000000_00000001; // Test value at address 0
        DATA_MEM[1]  = 32'b00000000_00000000_00000000_00000010; // Test value at address 1
        DATA_MEM[2]  = 32'b00000000_00000000_00000000_00000011; // Test value at address 2
        DATA_MEM[3]  = 32'b00000000_00000000_00000000_00000100; // Test value at address 3
        DATA_MEM[4]  = 32'b00000000_00000000_00000000_00000101; // Test value at address 4
    end

    // Memory write operation
    always @(posedge CLK) begin
        if (MEM_WRITE) begin
            case (FUNC3)
                3'b000: DATA_MEM[ADDRESS[11:2]][7:0]  <= WRITE_DATA[7:0];   // SB
                3'b001: DATA_MEM[ADDRESS[11:2]][15:0] <= WRITE_DATA[15:0]; // SH
                3'b010: DATA_MEM[ADDRESS[11:2]]       <= WRITE_DATA;       // SW
                default: DATA_MEM[ADDRESS[11:2]]       <= WRITE_DATA;       // Default to SW
            endcase
        end
    end

    // Memory read operation
    always @(*) begin
        if (MEM_READ) begin
            READ_DATA = DATA_MEM[ADDRESS[11:2]]; // Asynchronous read
        end else begin
            READ_DATA = 32'b0; // Default value when read is disabled
        end
    end
endmodule
