`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2025 02:15:28 PM
// Design Name: 
// Module Name: addder_test
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


module addder_test(

    );
    reg [31:0] a, b;
    wire [31:0] sum;
    
    fp_adder add(a, b, sum);
    
    initial begin
    #100
    a=32'b01000000001000000000000000000000;
    b=32'b01000000001000000000000000000000;
    
    #10
    a=32'b00000000000000000000000000000000;
    b=32'b00000000000000000000000000000000;
    
    #10
    a=32'd143;
    b=32'd129;
    
    end
    
endmodule
