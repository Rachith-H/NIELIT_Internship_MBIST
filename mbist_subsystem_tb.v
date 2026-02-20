`timescale 1ns / 1ps

module mbist_subsystem_tb;
parameter addr=3,data=8;
reg clk,test_mode,rst,start,cpu_rd,cpu_wr;
reg [addr-1:0] cpu_addr;
reg [data-1:0] cpu_din;
wire [data-1:0] dout;
wire done,fail,read,write;
wire [addr-1:0] fail_addr,address;
wire [data-1:0] din,mem_dout;

mbist_subsystem #(.addr(addr) ,.data(data)) mbist_block (test_mode,clk,rst,start,done,fail,fail_addr,
                                            cpu_rd,cpu_wr,cpu_addr,cpu_din,
                                            read,write,address,din,dout,mem_dout);

test_mem #(.addr(addr) ,.data(data)) mem (write,read,clk,din,dout,address);

always #2 clk = ~clk;
initial begin 
    clk = 0;
    test_mode = 1;
    cpu_rd = 0; cpu_wr = 0;
    cpu_addr = 3'b000 ;
    cpu_din = 8'h00;
    
    rst = 1 ; #3;
    rst = 0;
    start = 1; #4;
    start = 0;
    #300 $finish;
end
/*
initial begin
    force mem.mem[4][2] = 1'b0;
end
*/
initial #200 $finish ;
endmodule
