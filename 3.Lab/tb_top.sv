`timescale 1ns/1ps

module tb_top;
parameter WIDTH = 8;

logic CLK;
logic rst;
logic [6:0] cmdin;
logic [WIDTH-1:0] din_1;
logic [WIDTH-1:0] din_2;
logic [WIDTH-1:0] din_3;
logic [WIDTH-1:0] dout_low;
logic [WIDTH-1:0] dout_high;
logic cpu_rdy;
logic zero;
logic error;

initial CLK = 0;
always #5 CLK = ~CLK;

top #(.WIDTH(WIDTH)) uut (
    .clk(CLK),
    .rst(rst),
    .cmdin(cmdin),
    .din_1(din_1),
    .din_2(din_2),
    .din_3(din_3),
    .dout_low(dout_low),
    .dout_high(dout_high),
    .cpu_rdy(cpu_rdy),
    .zero(zero),
    .error(error)
);

initial begin
    $dumpfile("top.vcd");
    $dumpvars(0, tb_top);

    rst = 1;
    cmdin = 7'b0;
    din_1 = '0;
    din_2 = '0;
    din_3 = '0;

    #12;
    rst = 0;

    // Add: A = din_1(3), B = din_2(5), opcode = 000
    din_1 = 8'd3;
    din_2 = 8'd5;
    din_3 = 8'd7;
    cmdin = 7'b0001000; // muxA=00, muxB=01, opcode=000
    @(posedge CLK);
    @(posedge CLK);
    $display("ADD result=%0d zero=%b error=%b cpu_rdy=%b", {dout_high, dout_low}, zero, error, cpu_rdy);

    // Store: address = din_1(3), data = din_3(7), opcode = 110
    cmdin = 7'b0010110; // muxA=00, muxB=10, opcode=110
    @(posedge CLK);
    @(posedge CLK);
    $display("STORE result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // Load: address = din_1(3), opcode = 101
    cmdin = 7'b0000101; // muxA=00, muxB=00, opcode=101
    @(posedge CLK);
    @(posedge CLK);
    $display("LOAD result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // Div: A = din_1(8), B = din_2(2), opcode = 011
    din_1 = 8'd8;
    din_2 = 8'd2;
    cmdin = 7'b0001011; // muxA=00, muxB=01, opcode=011
    @(posedge CLK);
    @(posedge CLK);
    $display("DIV result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // Div by zero: A = din_1(8), B = din_2(0), opcode = 011
    din_1 = 8'd8;
    din_2 = 8'd0;
    cmdin = 7'b0001011;
    @(posedge CLK);
    @(posedge CLK);
    $display("DIV_ZERO result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    $finish;
end
endmodule
