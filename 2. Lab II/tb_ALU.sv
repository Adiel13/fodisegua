`timescale 1ns/1ps

module tb_ALU;

parameter WIDTH = 8;

logic [WIDTH-1:0] in1, in2;
logic [3:0] op;
logic invalid_data;
logic [2*WIDTH-1:0] out;
logic zero;
logic error;

ALU #(WIDTH) uut (
    .in1(in1),
    .in2(in2),
    .op(op),
    .invalid_data(invalid_data),
    .zero(zero),
    .out(out),
    .error(error)
);

initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, tb_ALU);

    in1 = 8'h01;
    in2 = 8'h01;

    op = 4'b0001; #10;
    $display("op=%b out=%h err=%b zero=%b", op, out, error, zero);


end
endmodule