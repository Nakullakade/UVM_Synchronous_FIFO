class op_monitor extends uvm_monitor;
  `uvm_component_utils(op_monitor)
   virtual fifo_intf vif;
   fifo_seq_item pkt;
  
  uvm_analysis_port#(fifo_seq_item) op_mon2scbd;
  
  function new(string name="op_monitor",uvm_component parent);
    super.new(name,parent);
   // `uvm_info("op mon class","inside op mon class new",UVM_MEDIUM)
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    op_mon2scbd=new("op_mon2scbd",this);
   // `uvm_info("op mon class","inside op mon class build phase",UVM_MEDIUM)
  
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
      //  `uvm_info("op mon class","inside op mon class build phase",UVM_MEDIUM)
     if(!uvm_config_db #(virtual fifo_intf)::get(this,"","intf1",vif)) begin
       `uvm_fatal("op_mon","danger !!")
    end
    `uvm_info("op mon","inside op monitor build phase",UVM_MEDIUM)
  endfunction
  
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
      //  `uvm_info("op mon class","inside op mon class build phase",UVM_MEDIUM)
     forever begin
       @(posedge vif.clk);
       if(vif.rst=='b1 && vif.wr=='b0 && vif.rd=='b1)
        begin
        pkt=fifo_seq_item::type_id::create("pkt");
        pkt.data_out=vif.data_out;
        pkt.wr=vif.wr;
        pkt.rd=vif.rd;
        pkt.fifo_cnt=vif.fifo_cnt;
        pkt.full=vif.full;
        pkt.empty=vif.empty;
        op_mon2scbd.write(pkt);
    //   `uvm_info("op monitor","output data packet is recieved !!",UVM_MEDIUM)
    //    pkt.print();
       end
      end
  endtask
endclass