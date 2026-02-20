`timescale 1ns / 1ps
 
module test_pattern_gen #(parameter data=4)(pat_sel,all0,pat_out);
input all0,pat_sel ;
output reg [data-1:0] pat_out ;

always@(*) begin
    if(all0)
        pat_out = {data{1'b0}};
    else if(pat_sel)
        pat_out = {(data>>1){2'b01}} ;
    else
        pat_out = {(data>>1){2'b10}} ;
end

endmodule