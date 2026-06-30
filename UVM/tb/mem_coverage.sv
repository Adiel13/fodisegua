class mem_coverage extends uvm_component;
   `uvm_component_utils(mem_coverage)
   uvm_analysis_imp#(mem_transaction, mem_coverage) analysis_export;
   covergroup mem_cg;
       option.per_instance = 1;
       addr_cp: coverpoint addr { bins all_addr[] = {[0:15]}; }
       op_cp: coverpoint we { bins writedata = {1}; bins read = {0}; }
       cross addr_cp, op_cp;
   endgroup
   bit [3:0] addr;
   bit       we;
   function new(string name, uvm_component parent);
       super.new(name, parent);
       mem_cg = new();
       analysis_export = new("analysis_export", this);
   endfunction
   function void write(mem_transaction txn);
       addr  = txn.addr;
       we = txn.we;
       mem_cg.sample();
   endfunction
endclass