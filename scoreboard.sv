class scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp #(packet,scoreboard) sb_imp_port;
  
  int red_count,green_count,yellow_count;
  
  typedef enum {RED,GREEN,YELLOW} state_t;
  state_t prev_state;
  
  function new(string name = "scoreboard",uvm_component parent = null);
    super.new(name,parent);
    sb_imp_port = new("sb_imp_port",this);
  endfunction
  
  function void write(packet pkt);
    
    if(pkt.RED + pkt.GREEN + pkt.YELLOW != 1)
      `uvm_error("SCOREBOARD", "More than one signal active high")

    
    if(pkt.RED) red_count++;
    if(pkt.GREEN) green_count++;
    if(pkt.YELLOW) yellow_count++;
    
    if(prev_state == RED && pkt.GREEN) begin
      if(red_count != 10) 
        `uvm_error("SCORE", $sformatf("RED timing mismatch. Expected 10, got %0d", red_count));
            red_count = 0;
    end
    
    if(prev_state == GREEN && pkt.YELLOW) begin
      if(green_count != 15) 
        `uvm_error("SCORE", $sformatf("GREEN timing mismatch. Expected 15, got %0d", green_count));
            green_count = 0;
    end
    
    if(prev_state == YELLOW && pkt.RED) begin
      if(yellow_count != 5) 
        `uvm_error("SCORE", $sformatf("YELLOW timing mismatch. Expected 5, got %0d", yellow_count));
            yellow_count = 0;
      end
    
    if(pkt.RED) prev_state = RED;
    if(pkt.GREEN) prev_state = GREEN;
    if(pkt.YELLOW) prev_state = YELLOW;
    
  endfunction
  
endclass
      
      
  
  