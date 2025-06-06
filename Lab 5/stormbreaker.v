`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 10:58:43 AM
// Design Name: 
// Module Name: stormbreaker
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


module single_LUT_sum_gen(a,b,c_in,s);

input [1:0] a,b;
input c_in;
output [1:0] s;

//assign s=a-b-c_in;

/*LUT6_2 #(
.INIT(64'h9C6339C6A5A55A5A) // Specify LUT Contents
) LUT6_inst_1 (
.O6(s[1]), // LUT general output
.O5(s[0]),
.I0(a[0]), // LUT input
.I1(b[0]), // LUT input
.I2(a[1]), // LUT input
.I3(b[1]), // LUT input
.I4(c_in), // LUT input
.I5(1'd1) // LUT input
);*/

LUT6_2 #(
.INIT(64'hC936936CA5A55A5A) // Specify LUT Contents
) LUT6_inst_1 (
.O6(s[1]), // LUT general output
.O5(s[0]),
.I0(b[0]), // LUT input
.I1(b[1]), // LUT input
.I2(a[0]), // LUT input
.I3(a[1]), // LUT input
.I4(c_in), // LUT input
.I5(1'd1) // LUT input
);

endmodule

module single_slice_carry_gen_old(a,b,c_in,c_out);

input [7:0] a,b;
input c_in;
output [3:0] c_out;

wire [3:0] prop,gen;

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_1 (
.O6(prop[0]), // LUT general output
.O5(gen[0]),
.I0(a[0]), // LUT input
.I1(b[0]), // LUT input
.I2(a[1]), // LUT input
.I3(b[1]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_2 (
.O6(prop[1]), // LUT general output
.O5(gen[1]),
.I0(a[2]), // LUT input
.I1(b[2]), // LUT input
.I2(a[3]), // LUT input
.I3(b[3]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_3 (
.O6(prop[2]), // LUT general output
.O5(gen[2]),
.I0(a[4]), // LUT input
.I1(b[4]), // LUT input
.I2(a[5]), // LUT input
.I3(b[5]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_4 (
.O6(prop[3]), // LUT general output
.O5(gen[3]),
.I0(a[6]), // LUT input
.I1(b[6]), // LUT input
.I2(a[7]), // LUT input
.I3(b[7]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);

CARRY4 CARRY4_inst (
.CO(c_out), // 4-bit carry out
.O(), // 4-bit carry chain XOR data out
.CI(c_in), // 1-bit carry cascade input
.CYINIT(1'd0), // 1-bit carry initialization
.DI(gen), // 4-bit carry-MUX data in
.S(prop) // 4-bit carry-MUX select input
);

endmodule

module single_slice_carry_gen_old_init(a,b,c_in,c_out);

input [7:0] a,b;
input c_in;
output [3:0] c_out;

wire [3:0] prop,gen;

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_1 (
.O6(prop[0]), // LUT general output
.O5(gen[0]),
.I0(a[0]), // LUT input
.I1(b[0]), // LUT input
.I2(a[1]), // LUT input
.I3(b[1]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_2 (
.O6(prop[1]), // LUT general output
.O5(gen[1]),
.I0(a[2]), // LUT input
.I1(b[2]), // LUT input
.I2(a[3]), // LUT input
.I3(b[3]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_3 (
.O6(prop[2]), // LUT general output
.O5(gen[2]),
.I0(a[4]), // LUT input
.I1(b[4]), // LUT input
.I2(a[5]), // LUT input
.I3(b[5]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);

LUT6_2 #(
.INIT(64'h000006600000F880) // Specify LUT Contents
) LUT6_inst_4 (
.O6(prop[3]), // LUT general output
.O5(gen[3]),
.I0(a[6]), // LUT input
.I1(b[6]), // LUT input
.I2(a[7]), // LUT input
.I3(b[7]), // LUT input
.I4(1'd0), // LUT input
.I5(1'd1) // LUT input
);

CARRY4 CARRY4_inst (
.CO(c_out), // 4-bit carry out
.O(), // 4-bit carry chain XOR data out
.CI(1'd0), // 1-bit carry cascade input
.CYINIT(c_in), // 1-bit carry initialization
.DI(gen), // 4-bit carry-MUX data in
.S(prop) // 4-bit carry-MUX select input
);

endmodule

module carry_chain_sum_old(a,b,c_in,sum,c_out);

parameter W=64;

input [W-1:0] a,b;
input c_in;
output [W-1:0] sum;
output c_out;

wire [W/2:0] c_temp;

assign c_temp[0]=c_in;

assign c_out=c_temp[W/2];

single_slice_carry_gen_old_init carry_init(a[7:0],b[7:0],c_in,c_temp[4:1]);

genvar i;

generate for(i=8;i<W;i=i+8)
begin: carry_gen
single_slice_carry_gen_old carry(a[i+7:i],b[i+7:i],c_temp[(i+8)/2-4],c_temp[(i+8)/2:(i+8)/2-3]);
end
endgenerate

genvar j;

generate for(j=0;j<W/2;j=j+1)
begin: sum_gen
single_LUT_sum_gen sum_mod(a[2*j+1:2*j],b[2*j+1:2*j],c_temp[j],sum[2*j+1:2*j]);
end
endgenerate

endmodule

module stormbreaker_adder #(parameter b = 32) (
    input [127:0] A, B,
    input Cin,
    output [127:0] S,
    output Cout
);

    localparam NUM_BLOCKS = 128 / b;
    wire [NUM_BLOCKS:0] carry;
    wire carry_temp;
    assign mux_out=Cin;
    assign carry[0]=Cin;
    wire [NUM_BLOCKS-1:0] propagate;  

    genvar i;
    generate
        for (i = 0; i < NUM_BLOCKS; i = i + 1) begin : adder_blocks
            assign propagate[i] = &(A[((i+1)*b)-1 : i*b] ^ B[((i+1)*b)-1 : i*b]);
            
            b_bit_adder #(.WIDTH(b)) block_adder (
                .A(A[((i+1)*b)-1 : i*b]),
                .B(B[((i+1)*b)-1 : i*b]),
                .Cin(carry[i]),
                .S(S[((i+1)*b)-1 : i*b]),
                .Cout(carry_temp)
            );
            assign carry[i+1] = propagate[i] ? carry[i] : carry_temp;
        end
    endgenerate

    assign Cout = carry[NUM_BLOCKS];

endmodule
module b_bit_adder #(parameter WIDTH = 32) (input [WIDTH-1:0] A, input [WIDTH-1:0] B, input Cin, output [WIDTH-1:0] S, output Cout);
    carry_chain_sum_old #(.W(WIDTH)) adder (
    .a(A),
    .b(B),
    .c_in(Cin),
    .sum(S),
    .c_out(Cout));

endmodule

module ripple_carry_adder #(parameter k = 32) (input [k-1:0] a, b, input cin, output [k-1:0] sum, output cout);

    wire [k:0] carry;
    assign carry[0] = cin;
    genvar i;
    generate
        for (i = 0; i < k; i = i + 1) begin: rca_loop
            full_adder fa (
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .cout(carry[i+1]));
        end
    endgenerate

    assign cout = carry[k];
endmodule

module full_adder (input a, b, cin, output sum, cout);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));

endmodule

