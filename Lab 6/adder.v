`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2025 02:07:06 PM
// Design Name: 
// Module Name: adder
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


module fp_adder (input  [31:0] a,input  [31:0] b,output reg [31:0] sum);
    wire sign_a= a[31];
    wire [7:0] exp_a= a[30:23];
    wire [22:0] frac_a= a[22:0];
    
    wire sign_b= b[31];
    wire [7:0] exp_b= b[30:23];
    wire [22:0] frac_b= b[22:0];
    
    wire [23:0] sig_a = (exp_a == 8'b0) ? {1'b0, frac_a} : {1'b1,frac_a};
    wire [23:0] sig_b = (exp_b == 8'b0) ? {1'b0, frac_b} : {1'b1,frac_b};
    
    wire exp_a_gt_exp_b = (exp_a > exp_b);
    wire [7:0] exp_diff = exp_a_gt_exp_b ? (exp_a - exp_b) : (exp_b - exp_a);
    
    wire [26:0] aligned_sig_a = exp_a_gt_exp_b ? {sig_a, 3'b000} :({sig_a, 3'b000} >> exp_diff);
    wire [26:0] aligned_sig_b = exp_a_gt_exp_b ? ({sig_b, 3'b000} >> exp_diff) : {sig_b, 3'b000};
    
    wire add_op = (sign_a == sign_b);
    wire [27:0] ext_sig_a = {1'b0, aligned_sig_a};
    wire [27:0] ext_sig_b = {1'b0, aligned_sig_b};
    
    wire [27:0] raw_sum = add_op ?(ext_sig_a + ext_sig_b) : (aligned_sig_a >= aligned_sig_b ? (ext_sig_a - ext_sig_b) : (ext_sig_b - ext_sig_a) );
    
    wire result_sign = add_op ? sign_a : (aligned_sig_a >= aligned_sig_b ? sign_a : sign_b);
    
    reg [27:0] norm_sig;
    reg [7:0]  norm_exp;
    integer i;
    always @(*) begin
        norm_exp = exp_a_gt_exp_b ? exp_a : exp_b;
        norm_sig = raw_sum;
        
        if (add_op && norm_sig[27]) begin
            norm_sig = norm_sig >> 1;
            norm_exp = norm_exp + 1;
        end
        else begin
        
            if (norm_sig[26] == 1'b0 && norm_exp > 0 && norm_sig != 0)
            begin
                norm_sig = norm_sig << 1;
                norm_exp = norm_exp - 1;
            end
            else begin
                norm_sig = norm_sig;
                norm_exp = norm_exp;
            end
        end
    end
    
    wire [22:0] final_frac = norm_sig[25:3];
    
    always @(*) begin
    sum = {result_sign, norm_exp, final_frac};
    end

endmodule
