`timescale 1ns / 1ps

module comparator #(parameter data=4)(opr1,opr2,equal);
input [data-1:0] opr1,opr2;
output reg equal;

always@(*) begin
    if(opr1==opr2)
        equal = 1'b1;
    else
        equal = 1'b0;
end

endmodule