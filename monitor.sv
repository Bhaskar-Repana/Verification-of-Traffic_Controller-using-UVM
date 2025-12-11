class monitor extends uvm_monitor ;
  
  `uvm_component_utils(monitor);
  
  virtual traffic_intf vif;
  uvm_analysis_port #(packet) mon_port;
  
  function new(string name = "monitor",uvm_component parent = null);
    super.new(name,parent);
    mon_port = new("mon_port",this);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual traffic_intf)::get(this,"","vif",vif))
      `uvm_error(get_type_name(),"interface not set at top level");
  endfunction
  
  task run_phase(uvm_phase phase);
    packet pkt;
    
    forever begin
      @(posedge vif.clock)
      
      pkt = packet::type_id::create("pkt");
      
      pkt.RED = vif.RED;
      pkt.GREEN = vif.GREEN;
      pkt.YELLOW =  vif.YELLOW;
      
      mon_port.write(pkt);
    end
  endtask
endclass
      
    