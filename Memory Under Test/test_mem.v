`timescale 1ns / 1ps

module test_mem #(parameter addr=4 , data=8 ) 
(wen,ren,clk,din,dout,address);
input wen,ren,clk;
input [data-1:0] din;
input [addr-1:0]address;
output reg [data-1:0] dout;

reg [data-1:0] mem [0:(1<<addr)-1] ;
wire write,read;

assign write = wen& ~ren ;
assign read = ren & ~wen;

always@(posedge clk) begin
    if(write) begin
        mem[address] <= din;
        dout <= {data{1'b0}};
    end
    else if(read) begin
        dout <= mem[address];
    end
end

endmodule
