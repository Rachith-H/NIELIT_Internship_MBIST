`timescale 1ns / 1ps

module address_generator #(parameter addr=8)(clk,rst,en,address);
input en,clk,rst;
output reg [addr-1:0] address;

always@(posedge clk or posedge rst) begin
    if(rst)
        address <= {addr{1'b0}};
    else
        address <= en ? address+1 : address ;
end

endmodule