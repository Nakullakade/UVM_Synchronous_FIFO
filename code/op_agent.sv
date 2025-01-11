class op_agent extends uvm_agent;
  `uvm_component_utils(op_agent)
  
  op_monitor h_op_mon;
  
  function new(string name="op_agent",uvm_component parent);
    super.new(name,parent);
   // `uvm_info("ip agent class","inside ip agent new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_op_mon=op_monitor::type_id::create("h_op_mon",this);
   // `uvm_info("ip agent class","inside ip agent build phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   // `uvm_info("ip agent class","inside ip agent connect phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   // `uvm_info("ip agent class","inside ip agent run phase",UVM_MEDIUM)
  endtask
endclass