`timescale 1ns / 1ps

module tb_UART_TOP;

reg clk,reset,tx_start;
reg [7:0] data_in;

wire tx,busy_tx;
wire [7:0] data_out;
wire busy_rx,rx_done,framing_error;

UART_TOP k1(clk,reset,tx_start,data_in,tx,busy_tx,data_out,busy_rx,rx_done,framing_error);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;
    tx_start = 0;
    data_in = 0;

    #100;
    reset = 0;

    #100;
    data_in = 8'h9D;
    tx_start = 1;

    #10;
    tx_start = 0;

    wait(rx_done == 1);
    #10;
    $display("Transmitted = 9D, Received = %h",data_out);

    wait(busy_tx == 0);

    #200000;
    data_in = 8'hAA;
    tx_start = 1;

    #10;
    tx_start = 0;

    wait(rx_done == 1);
    #10;
    $display("Transmitted = AA, Received = %h",data_out);

    #1000;
    $finish;
end

endmodule
