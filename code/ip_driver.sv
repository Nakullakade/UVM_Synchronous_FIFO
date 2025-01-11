
class ip_driver extends uvm_driver#(fifo_seq_item);
  `uvm_component_utils(ip_driver)
  
  virtual fifo_intf vif;
  fifo_seq_item pkt;
  
  function new(string name="ip_driver",uvm_component parent);
    super.new(name,parent);
   // `uvm_info("ip driver class","inside ip driver new",UVM_MEDIUM)
 endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual fifo_intf)::get(this,"","intf1",vif)) begin
      `uvm_fatal("ip_driver","danger !!")
    end
    `uvm_info("ip driver class","inside ip driver build phase",UVM_MEDIUM)
    pkt=fifo_seq_item::type_id::create("pkt");
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //`uvm_info("ip driver class","inside ip driver connect phase",UVM_MEDIUM)
  endfunction
  
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    //wait(vif.rst=='b1);
    forever begin
       @(posedge vif.clk);
      seq_item_port.get_next_item(pkt);
        vif.data_in<=pkt.data_in;
        vif.wr<=pkt.wr;
        vif.rd<=pkt.rd;
        seq_item_port.item_done();
     end
    `uvm_info("ip driver ","generated packet is sent !!",UVM_MEDIUM)
   // pkt.print();
endtask 
endclass