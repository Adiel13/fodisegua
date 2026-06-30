class mem_env extends uvm_env;
`uvm_component_utils(mem_env)
mem_agent agent;
mem_scoreboard scoreboard;
mem_coverage coverage;

function new(string name = "mem_env", uvm_component parent = null);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = mem_agent::type_id::create("agent", this);
    scoreboard = mem_scoreboard::type_id::create("scoreboard", this);
    coverage = mem_coverage::type_id::create("coverage", this);
endfunction

function void connect_phase(uvm_phase phase);
    agent.monitor.ap.connect(scoreboard.analysis_export);
    agent.monitor.ap.connect(coverage.analysis_export);
endfunction

endclass