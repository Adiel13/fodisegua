`timescale 1ns/1ps

module tb_registerbank;

parameter WIDTH = 8;

logic CLK;
logic rst;
logic wr_en;
logic [WIDTH-1:0] in;
logic [WIDTH-1:0] out;

initial CLK = 0;
always #5 CLK = ~CLK;

register_bank #(WIDTH) uut (
    .clk(CLK),
    .rst(rst),
    .wr_en(wr_en),
    .in(in),
    .out(out)
);

initial begin
    $fsdbDumpfile("registerbank.fsdb");
    $fsdbDumpvars(0, tb_registerbank);

    // Reset
    rst   = 1;
    wr_en = 0;
    in    = 0;

    #10;
    rst = 0;

    // Escribir 55
    in = 8'd55;
    wr_en = 1;
    #10;

    $display("out=%0d", out);

    // Escribir 100
    in = 8'd100;
    #10;

    $display("out=%0d", out);

    // Deshabilitar escritura
    wr_en = 0;
    in = 8'd200;
    #10;

    $display("out=%0d", out);

    $finish;
end

endmodule