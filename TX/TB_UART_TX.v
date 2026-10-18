`timescale 1ns / 1ps

module TB_UART_TX();

reg clk, reset, tx_start;
reg [7:0] data_in;

wire tx, busy;

UART_TX k1(
    clk,
    reset,
    tx_start,
    data_in,
    tx,
    busy
);

initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial
begin
    $display("time reset tx_start data_in tx busy");

    $monitor("%0t    %b       %b       %b     %b   %b",
             $time, reset, tx_start, data_in, tx, busy);

    reset = 1;
    tx_start = 0;
    data_in = 8'b00000000;

    #20;

    reset = 0;

    data_in = 8'b10101010;
    tx_start = 1;

    #10;

    tx_start = 0;

    // Wait for complete transmission
    #1100000;

    $finish;
end

endmodule
