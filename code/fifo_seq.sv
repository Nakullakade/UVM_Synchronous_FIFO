
class single_write_seq extends uvm_sequence#(fifo_seq_item);
  `uvm_object_utils(single_write_seq)
  fifo_seq_item pkt;
  
  function new(string name="single_write_seq");
    super.new(name);
  endfunction
  
 virtual task body();
   single_write();
 endtask      

  virtual task single_write(); 
    pkt = fifo_seq_item::type_id::create("pkt");
    start_item(pkt);
    assert(pkt.randomize() with {wr == 1; rd == 0;});
    //`uvm_info("seq",$sformatf("Done generation of data is %s items",pkt), UVM_MEDIUM)
    `uvm_info("seq","single write sequence generated !!",UVM_MEDIUM)
   // pkt.print();
    finish_item(pkt);
   endtask
endclass


class single_read_seq extends single_write_seq;
  `uvm_object_utils(single_read_seq)
  fifo_seq_item pkt;
  
  function new(string name="single_read_seq");
    super.new(name);
  endfunction
  
  virtual task body();
     single_read();
  endtask      
  
   virtual task single_read(); 
    pkt = fifo_seq_item::type_id::create("pkt");
     start_item(pkt);
     assert(pkt.randomize() with {wr == 'b0; rd == 'b1; data_in=='b0;});
  //   `uvm_info("seq", $sformatf("Done read of packet is %s items",pkt), UVM_MEDIUM)
     `uvm_info("seq","single read sequence generated !!",UVM_MEDIUM)
  //  pkt.print();
    finish_item(pkt);
 endtask
endclass

class multiple_write_seq extends single_read_seq;
  `uvm_object_utils(multiple_write_seq)
  fifo_seq_item pkt;
  
  function new(string name="multiple_write_seq");
    super.new(name);
  endfunction
  
  virtual task body();
     multiple_write();
  endtask      
  
  virtual task multiple_write();
    repeat(8) begin
     pkt = fifo_seq_item::type_id::create("pkt");
     start_item(pkt);
     assert(pkt.randomize() with {wr == 'b1; rd == 'b0;});
  //   `uvm_info("seq", $sformatf("Done read of packet is %s items",pkt), UVM_MEDIUM)
      `uvm_info("seq","multiple write sequence generated !!",UVM_MEDIUM)
   //  pkt.print();
     finish_item(pkt);
    end
 endtask
endclass


class multiple_read_seq extends multiple_write_seq;
  `uvm_object_utils(multiple_read_seq)
  fifo_seq_item pkt;
  
  function new(string name="multiple_read_seq");
    super.new(name);
  endfunction
  
  virtual task body();
     multiple_read();
  endtask      
  
  virtual task multiple_read();
    repeat(8) begin
    pkt = fifo_seq_item::type_id::create("pkt");
     start_item(pkt);
     assert(pkt.randomize() with {wr == 'b0; rd == 'b1; data_in=='b0;});
  //   `uvm_info("seq", $sformatf("Done read of packet is %s items",pkt), UVM_MEDIUM)
    `uvm_info("seq","multiple read sequence generated !!",UVM_MEDIUM)
  //  pkt.print();
    finish_item(pkt);
    end
 endtask
endclass

class alternate_write_read_seq extends multiple_read_seq;
  `uvm_object_utils(alternate_write_read_seq)
  fifo_seq_item pkt;
  
  function new(string name="alternate_write_read_seq");
    super.new(name);
  endfunction
  
  virtual task body();
     alternate_write_read();
  endtask      
  
  virtual task alternate_write_read();
    repeat(8) begin
    pkt = fifo_seq_item::type_id::create("pkt");
     start_item(pkt);
      assert(pkt.randomize() with {wr == 'b1; rd == 'b0;});
  //   `uvm_info("seq", $sformatf("Done read of packet is %s items",pkt), UVM_MEDIUM)
      `uvm_info("seq","alternate write sequence generated !!",UVM_MEDIUM)
 //   pkt.print();
    finish_item(pkt);
      
      
    pkt = fifo_seq_item::type_id::create("pkt");
    start_item(pkt);
    assert(pkt.randomize() with {wr == 'b0; rd == 'b1; data_in=='b0;});
  //   `uvm_info("seq", $sformatf("Done read of packet is %s items",pkt), UVM_MEDIUM)
      `uvm_info("seq","alternate read sequence generated !!",UVM_MEDIUM)
  //  pkt.print();
    finish_item(pkt);
   end
 endtask
endclass

class overflow_seq extends alternate_write_read_seq;
  `uvm_object_utils(overflow_seq)
  fifo_seq_item pkt;
  
  function new(string name="overflow_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    overflow();
  endtask      
  
  virtual task overflow();
    repeat(12) begin
     pkt = fifo_seq_item::type_id::create("pkt");
     start_item(pkt);
     assert(pkt.randomize() with {wr == 'b1; rd == 'b0;});
  //   `uvm_info("seq", $sformatf("Done read of packet is %s items",pkt), UVM_MEDIUM)
      `uvm_info("seq","overflow sequence generated !!",UVM_MEDIUM)
  //   pkt.print();
     finish_item(pkt);
    end
 endtask
endclass


class underflow_seq extends overflow_seq;
  `uvm_object_utils(underflow_seq)
  fifo_seq_item pkt;
  
  function new(string name="underflow_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    underflow();
  endtask      
  
  virtual task underflow();
    repeat(12) begin
     pkt = fifo_seq_item::type_id::create("pkt");
     start_item(pkt);
      assert(pkt.randomize() with {wr == 'b0; rd == 'b1; data_in=='b0;});
  //   `uvm_info("seq", $sformatf("Done read of packet is %s items",pkt), UVM_MEDIUM)
      `uvm_info("seq","underflow sequence generated !!",UVM_MEDIUM)
  //   pkt.print();
     finish_item(pkt);
    end
 endtask
endclass

class full_randomization_seq extends underflow_seq;
  `uvm_object_utils(full_randomization_seq)
  fifo_seq_item pkt;
  
  function new(string name="full_randomization_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    full_randomization();
  endtask      
  
  virtual task full_randomization();
    repeat(8) begin
     pkt = fifo_seq_item::type_id::create("pkt");
     start_item(pkt);
      assert(pkt.randomize());
  //   `uvm_info("seq", $sformatf("Done read of packet is %s items",pkt), UVM_MEDIUM)
      `uvm_info("seq","full randomization sequence generated !!",UVM_MEDIUM)
  //   pkt.print();
     finish_item(pkt);
    end
 endtask
endclass