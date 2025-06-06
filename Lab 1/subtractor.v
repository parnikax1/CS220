//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.12.2024 23:32:42
// Design Name: 
// Module Name: simple_modular_adder
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

module simple_subtractor(a, b, c_in, sum, c_out);

parameter W=64;

input [W-1:0] a,b;
input c_in;
output [W-1:0] sum;
output c_out;

assign {c_out, sum} = a - b - c_in;
endmodule

module simple_modular_adder(a,b,p,clk,rst,out,done);


input [254:0] a,b;
input clk,rst;
output [254:0] out;
input [254:0] p;
wire [255:0] add_out,sub_out;
output done;
wire sign;

//assign prime=256'h7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed;

//choose nearest eighth and third multiple of (WB+4)*16

reg [255:0] reg_a, reg_b;

wire [63:0] sum_3,sum_4;
wire cout_3,cout_4;
reg cin_3,cin_4,rst_r,rst_rr;

reg [255:0] reg_sum_3,reg_sum_4,reg_p;
wire sum_4_en,sum_3_en;
reg [4:0] count;


wire done;
//assign out={36'd0,final_result[752:0]};







always@(posedge clk)
begin
if(rst)
count<=0;
else if(count==4'd6)
count<=count;
else
count<=count+1;
end





assign done=(count==4'd5)?1:0;
assign sum_3_en=(count<4'd4)?1:0;
assign sum_4_en=(count<4'd5)?1:0;


always@(posedge clk)
begin
if(rst)
begin
reg_a<={1'd0,a};reg_b<={1'd0,b};
cin_3<=1'd0;
end
else
begin
reg_a<={64'd0,reg_a[255:64]};reg_b<={64'd0,reg_b[255:64]};
cin_3<=cout_3;
end
end


always@(posedge clk)
begin
if(rst)
begin
reg_sum_3<=0;
end
else if(sum_3_en)
begin
reg_sum_3<={sum_3,reg_sum_3[255:64]};
end
else
reg_sum_3<=reg_sum_3;
end

always@(posedge clk)
begin
if(rst)
begin
reg_sum_4<=0;
end
else if(sum_4_en)
begin
reg_sum_4<={sum_4,reg_sum_4[255:64]};
end
else
reg_sum_4<=reg_sum_4;
end

always@(posedge clk)
begin
rst_r<=rst;
rst_rr<=rst_r;
end

always@(posedge clk)
begin
if(rst|rst_r)
begin
reg_p<=p;
cin_4<=1'd0;
end
else 
begin
reg_p<={64'h0,reg_p[255:64]};
cin_4<=cout_4;
end
end







carry_chain_sum_old #(.W(64)) add2(reg_a[63:0],reg_b[63:0],cin_3,sum_3,cout_3);

simple_subtractor #(.W(64)) sub(reg_sum_3[255:192],reg_p[63:0],cin_4,sum_4,cout_4);

/*always@(*)
begin
if(sel==0)
sign<=reg_sum_4[767];
else
sign<=reg_sum_3[767];
end*/

assign sign=cout_4;

assign add_out=reg_sum_3[255:0];
assign sub_out=reg_sum_4[255:0];

assign out=(sign)?add_out:sub_out;

endmodule