class mem_test extends uvm_test;

`uvm_component_utils(mem_test)

mem_env env;
mem_seq seq;

function new(string name = "mem_test", uvm_component parent = null);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = mem_env::type_id::create("env", this);
    seq = mem_seq::type_id::create("seq", this);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
endfunction 

task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agent.sequencer);
    phase.drop_objection(this);
endtask

endclass