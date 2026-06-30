class mem_transaction #(parameter WIDTH = 8) extends uvm_sequence_item;

    rand bit [WIDTH-1:0] addr;
    rand bit [2*WIDTH-1:0] wdata;
    rand bit we;

    `uvm_object_utils(mem_transaction)

    function new(string name = "mem_transaction");
        super.new(name);
    endfunction
    
endclass