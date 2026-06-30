module tb_top;

`include "uvm_macros.svh"

import uvm_pkg::*;
import tb_package::*;

logic clk;
initial forever #5 clk = ~clk;

mem_if memif(clk);

memory dut (
    .clk(clk),
    .we(memif.we),
    .addr(memif.addr),
    .wdata(memif.wdata),
    .rdata(memif.rdata)
);

initial begin
    clk = 0;
    $dumpvars(0, dut);
    
end

initial begin
    uvm_config_db#(virtual mem_if)::set(null, "env.mem_agent", "vif", memif);
    run_test();
end

endmodule