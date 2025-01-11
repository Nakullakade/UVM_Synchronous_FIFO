class ip_agent extends uvm_agent;
  `uvm_component_utils(ip_agent)
  
  ip_seqr    h_ip_seqr;
  ip_driver  h_driv;
  ip_monitor h_ip_mon;
  
  function new(string name="ip_agent",uvm_component parent);
    super.new(name,parent);
   // `uvm_info("ip agent class","inside ip agent new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_ip_seqr= ip_seqr::type_id::create("h_ip_seqr",this);
    h_driv=    ip_driver::type_id::create("h_driv",this);
    h_ip_mon=  ip_monitor::type_id::create("h_ip_mon",this);
   // `uvm_info("ip agent class","inside ip agent build phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    h_driv.seq_item_port.connect(h_ip_seqr.seq_item_export);
   // `uvm_info("ip agent class","inside ip agent connect phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   // `uvm_info("ip agent class","inside ip agent run phase",UVM_MEDIUM)
  endtask
  
endclass
  
  