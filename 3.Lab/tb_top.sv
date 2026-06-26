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

    // ========== ADD OPERATIONS ==========
    // ADD: A = din_1(10), B = din_2(15), opcode = 000
    din_1 = 8'd10;
    din_2 = 8'd15;
    din_3 = 8'd7;
    cmdin = 7'b0001000; // muxA=00, muxB=01, opcode=000
    @(posedge CLK);
    @(posedge CLK);
    $display("ADD (10+15) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // ADD: A = din_2(15), B = din_3(7), muxA=01, muxB=10
    cmdin = 7'b0110000; // muxA=01, muxB=10, opcode=000
    @(posedge CLK);
    @(posedge CLK);
    $display("ADD (15+7) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // ========== SUB OPERATIONS ==========
    // SUB: A = din_1(20), B = din_2(5), opcode = 001
    din_1 = 8'd20;
    din_2 = 8'd5;
    cmdin = 7'b0001001; // muxA=00, muxB=01, opcode=001
    @(posedge CLK);
    @(posedge CLK);
    $display("SUB (20-5) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // SUB: A = din_3(30), B = din_1(10), muxA=10, muxB=00
    din_1 = 8'd10;
    din_3 = 8'd30;
    cmdin = 7'b1000001; // muxA=10, muxB=00, opcode=001
    @(posedge CLK);
    @(posedge CLK);
    $display("SUB (30-10) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // ========== MUL OPERATIONS ==========
    // MUL: A = din_1(3), B = din_2(4), opcode = 010
    din_1 = 8'd3;
    din_2 = 8'd4;
    cmdin = 7'b0001010; // muxA=00, muxB=01, opcode=010
    @(posedge CLK);
    @(posedge CLK);
    $display("MUL (3*4) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // MUL: A = din_2(6), B = din_3(5), muxA=01, muxB=10
    din_2 = 8'd6;
    din_3 = 8'd5;
    cmdin = 7'b0110010; // muxA=01, muxB=10, opcode=010
    @(posedge CLK);
    @(posedge CLK);
    $display("MUL (6*5) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // ========== DIV OPERATIONS ==========
    // DIV: A = din_1(16), B = din_2(4), opcode = 011
    din_1 = 8'd16;
    din_2 = 8'd4;
    cmdin = 7'b0001011; // muxA=00, muxB=01, opcode=011
    @(posedge CLK);
    @(posedge CLK);
    $display("DIV (16/4) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // DIV: A = din_3(25), B = din_1(5), muxA=10, muxB=00
    din_1 = 8'd5;
    din_3 = 8'd25;
    cmdin = 7'b1000011; // muxA=10, muxB=00, opcode=011
    @(posedge CLK);
    @(posedge CLK);
    $display("DIV (25/5) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // DIV by zero: A = 8, B = 0, opcode = 011
    din_1 = 8'd8;
    din_2 = 8'd0;
    cmdin = 7'b0001011; // muxA=00, muxB=01, opcode=011
    @(posedge CLK);
    @(posedge CLK);
    $display("DIV_ZERO (8/0) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // ========== LOAD OPERATIONS ==========
    // LOAD: address = din_1(0), opcode = 101
    din_1 = 8'd0;
    cmdin = 7'b0000101; // muxA=00, muxB=00, opcode=101
    @(posedge CLK);
    @(posedge CLK);
    $display("LOAD addr(0) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // LOAD: address = din_2(1), muxA=01
    din_2 = 8'd1;
    cmdin = 7'b0100101; // muxA=01, muxB=00, opcode=101
    @(posedge CLK);
    @(posedge CLK);
    $display("LOAD addr(1) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // LOAD: address = din_3(2), muxA=10
    din_3 = 8'd2;
    cmdin = 7'b1000101; // muxA=10, muxB=00, opcode=101
    @(posedge CLK);
    @(posedge CLK);
    $display("LOAD addr(2) result=%0d zero=%b error=%b", {dout_high, dout_low}, zero, error);

    // ========== STORE OPERATIONS ==========
    // STORE: address = din_1(0), data = din_2(42), opcode = 110
    din_1 = 8'd0;
    din_2 = 8'd42;
    din_3 = 8'd0;
    cmdin = 7'b0100110; // muxA=00, muxB=01, opcode=110
    @(posedge CLK);
    @(posedge CLK);
    $display("STORE addr(0) data(42) result=%0d", {dout_high, dout_low});

    // STORE: address = din_2(3), data = din_3(99), muxA=01, muxB=10
    din_1 = 8'd3;
    din_2 = 8'd3;
    din_3 = 8'd99;
    cmdin = 7'b0110110; // muxA=01, muxB=10, opcode=110
    @(posedge CLK);
    @(posedge CLK);
    $display("STORE addr(3) data(99) result=%0d", {dout_high, dout_low});

    // STORE: address = din_3(5), data = din_1(77), muxA=10, muxB=00
    din_1 = 8'd77;
    din_2 = 8'd0;
    din_3 = 8'd5;
    cmdin = 7'b1000110; // muxA=10, muxB=00, opcode=110
    @(posedge CLK);
    @(posedge CLK);
    $display("STORE addr(5) data(77) result=%0d", {dout_high, dout_low});

    // ========== MUX COVERAGE: uso de din_4 (dout_low) ==========
    // Usar multiplexor con select=11 (debería usar dout_low como entrada)
    din_1 = 8'd1;
    din_2 = 8'd2;
    din_3 = 8'd3;
    cmdin = 7'b1101000; // muxA=11, muxB=01, opcode=000 (mux_a usa dout_low)
    @(posedge CLK);
    @(posedge CLK);
    $display("ADD with mux_a=dout_low result=%0d", {dout_high, dout_low});

    cmdin = 7'b0111000; // muxA=01, muxB=11, opcode=000 (mux_b usa dout_low)
    @(posedge CLK);
    @(posedge CLK);
    $display("ADD with mux_b=dout_low result=%0d", {dout_high, dout_low});

    #10;
    $finish;
end
endmodule
