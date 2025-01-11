`include "uvm_macros.svh" 
import uvm_pkg::*;

`include "fifo_pkg.sv"
import fifo_pkg::*;

`include "fifo_interface.sv"

module tb_top;
  bit clk,rst;
  
  parameter clk_period=10;
  parameter rst_period=4;
  
  fifo_intf intf(clk,rst);
  
  fifo_dut i_fifo_dut(.clk(clk),.rst(rst),
                      .data_in(intf.data_in),
                      .data_out(intf.data_out),
                      .wr(intf.wr),.rd(intf.rd),
                      .fifo_cnt(intf.fifo_cnt),
                      .empty(intf.empty),.full(intf.full));
  
  initial begin
    clk_gen();
  end
  
  initial begin
    rst_gen();
  end
      
  
  task clk_gen();
    clk='b0;
    forever begin
      #(clk_period/2) clk=~clk;
    end
  endtask
  
  task rst_gen();
    rst='b1;
    #(rst_period);
    rst='b0;
    #(rst_period);
     rst='b1;
  endtask
  
  initial begin
    uvm_config_db #(virtual fifo_intf)::set(null,"*","intf1",intf);
    run_test("fifo_test");
  end
  
   initial begin
    #800;
    $finish;
  end
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
