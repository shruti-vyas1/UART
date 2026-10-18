
`timescale 1ns / 1ps

module FSM(clk, reset, tx_start, baud_tick, serial_out,
           load, shift_en, tx, busy);

input clk, reset;
input tx_start, baud_tick, serial_out;

output reg load, shift_en, tx, busy;

reg [1:0] state;
reg [1:0] ns;
reg [2:0] bit_count;

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= IDLE;
        bit_count <= 0;
    end
    else
    begin
        state <= ns;

        if(state == DATA && baud_tick)
            bit_count <= bit_count + 1;

        if(state == STOP && baud_tick)
            bit_count <= 0;
    end
end

always @(*)
begin
    ns = state;

    case(state)
        IDLE:
            if(tx_start)
                ns = START;

        START:
            if(baud_tick)
                ns = DATA;

        DATA:
            if(bit_count == 7 && baud_tick)
                ns = STOP;

        STOP:
            if(baud_tick)
                ns = IDLE;

        default:
            ns = IDLE;
    endcase
end

always @(*)
begin
    tx = 1;
    busy = 0;
    load = 0;
    shift_en = 0;

    case(state)
        IDLE:
        begin
            tx = 1;
            busy = 0;
        end

        START:
        begin
            tx = 0;
            busy = 1;
            load = 1;
        end

        DATA:
        begin
            tx = serial_out;
            busy = 1;
            shift_en = baud_tick;
        end

        STOP:
        begin
            tx = 1;
            busy = 1;
        end
    endcase
end

endmodule
