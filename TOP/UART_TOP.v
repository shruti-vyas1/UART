`timescale 1ns / 1ps

module UART_TOP(clk,reset,tx_start,data_in,tx,busy_tx,data_out,busy_rx,rx_done,framing_error);

input clk,reset,tx_start;
input [7:0] data_in;

output tx,busy_tx;
output [7:0] data_out;
output busy_rx,rx_done,framing_error;

UART_TX k1(clk,reset,tx_start,data_in,tx,busy_tx);

UART_RX k2(clk,reset,tx,data_out,busy_rx,rx_done,framing_error);

endmodule
