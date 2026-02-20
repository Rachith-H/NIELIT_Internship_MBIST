`timescale 1ns / 1ps

module mbist_tb;
parameter addr=3,data=8 ;
reg clk,rst,start;
wire [data-1:0] mem_dout;
wire done,fail,read,write;
wire [addr-1:0]fail_addr,mem_addr;
wire [data-1:0] mem_din;

mbist #(.addr(addr) ,.data(data)) MBISTctrl (clk,rst,start,done,fail,fail_addr,read,write,mem_addr,mem_din,mem_dout);

test_mem #(.addr(addr) ,.data(data)) mem (write,read,clk,mem_din,mem_dout,mem_addr);

always #2 clk = ~clk ;
initial begin 
    clk = 0;
    rst = 1; #3;
    rst = 0;
    start = 1;#4;
    start = 0;
    #400 $finish;
end

initial begin
    force mem.mem[4][2] = 1'b0;
end

initial #200 $finish;
endmodule