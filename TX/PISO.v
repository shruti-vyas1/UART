`timescale 1ns / 1ps
module PISO(clk,reset,load,shift_en,data_in,serial_out);
input clk;
input reset;
input load;
input shift_en; 
input [7:0] data_in;
output serial_out;
reg [7:0]shift_reg;
assign serial_out=shift_reg[0];
always @(posedge clk)
begin
    if(reset)
        begin
        shift_reg<=8'b00000000;
        end
    else if(load)begin
    shift_reg<=data_in;
    end
    else
    if(shift_en)
    begin
    shift_reg<=shift_reg>>1;
    end
end
endmodule
