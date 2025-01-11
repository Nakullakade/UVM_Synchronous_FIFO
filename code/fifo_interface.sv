interface fifo_intf(input logic clk,rst);
  logic wr,rd;
  logic empty,full;
  logic [7:0]data_in;
  logic [7:0]data_out;
  logic [3:0]fifo_cnt;
endinterface