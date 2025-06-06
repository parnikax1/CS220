`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2025 03:43:00 PM
// Design Name: 
// Module Name: multiplier_test
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


module multiplier_test();
    reg [31:0] a,b;
    wire [31:0] result;
    initial begin
        a<=32'b01000010101010100100000000000000;
        b<=32'b01000010111010000111000000000000;
        #20
        a<=32'b01000010101010100100000000000000;
        b<=32'b01000010101010100100000000000000;
        #100
        a<=32'b01000010111010000111000000000000;
        b<=32'b01000010111010000111000000000000;
    end
    fp_multiplier inst(a,b,result);

endmodule
