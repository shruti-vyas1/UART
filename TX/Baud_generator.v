
`timescale 1ns / 1ps

module Baud_generator(clk, reset, tx_start, baud_tick);

input clk, reset, tx_start;
output reg baud_tick;

reg [13:0] counter;

parameter BAUD_RATE = 10416;

always @(posedge clk)
begin
    if(reset)
    begin
        counter <= 0;
        baud_tick <= 0;
    end
    else if(tx_start)
    begin
        counter <= 0;
        baud_tick <= 0;
    end
    else if(counter == BAUD_RATE-1)
    begin
        counter <= 0;
        baud_tick <= 1;
    end
    else
    begin
        counter <= counter + 1;
        baud_tick <= 0;
    end
end

endmodule
