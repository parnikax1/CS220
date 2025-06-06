`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2025 03:11:42 PM
// Design Name: 
// Module Name: dram
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


module row_decoder (
    input [9:0] row_addr,
    output reg [1023:0] row_sel
);
    always @(*) begin
        row_sel = 0;
        row_sel[row_addr] = 1'b1;
    end
endmodule

module column_decoder (
    input [4:0] col_addr,
    output reg [31:0] col_sel
);
    always @(*) begin
        col_sel = 0;
        col_sel[col_addr] = 1'b1;
    end
endmodule

module d_flipflop (
    input clk, we, din,
    output reg dout
);
    always @(posedge clk) begin
        if (we) dout <= din;
    end
endmodule

module column_storage (
    input clk, we,
    input [63:0] din,
    output reg [63:0] dout
);
    always @(posedge clk) begin
        if (we) dout <= din;
    end
endmodule

module dram_bank (
    input clk, we,
    input [9:0] row_addr,
    input [4:0] col_addr,
    input [63:0] din,
    output reg [63:0] dout // Changed to reg, but correctly assigned inside always block
);
    wire [1023:0] row_sel;
    wire [31:0] col_sel;
   
    // Flattened memory array (instead of 2D array)
    reg [63:0] col_data_flat [0:32767]; // 1024 rows × 32 columns = 32768 entries

    row_decoder r_dec (row_addr, row_sel);
    column_decoder c_dec (col_addr, col_sel);

    always @(posedge clk) begin
        if (we) begin
            col_data_flat[row_addr * 16 + col_addr] <= din;
        end
        dout <= col_data_flat[row_addr * 16 + col_addr]; // Assign dout inside always block
    end
endmodule

module dram (
    input clk, we,
    input [19:0] address,
    input [63:0] din,
    output [63:0] dout
);
    wire [1:0] bank_sel = address[19:18];
    wire [9:0] row_addr = address[17:8];
    wire [4:0] col_addr = address[7:3];

    wire [63:0] bank_out[3:0];
    wire [3:0] bank_enable;
   
    assign bank_enable = (4'b0001 << bank_sel); // One-hot bank selection

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : bank_block
            dram_bank bank (
                .clk(clk),
                .we(we & bank_enable[i]),
                .row_addr(row_addr),
                .col_addr(col_addr),
                .din(din),
                .dout(bank_out[i])
            );
        end
    endgenerate

    assign dout = bank_out[bank_sel];
endmodule

module burst_controller (
    input clk, enable,
    input [2:0] burst_counter,
    output reg [2:0] burst_out
);
    always @(posedge clk) begin
        if (enable)
            burst_out <= burst_counter + 1;
    end
endmodule

