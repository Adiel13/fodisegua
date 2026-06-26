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
    $fsdbDumpfile("memory.fsdb");
    $fsdbDumpvars(0, tb_memory);

    memoryWrite = 0;
    memoryRead = 0;
    memoryAddress = 0;
    memoryWriteData = 0;

    #10
    memoryWrite = 1;
    memoryRead = 0;
    memoryAddress = 0;
    memoryWriteData = 16'h666F;
    
    @(posedge CLK);
    #1;

    #10
    memoryWrite = 1;
    memoryRead = 0;
    memoryAddress = 1;
    memoryWriteData = 16'h6469;
    
    @(posedge CLK);
    #1;

    #10
    memoryWrite = 1;
    memoryRead = 0;
    memoryAddress = 2;
    memoryWriteData = 16'h7365;
    
    @(posedge CLK);
    #1;

    #10
    memoryWrite = 1;
    memoryRead = 0;
    memoryAddress = 3;
    memoryWriteData = 16'h6775;
    
    @(posedge CLK);
    #1;

    #10
    memoryWrite = 1;
    memoryRead = 0;
    memoryAddress = 4;
    memoryWriteData = 16'h0061;
    
    @(posedge CLK);
    #1;

    memoryWrite = 0;
    memoryRead = 1;
    memoryAddress = 0;
    #1
    $display("memoryOutData=%s memoryAddress=%0d", memoryOutData, memoryAddress);
    
    memoryWrite = 0;
    memoryRead = 1;
    memoryAddress = 1;
    #1
    $display("memoryOutData=%s memoryAddress=%0d", memoryOutData, memoryAddress);
    
    memoryWrite = 0;
    memoryRead = 1;
    memoryAddress = 2;
    #1
    $display("memoryOutData=%s memoryAddress=%0d", memoryOutData, memoryAddress);
    
    memoryWrite = 0;
    memoryRead = 1;
    memoryAddress = 3;
    #1
    $display("memoryOutData=%s memoryAddress=%0d", memoryOutData, memoryAddress);
    
    memoryWrite = 0;
    memoryRead = 1;
    memoryAddress = 4;
    #1
    $display("memoryOutData=%s memoryAddress=%0d", memoryOutData, memoryAddress);
    
    $finish;
end

endmodule

