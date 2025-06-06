`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 02:11:26 PM
// Design Name: 
// Module Name: stormbreaker_tb
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



module testbench;

    parameter b = 32;
    reg [127:0] A, B;
    reg cin;
    wire [127:0] sum_storm, sum_rca;
    wire cout_storm, cout_rca;
    
    stormbreaker_adder #(.b(b)) stb (
        .A(A), .B(B), .Cin(cin),
        .S(sum_storm), .Cout(cout_storm));

    ripple_carry_adder #(.k(b)) rca (
        .a(A), .b(B), .cin(cin),
        .sum(sum_rca), .cout(cout_rca));

    initial begin
        #100
        A = 128'd32; B = 128'd70; cin = 1; 
        
        #10;
        A = 16'hFFFF; B = 16'h0001; cin = 0; 
        #10;
        A = 16'hAAAA; B = 16'h5555; cin = 1; 
        #10;
        A = 16'h1234; B = 16'h5678; cin = 0; 
        #10;
        A = 16'hFFFF; B = 16'hFFFF; cin = 1; 
        #10;

        $finish;

    end

endmodule
