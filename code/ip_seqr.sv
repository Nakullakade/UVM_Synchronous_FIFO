class ip_seqr extends uvm_sequencer#(fifo_seq_item);
  `uvm_component_utils(ip_seqr)
  
  function new(string name="ip_seqr",uvm_component parent);
    super.new(name,parent);
  //  `uvm_info("ip seqr class","inside ip seqr new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   // `uvm_info("ip seqr class","inside ip seqr build phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   // `uvm_info("ip seqr class","inside ip seqr connect phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  //  `uvm_info("ip seqr class","inside ip seqr run phase",UVM_MEDIUM)
  endtask
  
endclass