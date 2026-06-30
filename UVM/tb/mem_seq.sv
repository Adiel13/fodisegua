class mem_seq extends uvm_sequence #(mem_transaction);

`uvm_object_utils(mem_seq)
    function new(string name = "mem_seq");
        super.new(name);
    endfunction

task body();
    mem_transaction txn;
    int num_bits;
    num_bits = 8;  // Width of address bus

    for(int i = 0; i < 10; i++) begin
        txn = mem_transaction::type_id::create("txn");

        assert(txn.randomize());
        txn.we = 1;
        txn.addr = i;

        start_item(txn);
        finish_item(txn);

    end

    repeat(100) begin
        txn = mem_transaction::type_id::create("txn");

        assert(txn.randomize());
        txn.we = 0;

        start_item(txn);
        finish_item(txn);

    end

endtask

endclass