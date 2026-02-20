`timescale 1ns / 1ps

module test_pat_gen_tb;
reg sel,force0;
wire [7:0] pattern;

test_pattern_gen #(.data(8)) dut(.pat_sel(sel) ,.pat_out(pattern) ,.all0(force0));

initial begin
    #10 sel = 0 ;
    force0 = 0;
    repeat(5) begin
     #15 sel = ~sel ;
    end
    #10 $finish;
end

initial begin
    force0 = #25 1'b1;
    force0 = #40 1'b0;
end

endmodule
