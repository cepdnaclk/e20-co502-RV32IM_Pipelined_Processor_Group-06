module DataMemory_tb;
    // Testbench signals
    reg clk;
    reg [31:0] address;
    reg [31:0] writeData;
    reg memWrite, memRead;
    wire [31:0] readData;

    // Instantiate the Data Memory module
    DataMemory uut (
        .clk(clk),
        .address(address),
        .writeData(writeData),
        .memWrite(memWrite),
        .memRead(memRead),
        .readData(readData)
    );

    //clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Open VCD file for GTKWave
        $dumpfile("DataMemory_tb.vcd");
        $dumpvars(0, DataMemory_tb);

        //initialize signals
        address = 0;
        writeData = 0;
        memWrite = 0;
        memRead = 0;

        // Write data to memory at address 0x04
        #10 address = 32'h4; 
        writeData = 32'hDEADBEEF; 
        memWrite = 1;
        #10 memWrite = 0;

        // Read data from memory at address 0x04
        #10 address = 32'h4; 
        memRead = 1;
        #10 memRead = 0;

        // Write data to memory at address 0x08
        #10 address = 32'h8; 
        writeData = 32'h12345678; 
        memWrite = 1;
        #10 memWrite = 0;

        // Read data from memory at address 0x08
        #10 address = 32'h8; 
        memRead = 1;
        #10 memRead = 0;

        // Attempt to read from an uninitialized address
        #10 address = 32'hC; 
        memRead = 1;
        #10 memRead = 0;

        // Monitor signals in the simulation
        $monitor("Time = %0d, Address = %h, WriteData = %h, ReadData = %h", $time, address, writeData, readData);

        // Finish the simulation
        #10 $finish;
    end

endmodule
