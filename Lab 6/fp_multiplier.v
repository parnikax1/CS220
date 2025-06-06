`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2025 03:41:26 PM
// Design Name: 
// Module Name: fp_multiplier
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


module fp_multiplier(
input  wire [31:0] a,
input  wire [31:0] b,
output wire [31:0] result
);

    wire sign_a = a[31];
    wire sign_b = b[31];
    wire result_sign = sign_a ^ sign_b;
    wire [7:0] exp_a = a[30:23];
    wire [7:0] exp_b = b[30:23];
    wire [23:0] mant_a = {1'b1, a[22:0]};
    wire [23:0] mant_b = {1'b1, b[22:0]};
    wire [47:0] mant_product = mant_a * mant_b;
    wire [8:0] exp_sum_pre = exp_a + exp_b - 8'd127;
    
    reg [7:0] result_exp;
    reg [22:0] result_mant;
    always @(*) begin
        if (mant_product[47]) begin
            result_mant = mant_product[46:24];
            result_exp  = exp_sum_pre[7:0] + 8'd1;
            end else begin
            result_mant = mant_product[45:23];
            result_exp  = exp_sum_pre[7:0];
        end
    end
    assign result = {result_sign, result_exp, result_mant};
endmodule