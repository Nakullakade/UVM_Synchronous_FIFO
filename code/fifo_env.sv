class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)
  
  fifo_vseqr          h_vseqr;
  ip_agent            h_ip_agent;
  op_agent            h_op_agent;
  fifo_scoreboard     h_scbd;
  fifo_func_coverage  h_cov;
  
  function new(string name="fifo_env",uvm_component parent);
    super.new(name,parent);
  //  `uvm_info("env class","inside env new constructor",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_vseqr=    fifo_vseqr::type_id::create("h_vseqr",this);
    h_ip_agent= ip_agent::type_id::create("h_ip_agent",this);
    h_op_agent= op_agent::type_id::create("h_op_agent",this);
    h_scbd=     fifo_scoreboard::type_id::create("h_scbd",this);
    h_cov=      fifo_func_coverage::type_id::create("h_cov",this);
   // `uvm_info("env class","inside env build phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     h_vseqr.h_ip_seqr = h_ip_agent.h_ip_seqr;
    h_ip_agent.h_ip_mon.ip_mon2scbd.connect(h_scbd.ip_mon2scbd_imp_port);
    h_op_agent.h_op_mon.op_mon2scbd.connect(h_scbd.op_mon2scbd_imp_port);
    h_ip_agent.h_ip_mon.ip_mon2scbd.connect(h_cov.analysis_export);
    h_op_agent.h_op_mon.op_mon2scbd.connect(h_cov.analysis_export);
   // `uvm_info("env class","inside env connect phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   // `uvm_info("env class","inside env run phase",UVM_MEDIUM)
  endtask
  
endclass
    
    
  