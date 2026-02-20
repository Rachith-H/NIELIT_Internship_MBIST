`timescale 1ns / 1ps

module mbist #(parameter addr=4 , data=8)
(clk,rst,start,done,fail,fail_addr,read,write,mem_addr,mem_din,mem_dout);
input clk,rst,start;
input [data-1:0] mem_dout;
output done,fail,read,write;
output [addr-1:0]fail_addr,mem_addr;
output [data-1:0] mem_din;

wire addr_en,equal,pat_sel,force0,mux_in1,mux_in0,mux_sel,delay_data ;
wire [data-1:0] op1,pat_out ;
wire [addr-1:0] addr_out ;
reg [data-1:0] op2;

controller #(.addr(addr) ,.data(data)) ctrl (.clk(clk),.address_en(addr_en)
             ,.rst(rst),.start(start),.equal(equal),.address(addr_out)
             ,.force_0(force0),.pat_sel(mux_sel),.read(read),.write(write)
             ,.done(done),.fail(fail),.delay_data(delay_data),.fail_addr(fail_addr));
           
address_generator #(.addr(addr)) addr_gen (.clk(clk),.rst(rst),.en(addr_en),.address(addr_out));

comparator #(.data(data)) compare (.opr1(op1),.opr2(op2),.equal(equal));

test_pattern_gen #(.data(data)) pattern_gen (.pat_sel(pat_sel),.all0(force0),.pat_out(pat_out));

always@(posedge clk) begin
    if(delay_data)
        op2 <= pat_out ;
    else 
        op2 <= 0;
end

assign mem_addr = addr_out;
assign mem_din = pat_out;
assign op1 = mem_dout;
assign mux_in0 = addr_out[0];
assign mux_in1 = ~addr_out[0];
assign pat_sel = mux_sel ? mux_in1 : mux_in0 ;

endmodule











