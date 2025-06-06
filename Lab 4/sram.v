`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2025 02:18:03 PM
// Design Name: 
// Module Name: sram
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


module SRAMmini(input[3:0] add,input we,input[31:0]din,output[31:0]dout,input clk);
    reg[31:0]store[15:0];
    assign dout=store[add];
    always@(posedge clk)
    begin
        if(we)
            store[add]<=din;
        else
            store[add]<=store[add];
    end
endmodule
module SRAMbig(input[8:0] add,input we,input[7:0]din,output reg[7:0]dout,input clk);
    genvar i;
    reg[31:0] in[7:0];
    wire[31:0] out[7:0];
    generate
    for(i=0;i<8;i=i+1)
    begin
        SRAMmini inst_1(add[8:5],we,in[i],out[i],clk);
    end
    endgenerate
    always @(*) begin
        dout[0] = out[0][add[4:0]];
        dout[1] = out[1][add[4:0]];
        dout[2] = out[2][add[4:0]];
        dout[3] = out[3][add[4:0]];
        dout[4] = out[4][add[4:0]];
        dout[5] = out[5][add[4:0]];
        dout[6] = out[6][add[4:0]];
        dout[7] = out[7][add[4:0]];
    end
    always @(*) begin
        in[0][add[4:0]] = we ? din[0] : out[0][add[4:0]];
        in[1][add[4:0]] = we ? din[1] : out[1][add[4:0]];
        in[2][add[4:0]] = we ? din[2] : out[2][add[4:0]];
        in[3][add[4:0]] = we ? din[3] : out[3][add[4:0]];
        in[4][add[4:0]] = we ? din[4] : out[4][add[4:0]];
        in[5][add[4:0]] = we ? din[5] : out[5][add[4:0]];
        in[6][add[4:0]] = we ? din[6] : out[6][add[4:0]];
        in[7][add[4:0]] = we ? din[7] : out[7][add[4:0]];
    end
endmodule

