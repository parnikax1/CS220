`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2025 02:53:29 PM
// Design Name: 
// Module Name: subtractor_test
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

//module subtractor_tb;

//    // Testbench signals
//    reg clk;
//    reg rst;
//    reg [254:0] A;
//    reg [254:0] B;
//    reg [254:0] P;
//    wire [254:0] result;
//    wire done;

//    // Instantiate the subtractor module
//    subtractor uut (
//        .clk(clk),
//        .rst(rst),
//        .A(A),
//        .B(B),
//        .P(P),
//        .result(result),
//        .done(done)
//    );

//    // Clock generation
//    always begin
//        #10 clk = ~clk;  // 100 MHz clock (period = 10ns)
//    end
//    initial begin
//        clk <= 0;
//        rst = 0;
//        A <= 255'd0;
//        B <= 255'd0;
//        P <= 255'd0;
//        rst = 1;
//        #10;
//        rst <= 0;
//        A <= 255'd50;
//        B <= 255'd20;
//        P <= 255'd100;
//        #100;
//        A <= 255'd200;
//        B <= 255'd150;
//        P <= 255'd50;
//        #100;
//        A <= 255'd100;
//        B <= 255'd100;
//        P <= 255'd50;
//        #100;
//        A <= 255'd30;
//        B <= 255'd20;
//        P <= 255'd100;
//        #100;
//        A <= 255'd10000000;
//        B <= 255'd5000000;
//        P <= 255'd1000000;
//    end

//endmodule

module subtractor_tb();
parameter W=255;
reg [W-1:0] a,b;
reg clk,rst;
wire [W-1:0] out;
reg [W-1:0] p;

initial begin 
    clk=1'b0;
    forever begin
    #10 clk = ~clk;
    end end


//carry_chain_sum_new_for_256 adder(mode,a,b,sum,c_out);

simple_modular_adder adder(a,b,p,clk,rst,out,done);

//carry64lookup lookahead(a,b,c_in,sum,c_out1,g,p);

initial begin
    //c_in=1'b1;
    rst=1'b1; 
//    a=64'd18446744073709551606;
//    b=64'd18446744073709551604;
    a=255'h3fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffec;
    b=255'h3fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffec;
    p=255'h7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed;
    #100 rst=1'b0;
    // mod output: 6322e973ec7ee058b8cc396fde97386591f02e41fb01fcc99663861135d0c41c
end
endmodule
