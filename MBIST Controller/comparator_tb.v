`timescale 1ns / 1ps
 
module comparator_tb;
reg [7:0] A,B;
wire equal;

comparator #(.data(8)) dut(.opr1(A) ,.opr2(B) ,.equal(equal));

initial begin
    A = 8'h55; B = 8'h55; #10;
    A = 8'h55; B = 8'haa; #10;
    A = 8'haa; B = 8'h55; #10;
    A = 8'haa; B = 8'haa; #10;
    A = 8'h2c; B = 8'hd6; #10;
    A = 8'h1a; B = 8'h1a; #10;
    $finish;
end
endmodule
