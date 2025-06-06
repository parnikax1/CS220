`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2025 02:21:21 PM
// Design Name: 
// Module Name: synchronous_test
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


module synchronous_test;

    reg clk;
    reg reset;
    reg in;
    wire out;

    synchronous uut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        #100
        reset = 1;
        in = 0;
        #15 reset = 0; 

        #10 in = 1; #10 in = 1; #10 in = 1; 
        #10 in = 0; #10 in = 0; #10 in = 0; 
        #10 in = 1; #10 in = 1; #10 in = 0; #10 in = 0; #10 in = 0; 
        #10 in = 1; #10 in = 1; #10 in = 1; 

        #50 $stop;
    end

endmodule
