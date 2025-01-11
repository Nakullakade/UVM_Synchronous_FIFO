class fifo_test extends uvm_test;
  `uvm_component_utils(fifo_test)
  
  fifo_env h_env;
  fifo_vseq	h_vseq;
  
  function new(string name="fifo_test",uvm_component parent);
    super.new(name,parent);
   //  `uvm_info("Test class","inside test new constructor",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_env=fifo_env::type_id::create("h_env",this);
    h_vseq=fifo_vseq::type_id::create("h_vseq");
  //  `uvm_info("Test class","inside test build_phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  //  `uvm_info("Test class","inside test connect_phase",UVM_MEDIUM)
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   // `uvm_info("Test class","inside test run_phase",UVM_MEDIUM)
    phase.raise_objection(this);
    h_vseq.start(h_env.h_vseqr);
    #100;
    phase.drop_objection(this);
  endtask
  
endclass
    