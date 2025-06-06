`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 04:08:20 PM
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


module DRAM (
    input clk,
    input rst,                  // Reset
    input start,                // Start new burst
    input [12:0] addr,          // 13-bit address
    input we,                   // Write enable
    input [63:0] data_in,       // 64-bit input data
    output reg [63:0] data_out, // 64-bit output data
    output reg busy             // Busy flag
);

    // Address components
    reg [3:0] latched_bank;    // Bank address (4 bits)
    reg [3:0] latched_row;     // Row address (4 bits)
    reg [4:0] latched_col;     // Base column address (5 bits)
    reg [2:0] burst_count;     // Burst counter (0-7)

    // State machine
    reg [1:0] state;
    localparam IDLE = 2'b00, BURST = 2'b01;

    // Instantiate 16 banks
    wire [63:0] bank_data [0:15];
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : BANKS
            DRAM_Bank bank (
                .clk(clk),
                .row_addr(latched_row),
                .col_addr(latched_col + burst_count), // Column + burst offset
                .we(we && (latched_bank == i)),
                .data_in(data_in),
                .data_out(bank_data[i])
            );
        end
    endgenerate

    // Output multiplexer
    always @(*) begin
        data_out = bank_data[latched_bank];
    end

    // Burst
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            busy <= 0;
            burst_count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        // Latch address
                        latched_bank <= addr[12:9];
                        latched_row <= addr[8:5];
                        latched_col <= addr[4:0];
                        burst_count <= 0;
                        state <= BURST;
                        busy <= 1;
                    end
                end
                BURST: begin
                    burst_count <= burst_count + 1;
                    if (burst_count == 3'd7) begin
                        state <= IDLE;
                        busy <= 0;
                    end
                end
            endcase
        end
    end

endmodule

module DRAM_Bank (
    input clk,
    input [3:0] row_addr,
    input [4:0] col_addr,
    input we,
    input [63:0] data_in,
    output reg [63:0] data_out
);

    reg [63:0] memory [0:15][0:31];

    always @(posedge clk) begin
        if (we) begin
            memory[row_addr][col_addr] <= data_in;  // Write
        end else begin
            data_out <= memory[row_addr][col_addr]; // Read
        end
    end

endmodule