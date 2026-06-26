`include "uvm_macros.svh"
import uvm_pkg::*;

program automatic test;

class hello_world extends uvm_test;

  `uvm_component_utils(hello_world)

  function new(string name = "hello_world", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    `uvm_info("HELLO_WORLD", "Hello, UVM World!", UVM_LOW)
  endtask
endclass
  initial run_test();
endprogram