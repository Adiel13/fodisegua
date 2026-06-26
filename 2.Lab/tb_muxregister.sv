`timescale 1ns/1ps

module tb_muxregister;
parameter WIDTH = 8;

logic CLK;
logic rst;
logic wr_en;
logic [1:0] sel;
logic [WIDTH-1:0] in1, in2, in3, in4;
logic [WIDTH-1:0] out;

initial CLK = 0;
always #5 CLK = ~CLK;

mux4_registered #(WIDTH) uut(
    .clk(CLK),
    .rst(rst),
    .wr_en(wr_en),
    .sel(sel),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .in4(in4),
    .out(out)
);

initial begin
    $fsdbDumpfile("muxregister.fsdb");
    $fsdbDumpvars(0, tb_muxregister);

    rst = 1;
    wr_en = 0;
    in1 = 0;
    in2 = 0;
    in3 = 0;
    in4 = 0;

    #10
    rst = 0;
    in1 = 8'h11;
    in2 = 8'h22;
    in3 = 8'h33;
    in4 = 8'h44;
    wr_en = 1;

    sel = 2'b00; #10;
    $display("select=%b out=%0d", sel, out);

    sel = 2'b01; #10;
    $display("select=%b out=%0d", sel, out);

    sel = 2'b10; #10;
    $display("select=%b out=%0d", sel, out);

    sel = 2'b11; #10;
    $display("select=%b out=%0d", sel, out);
    $finish;
end
endmodule