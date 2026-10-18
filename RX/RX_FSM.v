`timescale 1ns / 1ps

module RX_FSM(clk,reset,rx,shift_en,rx_done,framing_error,busy);

input clk,reset,rx;
output reg shift_en,rx_done,framing_error;
output busy;

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

parameter BIT_PERIOD = 10416;
parameter HALF_PERIOD = 5208;

reg [1:0] state;
reg [13:0] counter;
reg [2:0] bit_count;

assign busy = (state != IDLE);

always @(posedge clk)
begin
    if(reset)
    begin
        state <= IDLE;
        counter <= 0;
        bit_count <= 0;
        shift_en <= 0;
        rx_done <= 0;
        framing_error <= 0;
    end
    else
    begin
        shift_en <= 0;
        rx_done <= 0;
        framing_error <= 0;

        case(state)

            IDLE:
            begin
                counter <= 0;
                bit_count <= 0;

                if(rx == 0)
                begin
                    state <= START;
                    counter <= 0;
                end
            end

            START:
            begin
                if(counter == HALF_PERIOD-1)
                begin
                    counter <= 0;

                    if(rx == 0)
                        state <= DATA;
                    else
                        state <= IDLE;
                end
                else
                    counter <= counter + 1'b1;
            end

            DATA:
            begin
                if(counter == BIT_PERIOD-1)
                begin
                    counter <= 0;
                    shift_en <= 1;

                    if(bit_count == 7)
                        state <= STOP;
                    else
                        bit_count <= bit_count + 1'b1;
                end
                else
                    counter <= counter + 1'b1;
            end

            STOP:
            begin
                if(counter == BIT_PERIOD-1)
                begin
                    counter <= 0;
                    state <= IDLE;

                    if(rx == 1)
                        rx_done <= 1;
                    else
                        framing_error <= 1;
                end
                else
                    counter <= counter + 1'b1;
            end

            default:
            begin
                state <= IDLE;
                counter <= 0;
                bit_count <= 0;
            end

        endcase
    end
end

endmodule
