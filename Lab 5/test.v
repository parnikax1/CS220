`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 10:36:53 AM
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module DRAM_TB;

    reg clk;
    reg rst;
    reg start;
    reg [12:0] addr;
    reg we;
    reg [63:0] data_in;
    wire [63:0] data_out;
    wire busy;

    DRAM dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .addr(addr),
        .we(we),
        .data_in(data_in),
        .data_out(data_out),
        .busy(busy)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        addr = 0;
        we = 0;
        data_in = 0;

        #20 rst = 0;

        #10 start = 1;
        addr = 13'h0000;
        we = 1;
        data_in = 64'd42;
        #10 start = 0;
        wait(!busy);

        #10 start = 1;
        addr = 13'h0000;
        we = 0;
        #10 start = 0;
        wait(!busy);

        #10 start = 1;
        addr = 13'h1020;
        we = 1;
        data_in = 64'd56;
        #10 start = 0;
        wait(!busy);

        #10 start = 1;
        addr = 13'h1020;
        we = 0;
        #10 start = 0;
        wait(!busy);
//        if (data_out !== 64'h1234_5678_9ABC_DEF0) $display("Error: Read data mismatch in Test Case 4");

        #10 start = 1;
        addr = 13'h0010;
        we = 1;
        #10 start = 0;
        data_in = 64'd1;
        #10 data_in = 64'd2;
        #10 data_in = 64'd3;
        #10 data_in = 64'd4;
        #10 data_in = 64'd5;
        #10 data_in = 64'd6;
        #10 data_in = 64'd7;
        #10 data_in = 64'd8;
        wait(!busy);

        #10 start = 1;
        addr = 13'h0010;
        we = 0;
        #10 start = 0;
        wait(!busy);

        #10 start = 1;
        addr = 13'h1FFF;
        we = 1;
        data_in = 64'd23;
        #10 start = 0;
        wait(!busy);

        #10 start = 1;
        addr = 13'h1FFF;
        we = 0;
        #10 start = 0;
        wait(!busy);

        #100 $finish;
    end

    initial begin
        $monitor("Time=%0t, Start=%b, Addr=%h, WE=%b, DataIn=%h, DataOut=%h, Busy=%b",
                 $time, start, addr, we, data_in, data_out, busy);
    end

endmodule

