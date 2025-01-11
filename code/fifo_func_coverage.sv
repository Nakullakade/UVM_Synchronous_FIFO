class fifo_func_coverage extends uvm_subscriber#(fifo_seq_item);
  `uvm_component_utils(fifo_func_coverage)
  fifo_seq_item pkt1;
  
  covergroup cg;
    cp1:coverpoint pkt1.data_in{bins b1[8]={[0:255]};}
    cp2:coverpoint pkt1.data_out{bins b2[8]={[0:255]};}
    cp3:coverpoint pkt1.wr{bins b3[2]={[0:1]};}
    cp4:coverpoint pkt1.rd{bins b4[2]={[0:1]};}
    cp6:coverpoint pkt1.full{bins b6[2]={[0:1]};}
    cp7:coverpoint pkt1.empty{bins b7[2]={[0:1]};}
  endgroup
  
  function new(string name="fifo_func_coverage", uvm_component parent);
    super.new(name,parent);
    cg = new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
  
  virtual function void write(fifo_seq_item t);
    pkt1=t;
    cg.sample();
    `uvm_info("coverage",$sformatf("the functional coverage is %0d",cg.get_coverage()),UVM_MEDIUM)
  endfunction
endclass