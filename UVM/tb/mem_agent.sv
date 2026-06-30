class mem_agent extends uvm_component;
`uvm_component_utils(mem_agent)
mem_driver driver;
mem_monitor monitor;
uvm_sequencer #(mem_transaction) sequencer;

function new(string name = "mem_agent", uvm_component parent = null);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    driver = mem_driver::type_id::create("driver", this);
    monitor = mem_monitor::type_id::create("monitor", this);
    sequencer = uvm_sequencer #(mem_transaction)::type_id::create("sequencer", this);
endfunction

function void connect_phase(uvm_phase phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction

endclass