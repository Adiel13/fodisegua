module memory #(
    parameter WIDTH = 8
) (
    input clk, memoryWrite, memoryRead,
    input [2*WIDTH-1:0] memoryWriteData,
    input [7:0] memoryAddress,
    output logic[2*WIDTH-1:0] memoryOutData
);

logic [2*WIDTH-1:0] mem [0:7];

always_ff @( posedge clk ) begin 
    if(memoryWrite) begin
        mem[memoryAddress[2:0]] <= memoryWriteData;
    end 
end

always_comb begin 
    if (memoryRead) begin
        memoryOutData = mem[memoryAddress[2:0]];
    end
    else begin
            memoryOutData = '0;
    end
end
endmodule