`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2025 02:05:14 PM
// Design Name: 
// Module Name: counter
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


module counter (clk, reset, count);
input clk,reset;
output reg [2:0] count;
parameter S0 = 3'b000, S1 = 3'b010, S2 = 3'b101, S3 = 3'b011, S4 = 3'b100;
reg [2:0] p_state, n_state;

always@(posedge clk)
begin
if(reset) p_state <= S0;
else p_state = n_state;
end

always@(*)
begin
case(p_state)
S0 : n_state = S1;
S1 : n_state = S2;
S2 : n_state = S3;
S3 : n_state = S4;
S4 : n_state = S0;
default : n_state = S0;
endcase
end

always@(*)
begin
count = p_state;
end

endmodule