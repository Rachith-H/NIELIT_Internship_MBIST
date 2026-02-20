`timescale 1ns / 1ps

module mem_wrapper #(parameter addr=4 , data=8)
(mbist_rd,mbist_wr,mbist_din,mbist_addr,
cpu_rd,cpu_wr,cpu_addr,cpu_din,mem_dout,
test_mode,read,write,address,din,dout);

input mbist_rd,mbist_wr,cpu_rd,cpu_wr,test_mode;
input [addr-1:0] cpu_addr,mbist_addr ;
input [data-1:0] mbist_din,cpu_din,dout ;
output read,write;
output [data-1:0] din;
output [addr-1:0] address;
output [data-1:0]mem_dout;

assign read = test_mode ? mbist_rd : cpu_rd ;
assign write = test_mode ? mbist_wr : cpu_wr ;
assign din = test_mode ? mbist_din : cpu_din ;
assign address = test_mode ? mbist_addr : cpu_addr;
assign mem_dout = dout ;

endmodule
