`timescale 1ns / 1ps

module SIPO(clk, reset, shift_en, serial_in, data_out);

input clk, reset, shift_en, serial_in;
output reg [7:0] data_out;

always @(posedge clk)
begin
    if(reset)
        data_out <= 8'b00000000;

    else if(shift_en)
        data_out <= {serial_in, data_out[7:1]};
end

endmodule
