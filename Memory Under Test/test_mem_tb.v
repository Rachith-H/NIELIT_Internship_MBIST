`timescale 1ns / 1ps

module test_mem_tb;
reg wen,ren;
reg [3:0]address;
reg [7:0]din;
wire [7:0]dout;
reg clk;

test_mem #(.addr(4) ,.data(8)) mem (wen,ren,clk,din,dout,address);

integer i;

initial begin 
    for(i=0 ; i<16 ; i=i+1)
        mem.mem[i] = 8'h00;
end


always #5 clk = ~clk;
initial begin
    clk = 0;
    ren = 0;
    wen = 1;
    address = 4'b0001;
    din = 8'haa;#7;
    address = 4'b0010;
    din = 8'hbb;#10;
    address = 4'b0011;
    din = 8'hcc;#10;
    din = 8'h0;
    ren = 1;#5;
    wen = 0;
    address = 4'b0001; #10;
    address = 4'b0010; #10;
    address = 4'b0011 ; #10;
    $finish;
end
endmodule