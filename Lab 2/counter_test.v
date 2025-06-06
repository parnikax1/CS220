`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2025 02:10:24 PM
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
reg clk, reset;
wire [2:0] count;

initial begin
clk <= 0;
forever #10 clk = ~clk;
end

initial begin
reset <= 1;
#20;
reset <= 0;
#20;
reset <= 1;
#100
reset <=0;
end

counter bitc(clk, reset, count);
endmodule