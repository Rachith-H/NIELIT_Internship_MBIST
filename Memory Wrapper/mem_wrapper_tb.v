`timescale 1ns / 1ps

module mem_wrapper_tb;
parameter addr=3,data=8;
reg mbist_rd,mbist_wr,cpu_rd,cpu_wr,test_mode,clk;
reg [addr-1:0] cpu_addr,mbist_addr ;
reg [data-1:0] mbist_din,cpu_din ;
wire [data-1:0] dout;
wire read,write;
wire [data-1:0] din;
wire [addr-1:0] address;
wire [data-1:0]mem_dout;

mem_wrapper #(.addr(addr),.data(data)) wrapper (mbist_rd,mbist_wr,mbist_din,mbist_addr,
                                                cpu_rd,cpu_wr,cpu_addr,cpu_din,mem_dout,
                                                test_mode,read,write,address,din,dout);

test_mem #(.addr(addr) ,.data(data)) mem (write,read,clk,din,dout,address);

always #5 clk = ~clk ;
initial begin 
    clk = 0;
   
    test_mode = 1;
    mbist_rd = 0;
    mbist_wr = 1;
    mbist_din = 8'hff;
    mbist_addr = 3'h2;
    cpu_rd = 0;
    cpu_wr = 1;
    cpu_din = 8'hdd;
    cpu_addr = 3'h4;
    
    #50 test_mode = 0;
    mbist_rd = 1;
    mbist_wr = 0;
    mbist_din = 8'hcc;
    mbist_addr = 3'h4;
    cpu_rd = 1;
    cpu_wr = 0;
    cpu_din = 8'hdd;
    cpu_addr = 3'h2;
    #50 $finish;
end
endmodule
