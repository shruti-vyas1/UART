`timescale 1ns / 1ps

module tb_UART_RX;

reg clk, reset, rx;
wire [7:0] data_out;
wire busy, rx_done, framing_error;

UART_RX k1(clk,reset,rx,data_out,busy,rx_done,framing_error);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;
    rx = 1;

    #100;
    reset = 0;

    #1000;
    rx = 0;
    #104160;

    rx = 1;
    #104160;

    rx = 0;
    #104160;

    rx = 1;
    #104160;

    rx = 1;
    #104160;

    rx = 1;
    #104160;

    rx = 0;
    #104160;

    rx = 0;
    #104160;

    rx = 1;
    #104160;

    rx = 1;
    #104160;

    #104160;

    rx = 0;
    #104160;

    rx = 0;
    #104160;

    rx = 1;
    #104160;

    rx = 0;
    #104160;

    rx = 1;
    #104160;

    rx = 0;
    #104160;

    rx = 1;
    #104160;

    rx = 0;
    #104160;

    rx = 1;
    #104160;

    rx = 1;
    #104160;

    #1000;
    $finish;
end

always @(posedge clk)
begin
    if(rx_done)
        $display("Received data = %h",data_out);

    if(framing_error)
        $display("Framing error detected");
end

endmodule
