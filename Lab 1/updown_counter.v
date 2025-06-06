`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2025 02:05:16 PM
// Design Name: 
// Module Name: updown_counter
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
module updown_counter (clk,reset,mode,out);
input clk,reset,mode;
output [2:0] out;

wire t1,t2,t3;
wire a,b,c;

assign out = {a,b,c};
assign t1 = (mode == 0) ? ((b&c)|(a&b)) : (~b&~c);
assign t2 = (mode == 0) ? (c|(a&b)) : ~c;
assign t3 = (mode == 0) ? (~a|~b) : (a|b|c);

Tff f1(.t(t1),.clk(clk),.reset(reset),.q(a));
Tff f2(.t(t2),.clk(clk),.reset(reset),.q(b));
Tff f3(.t(t3),.clk(clk),.reset(reset),.q(c));

endmodule

module Tff(t,clk,reset,q);
input clk,reset,t;
output reg q;
always @(posedge clk)
begin
if (reset) begin q <= 1'b0; end
else if (t) begin q <= ~q; end
end
endmodule
