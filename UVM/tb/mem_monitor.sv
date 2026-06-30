class mem_monitor extends uvm_component;
`uvm_component_utils(mem_monitor)
    virtual mem_if vif;
    uvm_analysis_port #(mem_transaction) ap;

    function new(string name = "mem_monitor", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);   
    endfunction

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual mem_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", $sformatf("Virtual interface must be set for: %s.vif", get_full_name()));
    endfunction

    task run_phase(uvm_phase phase);
        mem_transaction txn;
        forever begin
            @(posedge vif.clk);
            txn = mem_transaction::type_id::create("txn");
            txn.we = vif.we;
            txn.addr = vif.addr;
            txn.wdata = vif.we ? vif.wdata : vif.rdata;
            ap.write(txn);
        end
    endtask

endclass