`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 04:32:18 PM
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

     parameter k = 32;
     parameter kk=128;
     reg [127:0] a, b;
     reg cin;
     wire [127:0] sum_storm, sum_rca;
     wire cout_storm, cout_rca;
     
     stormbreaker_adder #(.b(k)) mjolnir (
         .A(a), .B(b), .Cin(cin),
         .S(sum_storm), .Cout(cout_storm)

     );

     ripple_carry_adder #(.k(kk)) rca (
         .a(a), .b(b), .cin(cin),
         .sum(sum_rca), .cout(cout_rca)

     );

     initial begin

         #100

         // Test cases

         a = 16'h0001; b = 16'h0001; cin = 0; #10;

         a = 16'hFFFF; b = 16'h0001; cin = 0; #10;

         a = 16'hAAAA; b = 16'h5555; cin = 1; #10;

         a = 16'h1234; b = 16'h5678; cin = 0; #10;

         a = 16'hFFFF; b = 16'hFFFF; cin = 1; #10;

         $finish;

     end

endmodule
