class packet extends uvm_sequence_item;
  
  `uvm_object_utils(packet)
  
  bit RED,GREEN,YELLOW;
  
  function new(string name = "packet");
    super.new(name);
  endfunction
endclass