module fifo_tb;
    parameter WIDTH = 32;
    parameter DEPTH = 16;

    reg clk, rst, wr_en, rd_en;
    reg [WIDTH-1:0] data_in;
    wire [WIDTH-1:0] data_out;
    wire full, empty;
    wire [$clog2(DEPTH)+1:0] wr_ptr;
    wire [$clog2(DEPTH)+1:0] rd_ptr;

    fifo_memory #(WIDTH, DEPTH) uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .wr_ptr (wr_ptr),
        .rd_ptr (rd_ptr),
        .full(full),
        .empty(empty)
    );

    always #10 clk = ~clk;

    initial begin
        rst = 1;
        #100
        clk = 0;
        wr_en = 0;
        rd_en = 0;
        data_in = 0;
        #30 rst = 0;

        repeat (DEPTH) begin
            #10 wr_en = 1;
            data_in = $random;
        end
        #20 wr_en = 0;

        repeat (DEPTH) begin
            #10 rd_en = 1;
        end
        #20 rd_en = 0;

        #20 rd_en = 1;
        #20 rd_en = 0;

        repeat (DEPTH) begin
            #20 wr_en = 1;
            data_in = $random;
        end
        #20 wr_en = 0;

        #40 $finish;
    end

endmodule