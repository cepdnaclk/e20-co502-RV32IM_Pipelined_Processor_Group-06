module RegFileTestBench;
    reg clk, rst, regWrite;
    reg [4:0] readReg1, readReg2, writeReg;
    reg [31:0] writeData;
    wire [31:0] readData1, readData2;
    
    // Instantiate the RegFile module
    RegisterFile uut (
        .clk(clk),
        .rst(rst),
        .regWrite(regWrite),
        .readReg1(readReg1),
        .readReg2(readReg2),
        .writeReg(writeReg),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2)
    );

    initial begin
        // Intial GTKWave dump
        $dumpfile("register_file.vcd"); // Specify VCD output file name
        $dumpvars(0, RegFileTestBench); // 0 - dump all signals, RegFileTestBench - module name ( 1- dump only signals of module RegFileTestBench)

        // Initialize signals
        clk = 0;
        rst = 1;
        regWrite = 0;
        readReg1 = 0;
        readReg2 = 0;
        writeReg = 0;
        writeData = 0;

        // Simulation sequence
        #10 rst = 0; // De-assert reset
        #10 regWrite = 1; writeReg = 5'd1; writeData = 32'hA5A5A5A5; // Write to register 1
        #10 regWrite = 0; readReg1 = 5'd1; // Read from register 1
        #10 regWrite = 1; writeReg = 5'd2; writeData = 32'h12345678; // Write to register 2
        #10 regWrite = 0; readReg1 = 5'd2; // Read from register 2

        #10 $finish; // End simulation

    end

    always #5 clk = ~clk; // Clock generation

    // Monitor signals and print output
    initial begin
        $monitor("Time: %0t | clk: %b | rst: %b | regWrite: %b | writeReg: %d | writeData: %h | readReg1: %d | readData1: %h | readReg2: %d | readData2: %h",
            $time, clk, rst, regWrite, writeReg, writeData, readReg1, readData1, readReg2, readData2);
    end

endmodule