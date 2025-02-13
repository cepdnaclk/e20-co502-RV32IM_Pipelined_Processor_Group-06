// 32 bit integer ALU
module ALU(DATA1,DATA2,ALU_OPERATION,RESULT);

    input [31:0] DATA1,DATA2;
    input [4:0] ALU_OPERATION;
    output reg [31:0] RESULT;

    wire [31:0] subOut,addOut,andOut,orOut,left_shift_out,set_less_than_out,
    set_less_than_unsigned_out,xor_out,logical_shift_right_out,arithmetic_shift_right_out,multiplied_output,
    mulh_out, mulhsu_out, mulhu_out, div_out, divu_out, rem_out, remu_out, forward_out;

    and_1 and_1(DATA1,DATA2,andOut);
    sub_1 sub_1(DATA1,DATA2,subOut);
    add_1 add_1(DATA1,DATA2,addOut);
    or_1 or_1(DATA1,DATA2,orOut);
    left_shift left_shift(DATA1,DATA2,left_shift_out);
    set_less_than set_less_than(DATA1,DATA2,set_less_than_out);
    set_less_than_unsigned set_less_than_unsigned(DATA1,DATA2,set_less_than_unsigned_out);
    xor_module xor_1(DATA1,DATA2,xor_out);
    shift_right_logical shift_right_logical(DATA1,DATA2,logical_shift_right_out);
    shift_right_arithmetic shift_right_arithmetic(DATA1,DATA2,arithmetic_shift_right_out);
    multiplication multiplication(DATA1,DATA2,multiplied_output);
    mulh mulh(DATA1,DATA2,mulh_out);
    mulhsu mulhsu(DATA1,DATA2,mulhsu_out);
    mulhu mulhu(DATA1,DATA2,mulhu_out);
    div div(DATA1,DATA2,div_out);
    divu divu(DATA1,DATA2,divu_out);
    rem rem(DATA1,DATA2,rem_out);
    remu remu(DATA1,DATA2,remu_out);
    forward_1_and_extender forward(DATA2, forward_out);

    always @(*)
    begin
        case(ALU_OPERATION)

        5'b00000  :RESULT=andOut;
        5'b00001  :RESULT=orOut;
        5'b00010  :RESULT=addOut;
        5'b00011  :RESULT=subOut;
        5'b00100  :RESULT=left_shift_out;
        5'b00101  :RESULT=set_less_than_out; // SLT => Set Less Than(1/0)
        5'b00110  :RESULT=set_less_than_unsigned_out; // SLT unsigned
        5'b00111  :RESULT=xor_out;
        5'b01000  :RESULT=logical_shift_right_out;
        5'b01001  :RESULT=arithmetic_shift_right_out;
        5'b01010  :RESULT=multiplied_output; // Multiplication
        5'b01011  :RESULT=mulh_out; // MULH
        5'b01100  :RESULT=mulhsu_out; // MULHSU
        5'b01101  :RESULT=mulhu_out; // MULHU
        5'b01110  :RESULT=div_out; // DIV
        5'b01111  :RESULT=divu_out; // DIVU
        5'b10000  :RESULT=rem_out; // REM
        5'b10001  :RESULT=remu_out; // REMU
        5'b10010  :RESULT=forward_out; // forward => for the LUI instruction
        endcase
    end
endmodule


module forward_1_and_extender(DATA2, forward_out);

    input [31:0] DATA2;
    output reg [31:0] forward_out;

    always @(*) begin
        #1 forward_out = {DATA2[31:12], 12'b0};
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

module left_shift(DATA1, DATA2, left_shift_out);

    input [31:0] DATA1, DATA2;
    output reg [31:0] left_shift_out;

    always @(DATA1, DATA2) begin
        #1 left_shift_out = DATA1 << DATA2;
    end

endmodule

module set_less_than(DATA1, DATA2, set_less_than_out);

    input [31:0] DATA1, DATA2;
    output reg [31:0] set_less_than_out;

    always @(DATA1, DATA2) begin
        #1 if ($signed(DATA1) < $signed(DATA2)) begin
            set_less_than_out = 32'b1;
        end else begin
            set_less_than_out = 32'b0;
        end
    end

endmodule

module set_less_than_unsigned(DATA1, DATA2, set_less_than_unsigned_out);

    input [31:0] DATA1, DATA2;
    output reg [31:0] set_less_than_unsigned_out;

    always @(DATA1, DATA2) begin
        #1 if (DATA1 < DATA2) begin
            set_less_than_unsigned_out = 32'b1;
        end else begin
            set_less_than_unsigned_out = 32'b0;
        end
    end

endmodule

module xor_module(DATA1, DATA2, xor_out);

    input [31:0] DATA1, DATA2;
    output [31:0] xor_out;

    assign xor_out = DATA1 ^ DATA2;

endmodule

module shift_right_logical(DATA1, DATA2, logical_shift_right_out);

    input [31:0] DATA1, DATA2;
    output [31:0] logical_shift_right_out;

    assign logical_shift_right_out = DATA1 >> DATA2;

endmodule

module shift_right_arithmetic(DATA1, DATA2, arithmetic_shift_right_out);

    input [31:0] DATA1, DATA2;
    output [31:0] arithmetic_shift_right_out;

    assign arithmetic_shift_right_out = $signed(DATA1) >>> DATA2;

endmodule

module multiplication(DATA1, DATA2, multiplied_output);

    input [31:0] DATA1, DATA2;
    output [31:0] multiplied_output;

    assign multiplied_output = DATA1 * DATA2;

endmodule

module mulh(DATA1, DATA2, mulh_out);

    input [31:0] DATA1, DATA2;
    output [31:0] mulh_out;

    assign mulh_out = ($signed(DATA1) * $signed(DATA2)) >> 32;

endmodule

module mulhsu(DATA1, DATA2, mulhsu_out);

    input [31:0] DATA1, DATA2;
    output [31:0] mulhsu_out;

    assign mulhsu_out = ($signed(DATA1) * DATA2) >> 32;

endmodule

module mulhu(DATA1, DATA2, mulhu_out);

    input [31:0] DATA1, DATA2;
    output [31:0] mulhu_out;

    assign mulhu_out = (DATA1 * DATA2) >> 32;

endmodule

module div(DATA1, DATA2, div_out);

    input [31:0] DATA1, DATA2;
    output [31:0] div_out;

    assign div_out = $signed(DATA1) / $signed(DATA2);

endmodule

module divu(DATA1, DATA2, divu_out);

    input [31:0] DATA1, DATA2;
    output [31:0] divu_out;

    assign divu_out = DATA1 / DATA2;

endmodule

module rem(DATA1, DATA2, rem_out);

    input [31:0] DATA1, DATA2;
    output [31:0] rem_out;

    assign rem_out = $signed(DATA1) % $signed(DATA2);

endmodule

module remu(DATA1, DATA2, remu_out);

    input [31:0] DATA1, DATA2;
    output [31:0] remu_out;

    assign remu_out = DATA1 % DATA2;

endmodule