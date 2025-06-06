module fifo_memory #(parameter WIDTH = 32, DEPTH = 16)(
    input wire clk,
    input wire rst,
    input wire wr_en,
    input wire rd_en,
    input wire [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out,
    output reg [$clog2(DEPTH):0] wr_ptr ,
    output reg [$clog2(DEPTH):0] rd_ptr ,
    output reg full,
    output reg empty
);

    reg [WIDTH-1:0] memory [0:DEPTH-1];
    //reg [$clog2(DEPTH)+1:0] wr_ptr ;
    //reg [$clog2(DEPTH)+1:0] rd_ptr ;
    reg [4:0] count = 0;  // Track number of elements in FIFO

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count <= 0;
            full <= 0;
            empty <= 1;
        end else begin
            if (wr_en && !full) begin
                memory[wr_ptr] <= data_in;
                wr_ptr <= (wr_ptr + 1) % DEPTH;
                count <= count + 1;
            end else begin
                
            end
            
            if (rd_en && !empty) begin
                data_out <= memory[rd_ptr];
                rd_ptr <= (rd_ptr + 1) % DEPTH;
                count <= count - 1;
            end else begin
                
            end

            full <= (count == DEPTH);
            empty <= (count == 0);
        end
    end

endmodule
