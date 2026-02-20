`timescale 1ns / 1ps
module mbist_subsystem#(parameter addr=4 , data=8)
(test_mode,clk,rst,start,done,fail,fail_addr,
cpu_rd,cpu_wr,cpu_addr,cpu_din,
read,write,address,din,dout,mem_dout);

input clk,test_mode,rst,start,cpu_rd,cpu_wr;
input [addr-1:0] cpu_addr;
input [data-1:0] cpu_din,dout;
output done,fail,read,write;
output [addr-1:0] fail_addr,address;
output [data-1:0] din,mem_dout;

wire mbist_rd,mbist_wr;
wire [addr-1:0] mbist_addr;
wire [data-1:0] mbist_din;

mem_wrapper #(.addr(addr) ,.data(data)) wrapper (mbist_rd,mbist_wr,mbist_din,mbist_addr,
                                        cpu_rd,cpu_wr,cpu_addr,cpu_din,mem_dout,
                                        test_mode,read,write,address,din,dout);

mbist #(.addr(addr) ,.data(data)) mbist_ctrl (clk,rst,start,done,fail,fail_addr,
                                  mbist_rd,mbist_wr,mbist_addr,mbist_din,mem_dout);

endmodule
