module memory #(
    parameter WIDTH = 8
) (
    input clk, memoryWrite, memoryRead,
    input [2*WIDTH-1:0] memoryWriteData,
    input [7:0] memoryAddress,
    output logic[2*WIDTH-1:0] memoryOutData
);

logic [2*WIDTH-1:0] mem [0:7];
logic [2:0] addr;

assign addr = memoryAddress[2:0];

always_ff @(posedge clk) begin
    if (memoryWrite) begin
        mem[addr] <= memoryWriteData;
    end
end

// Synchronous read: register the output on the clock edge to avoid
// combinational-race timing issues and to make the output transitions
// observable at clock boundaries (improves toggle/cycle coverage).
always_ff @(posedge clk) begin
    if (memoryRead) begin
        memoryOutData <= mem[addr];
    end else begin
        memoryOutData <= '0;
    end
end
endmodule