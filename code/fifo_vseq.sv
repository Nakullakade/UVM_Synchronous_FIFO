
class fifo_vseq extends uvm_sequence;
  `uvm_object_utils(fifo_vseq)
  `uvm_declare_p_sequencer(fifo_vseqr)
   
   single_write_seq           sw_seq;
   single_read_seq            sr_seq;
   multiple_write_seq         mw_seq;
   multiple_read_seq          mr_seq;
   alternate_write_read_seq   alt_wr_seq;
   overflow_seq               ovrflw_seq;
   underflow_seq              undrflw_seq;
   full_randomization_seq     frand_seq;
  
  function new(string name="fifo_vseq");
    super.new(name);
  endfunction
  
  virtual task body();
   // `uvm_info("fifo_vseq","inside fifo seq ",UVM_MEDIUM)
    sw_seq=single_write_seq::type_id::create("sw_seq");
    sr_seq=single_read_seq::type_id::create("sr_seq");
    mw_seq=multiple_write_seq::type_id::create("mw_seq");
    mr_seq=multiple_read_seq::type_id::create("mr_seq");
    alt_wr_seq=alternate_write_read_seq::type_id::create("alt_wr_seq");
    ovrflw_seq=overflow_seq::type_id::create("ovrflw_seq");
    undrflw_seq=underflow_seq::type_id::create("underflw_seq");
    frand_seq=full_randomization_seq::type_id::create("frand_seq");
    
    sw_seq.start(p_sequencer.h_ip_seqr);
    sr_seq.start(p_sequencer.h_ip_seqr);
    
    mw_seq.start(p_sequencer.h_ip_seqr);
    mr_seq.start(p_sequencer.h_ip_seqr);
    
    ovrflw_seq.start(p_sequencer.h_ip_seqr);
    undrflw_seq.start(p_sequencer.h_ip_seqr);
    alt_wr_seq.start(p_sequencer.h_ip_seqr);
    frand_seq.start(p_sequencer.h_ip_seqr);
  endtask
  
endclass