class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)
  
  `uvm_analysis_imp_decl(_ip_imp)
  `uvm_analysis_imp_decl(_op_imp)
  
  uvm_analysis_imp_ip_imp #(fifo_seq_item,fifo_scoreboard) ip_mon2scbd_imp_port;
  uvm_analysis_imp_op_imp #(fifo_seq_item,fifo_scoreboard) op_mon2scbd_imp_port;
  
  int pass=0;
  int fail=0;
  
  fifo_seq_item seq_item;
  fifo_seq_item g_exp_data_q[$];
  fifo_seq_item g_act_data_q[$];
  fifo_seq_item act_data;
  fifo_seq_item exp_data;
  
  function new(string name = "fifo_scoreboard",uvm_component parent);
    super.new(name, parent);
   // `uvm_info("scoreboard class","inside scoreboard class new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ip_mon2scbd_imp_port=new("ip_mon2scbd_imp_port",this);
    op_mon2scbd_imp_port=new("op_mon2scbd_imp_port",this);
   // `uvm_info("scoreboard class","inside scoreboard class build phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   // `uvm_info("scoreboard class","inside scoreboard class connect phase",UVM_MEDIUM)
  endfunction
  
  function void write_ip_imp(fifo_seq_item seq_item);
     // ip_mon2scbd_imp_port.get_next_item(seq_item);
    g_exp_data_q.push_back(seq_item);
    seq_item.print();
  endfunction
  
 function void write_op_imp(fifo_seq_item seq_item);
     // op_mon2scbd_imp_port.get_next_item(seq_item);
   if(seq_item.data_out>0)begin
     g_act_data_q.push_back(seq_item);
   end
   seq_item.print();
 endfunction
 
    
 virtual task compare();
   forever begin
        exp_data=new();
        act_data=new();
        wait(g_exp_data_q.size()>0);
        wait(g_act_data_q.size()>0);
        exp_data=g_exp_data_q.pop_front();
        act_data=g_act_data_q.pop_front();
        
   if(exp_data.data_in==act_data.data_out) 
        begin
          `uvm_info("scoreboard","DATA is matched !!",UVM_MEDIUM)
          $display("exp data=%0d, act data=%0d",exp_data.data_in,act_data.data_out);
          pass=pass+1;
        end
        else 
          begin
          `uvm_info("scoreboard","DATA is not matched !!",UVM_MEDIUM)
            $display("exp data=%0d, act data=%0d",exp_data.data_in,act_data.data_out);
          fail=fail+1;
          end
        //  $display("passed=%0d,failed=%0d",pass,fail);
          $display(" ");
          end
   endtask
  
   task run_phase(uvm_phase phase);
    super.run_phase(phase);
   // `uvm_info("scoreboard class","inside scoreboard class run phase",UVM_MEDIUM)
      compare();
  endtask
  
  virtual function void report_phase(uvm_phase phase);
    if(pass>fail) begin
      `uvm_info("report testcases passed !!",$sformatf("pass count=%0d, fail count=%0d",pass,fail),UVM_MEDIUM)
    end
    else begin
      `uvm_info("report testcases failed !!",$sformatf("pass count=%0d, fail count=%0d",pass,fail),UVM_MEDIUM)
    end
  endfunction
  
endclass