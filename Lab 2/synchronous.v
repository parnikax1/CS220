`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2025 02:18:19 PM
// Design Name: 
// Module Name: synchronous
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


module synchronous (
     input clk,         
     input reset,       
     input in,          
     output reg out     
);

     
     parameter [2:0]
         S0 = 3'b000,  
         S1 = 3'b001,  
         S2 = 3'b010,  
         S3 = 3'b011,  
         S4 = 3'b100,  
         S5 = 3'b101,  
         S6 = 3'b110;  

     reg [2:0] current_state, next_state;

     always @(posedge clk or posedge reset) begin
         if (reset)
             current_state <= S0; 
         else
             current_state <= next_state;
     end

     always @(*) begin
         case (current_state)
             S0: next_state = (in) ? S1 : S4; 
             S1: next_state = (in) ? S2 : S4; 
             S2: next_state = (in) ? S3 : S4; 
             S3: next_state = (in) ? S3 : S4; 
             S4: next_state = (in) ? S1 : S5; 
             S5: next_state = (in) ? S1 : S6; 
             S6: next_state = (in) ? S1 : S4; 
             default: next_state = S0;
         endcase
     end

     always @(*) begin
         out = (current_state == S3 || current_state == S6) ? 1 : 0;
     end 

endmodule
