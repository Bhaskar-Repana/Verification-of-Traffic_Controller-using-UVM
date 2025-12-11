class environment extends uvm_env;
  
  `uvm_component_utils(environment)
  
  monitor mon;
  scoreboard sb;
  
  function new (string name = "environment",uvm_component parent =null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = monitor::type_id::create("mon",this);
    sb = scoreboard::type_id::create("sb",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mon.mon_port.connect(sb.sb_imp_port);
  endfunction
  
endclass