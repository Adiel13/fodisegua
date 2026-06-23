`timescale 1ns/1ps

module tb_memory;
parameter WIDTH = 8;

logic CLK, memoryWrite, memoryRead;
logic [2*WIDTH-1:0] memoryWriteData;
logic [7:0] memoryAddress;
logic[2*WIDTH-1:0] memoryOutData;

initial CLK = 0;
always #5 CLK = ~CLK;

memory #(WIDTH) uut(
    .clk(CLK),
    .memoryWrite(memoryWrite),
    .memoryRead(memoryRead),
    .memoryWriteData(memoryWriteData),
    .memoryAddress(memoryAddress),
    .memoryOutData(memoryOutData)
);

initial begin
    $dumpfile("memory.vcd");
    $dumpvars(0, tb_memory);
    
    memoryWrite = 0;
    memoryRead = 0;
    memoryAddress = 0;
    memoryWriteData = 0;

    #10
    memoryWrite = 1;
    memoryRead = 0;
    memoryAddress = 0;
    memoryWriteData = 16'h0011;
    $display("memoryWriteData=%b memoryAddress=%0d", memoryWriteData, memoryAddress);
    
    @(posedge CLK);
    #1;

    memoryWrite = 0;
    memoryRead = 1;
    memoryAddress = 0;
    memoryWriteData = 16'h0011;

    #1
    $display("memoryOutData=%b memoryAddress=%0d", memoryOutData, memoryAddress);
    
    $finish;
end

endmodule

