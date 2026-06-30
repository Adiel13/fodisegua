interface mem_if #(parameter WIDTH = 0) (input logic clk);
    logic we;
    logic [WIDTH-1:0] addr;
    logic [WIDTH-1:0] wdata;
    logic [WIDTH-1:0] rdata;    

    modport DUT (input clk, we, addr, wdata, output rdata);
    modport DRIVER (input clk, output we, addr, wdata, input rdata);
    
endinterface