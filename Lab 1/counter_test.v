`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2025 02:10:31 PM
// Design Name: 
// Module Name: counter_test
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


module counter_test();
    reg clk;
    reg reset;
    reg mode;
    wire [2:0] out_val;

    initial begin
        clk <= 0;
        forever #10 clk = ~clk;
    end

    initial begin
        reset <= 1;
        mode <= 0;
        #10;
        reset <= 0;
        mode <= 1;
        #50
        reset <= 1;
        #50
        reset <= 0;
        #200;
        reset <= 1;
        mode <= 1;
        #10;
        reset <= 0;
        mode <= 0;
        #100;
    end

    updown_counter count(clk,reset,mode,out_val);
endmodule
