`timescale 1ns/1ps

module tb_mux4;

parameter WIDTH = 8;

logic [WIDTH-1:0] din1, din2, din3, din4;
logic [1:0] select;
logic [WIDTH-1:0] dout;

mux4 #(WIDTH) uut (
    .din1(din1),
    .din2(din2),
    .din3(din3),
    .din4(din4),
    .select(select),
    .dout(dout)
);

initial begin

    $dumpfile("mux4.vcd");
    $dumpvars(0, tb_mux4);

    $display("Laboratorio 1 y 2 de Fodisegua");
    
    din1 = 8'h11;
    din2 = 8'h22;
    din3 = 8'h33;
    din4 = 8'h44;

    select = 2'b00; #10;
    $display("select=%b dout=%h", select, dout);

    select = 2'b01; #10;
    $display("select=%b dout=%h", select, dout);

    select = 2'b10; #10;
    $display("select=%b dout=%h", select, dout);

    select = 2'b11; #10;
    $display("select=%b dout=%h", select, dout);

    $finish;
end

endmodule
