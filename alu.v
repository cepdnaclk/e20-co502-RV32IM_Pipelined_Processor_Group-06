// 32 bit integer ALU
module alu(DATA1,DATA2,ALU_OPERATION,RESULT);

    input [31:0] DATA1,DATA2;
    input [3:0] ALU_OPERATION;
    output reg [31:0] RESULT;

    wire [31:0] subOut,addOut,andOut,orOut;

    and_1 and_1(DATA1,DATA2,andOut);
    sub_1 sub_1(DATA1,DATA2,subOut);
    add_1 add_1(DATA1,DATA2,addOut);
    or_1 or_1(DATA1,DATA2,orOut);

    always @(ALU_OPERATION,subOut,addOut,andOut,orOut)
    begin
        case(ALU_OPERATION)

        4'b0000  :RESULT=andOut;
        4'b0001  :RESULT=orOut;
        4'b0010  :RESULT=addOut;
        4'b0110  :RESULT=subOut;

        endcase

    end
endmodule

module add_1(DATA1,DATA2,addOut);

    input [31:0] DATA1,DATA2;
    output reg [31:0] addOut;

    always @(DATA1,DATA2) begin
        #1 addOut = DATA1 + DATA2;
    end
endmodule

module sub_1(DATA1,DATA2,subOut);

    input [31:0] DATA1,DATA2;
    output reg [31:0] subOut;

    always @(DATA1,DATA2) begin
        #2 subOut = DATA1 - DATA2;
    end
endmodule

module and_1(DATA1,DATA2,andOut);

    input [31:0] DATA1,DATA2;
    output reg [31:0] andOut;

    always @(DATA1,DATA2) begin
        #1 andOut = DATA1 & DATA2;
    end
endmodule

module or_1(DATA1,DATA2,orOut);

    input [31:0] DATA1,DATA2;
    output reg [31:0] orOut;

    always @(DATA1,DATA2) begin
        #1 orOut = DATA1 | DATA2;
    end
endmodule