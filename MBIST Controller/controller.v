`timescale 1ns / 1ps

module controller#(parameter addr=4 , data=8)
(clk,address_en,rst,start,equal,address,force_0,pat_sel,read,write,delay_data,done,fail,fail_addr);

input rst,start,equal,clk;
input [addr-1:0] address;
output reg force_0,pat_sel,address_en,delay_data,read,write,done,fail;
output reg [addr-1:0] fail_addr;

localparam IDLE=3'b000 ,WR0=3'b001 ,RD0=3'b010 ,WR1=3'b011, RD1=3'b100 ,DONE=3'b101 ;
reg [2:0] state;

always@(posedge clk or posedge rst) begin
    if(rst) begin
        state <= IDLE;
        address_en <= 1'b0;
        pat_sel <= 1'b0;
        read <= 1'b0;
        write <= 1'b0;
        delay_data <= 1'b0;
        done <= 1'b0;
        fail <= 1'b0;
        force_0 <= 1'b0;
        fail_addr <= {addr{1'b0}};
    end
    
    else begin
        case(state)
            IDLE : begin
                state <= start ? WR0 : IDLE ;
            end
            WR0 : begin
                write <= 1'b1;
                address_en <= 1'b1;
                if (address=={addr{1'b1}}) begin
                    write <= 1'b0;
                    read <= 1'b1;
                    state <= RD0;
                    delay_data <= 1'b1;
                end
            end
            RD0 : begin 
                if(!equal)begin
                    fail <= 1'b1;
                    done <= 1'b1;
                    fail_addr <= address-1;
                    write <= 1'b0;
                    read <= 1'b0;
                    state <= IDLE;
                    address_en <= 1'b0;
                end
                else if (address=={addr{1'b1}}) begin
                    write <= 1'b1;
                    read <= 1'b0;
                    pat_sel <= 1'b1;
                    delay_data <= 1'b0;
                    state <= WR1;
                end
            end
            WR1 : begin
                if (address=={addr{1'b1}}) begin
                    write <= 1'b0;
                    read <= 1'b1;
                    delay_data <= 1'b1;
                    state <= RD1;
                end
            end
            RD1 : begin
                if(!equal)begin
                    fail <= 1'b1;
                    done <= 1'b1;
                    fail_addr <= address-1;
                    write <= 1'b0;
                    read <= 1'b0;
                    state <= IDLE;
                    address_en <= 1'b0;
                end
                else if (address=={addr{1'b1}}) begin
                    write <= 1'b1;
                    read <= 1'b0;
                    force_0 <= 1'b1;
                    delay_data <= 1'b0;
                    state <= DONE;
                end
            end
            DONE : begin
                if (address=={addr{1'b1}}) begin
                    write <= 1'b0;
                    read <= 1'b0;
                    state <= IDLE;
                    delay_data <= 1'b0;
                    done <= 1'b1;
                    address_en <= 1'b0;
                end
            end
            default : begin
                state <= IDLE;
                address_en <= 1'b0;
                pat_sel <= 1'b0;
                read <= 1'b0;
                write <= 1'b0;
                delay_data <= 1'b0;
                done <= 1'b0;
                fail <= 1'b0;
                force_0 <= 1'b0;
                fail_addr <= {addr{1'b0}};
            end
        endcase
    end
end

endmodule