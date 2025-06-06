`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2025 02:20:41 PM
// Design Name: 
// Module Name: sram_test
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


module sram_test;
// Parameters
parameter CLK_PERIOD = 10; // Clock period in ns
// Testbench signals
reg clk;
reg we; // Write enable
reg [8:0] add; // 4-bit address (16 locations)
reg [7:0] din; // 32-bit data input
wire [7:0] dout; // 32-bit data output
// Instantiate the SRAM module
SRAMbig uut (
.add(add),
.we(we),
.din(din),
.dout(dout),
.clk(clk)
);
// Clock generation
always begin
#5 clk = ~clk;
end
// Stimulus process
initial begin
//$monitor("time %d dout %d we %d",$time,dout,we);
#100
clk = 0;
we = 1;
add = 9'd0;
din = 8'd255;
#100
we = 1;
add = 9'b0001;
din = 8'd6;
#100
we = 1;
add = 9'd500;
din = 8'd8;
#100
we = 0;
add = 9'd0;
din = 8'd8;
//$finish;
#100
we = 0;
add = 9'b0001;
din = 8'd8;
#100
we=0;
add=9'd500;
din=8'd8;
end
// End simulation
endmodule
