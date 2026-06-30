class mem_scoreboard  #(parameter WIDTH = 8) extends uvm_component;
   `uvm_component_utils(mem_scoreboard)

    bit [2*WIDTH-1:0] ref_mem [2**WIDTH-1:0];

	uvm_analysis_imp#(mem_transaction, mem_scoreboard) analysis_export;

   function new(string name, uvm_component parent);
       super.new(name, parent);
       analysis_export = new("analysis_export", this);
   endfunction

 function void write(mem_transaction txn);
       if(txn.we) begin
           ref_mem[txn.addr] = txn.wdata;
       end else begin
           bit [2*WIDTH-1:0] expected = ref_mem[txn.addr];
           if(txn.wdata !== expected) begin
               `uvm_error("SCOREBOARD", $sformatf("Data mismatch! Addr = %0d Expected=%0b Got=%0b", txn.addr, expected, txn.wdata));
           end else begin
               `uvm_info("SCOREBOARD", $sformatf("Read correct at addr=%0d -> %0b", txn.addr, txn.wdata), UVM_LOW);
           end
       end
   endfunction
  endclass