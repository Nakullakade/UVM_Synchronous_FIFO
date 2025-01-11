class ip_monitor extends uvm_monitor;
  `uvm_component_utils(ip_monitor)
   virtual fifo_intf vif;
   fifo_seq_item pkt;
   uvm_analysis_port#(fifo_seq_item) ip_mon2scbd;
  
  function new(string name="ip_monitor",uvm_component parent);
    super.new(name,parent);
   // `uvm_info("ip mon class","inside ip mon new",UVM_MEDIUM)
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ip_mon2scbd=new("ip_mon2scbd",this);
   // `uvm_info("ip mon class","inside ip mon build phase",UVM_MEDIUM)
    if(!uvm_config_db #(virtual fifo_intf)::get(this,"","intf1",vif)) begin
      `uvm_fatal("ip_mon","danger !!")
    end
    `uvm_info("ip mon ","inside ip monitor build phase",UVM_MEDIUM)
    
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   // `uvm_info("ip mon class","inside ip mon connect phase",UVM_MEDIUM)
  endfunction
  
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   // `uvm_info("ip mon class","inside ip mon run phase",UVM_MEDIUM)
    `uvm_info("ip monitor class","inside ip monitor run phase",UVM_MEDIUM)
    //wait(vif.rst=='b1);
    forever begin
      @(posedge vif.clk);
      if(vif.rst=='b1 && vif.wr=='b1 && vif.rd=='b0)
        begin
        pkt=fifo_seq_item::type_id::create("pkt");
        pkt.data_in=vif.data_in;
        pkt.wr=vif.wr;
        pkt.rd=vif.rd;
        pkt.fifo_cnt=vif.fifo_cnt;
        pkt.full=vif.full;
        pkt.empty=vif.empty;
        ip_mon2scbd.write(pkt);
    //  `uvm_info("ip monitor","input data packet is recieved !!",UVM_MEDIUM)
    //  pkt.print();
       end
     end
   endtask
endclass