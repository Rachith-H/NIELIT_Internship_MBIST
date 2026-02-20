`timescale 1ns / 1ps

module address_gen_tb;
reg clk,en,rst;
wire [3:0] address ;

address_generator #(.addr(4)) dut(.clk(clk) ,.en(en) ,.rst(rst) ,.address(address));

always #5 clk = ~clk;
initial begin 
    clk = 0;
    en = 0;
    rst = 0 ; #8;
    rst = 1; #3;
    en = 1; #5;
    rst = 0; #100;
    rst = 1; #3;
    rst = 0; #20;
    en = 0; #30;
    en = 1;
    #180 $finish;
end

endmodule
