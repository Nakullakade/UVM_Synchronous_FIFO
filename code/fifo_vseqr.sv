class fifo_vseqr extends uvm_sequencer;
  `uvm_component_utils(fifo_vseqr)
  
  ip_seqr h_ip_seqr;
  
  function new(string name="fifo_vseqr",uvm_component parent);
    super.new(name,parent);
   // `uvm_info("virtual seq class","inside vseqr new meth",UVM_MEDIUM)
  endfunction
  
  virtual task body();
  // `uvm_info("Virtual sequence", "Inside virtual sequence",UVM_MEDIUM)
    h_ip_seqr =ip_seqr::type_id::create("h_ip_seqr",this);
  endtask
endclass