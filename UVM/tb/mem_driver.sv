class mem_driver extends uvm_driver #(mem_transaction);
`uvm_component_utils(mem_driver)
virtual mem_if vif;

function new(string name = "mem_driver", uvm_component parent = null);
    super.new(name, parent);
endfunction 

task run_phase(uvm_phase phase);
    forever begin
        mem_transaction txn;
        seq_item_port.get_next_item(txn);
        vif.we = txn.we;
        vif.addr = txn.addr;
        vif.wdata = txn.wdata;
        @(negedge vif.clk);
        vif.we <= 0;
        @(negedge vif.clk);
        seq_item_port.item_done();
    end
endtask

function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual mem_if)::get(this, "", "vif", vif))
        `uvm_fatal("NOVIF", $sformatf("Virtual interface must be set for: %s.vif", get_full_name()));
endfunction
endclass
