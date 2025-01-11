class fifo_seq_item extends uvm_sequence_item;
 // `uvm_object_utils(fifo_seq_item)
  randc bit [7:0]data_in;
  bit [7:0]data_out;
  bit [3:0]fifo_cnt;
  bit empty;
  bit full;
  randc bit wr;
  randc bit rd;
  function new(string name = "fifo_seq_item");
    super.new(name);
  //  `uvm_info("fifo seq item class","inside seq item new constructor",UVM_MEDIUM)
  endfunction
  
  `uvm_object_utils_begin(fifo_seq_item)
  `uvm_field_int(data_in, UVM_ALL_ON)
  `uvm_field_int(rd, UVM_ALL_ON)
  `uvm_field_int(wr, UVM_ALL_ON)
  `uvm_field_int(full, UVM_ALL_ON)
  `uvm_field_int(empty, UVM_ALL_ON)
  `uvm_field_int(fifo_cnt,UVM_ALL_ON)
  `uvm_field_int(data_out, UVM_ALL_ON)
  `uvm_object_utils_end
endclass