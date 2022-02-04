module logical_unit(
    input clk,
    input reset,
    input [7:0] readed_lines_count,
    input [255:0] matrix_a,
    input [255:0] matrix_b,
    input [31:0] constant,
    input dsc,
    input rsr,
    input usc,
    input lsr,
    input awc,
    input and_,
    input xwc,
    input or_,

    output reg ready,
    output reg [255:0] output_matrix

);

integer i;

reg [31:0] tmp_row;
reg [3:0] tmp_item;

always @(clk)
begin
    case (1)
        dsc: begin
            if (readed_lines_count == 8) begin
                tmp_row = matrix_a[0-:32];
                output_matrix = matrix_a >> 32;
                output_matrix[255+:32] = tmp_row;
                ready = 1;            
            end
        end
        rsr: begin
            if (readed_lines_count == 8) begin
                for (i = 0; i < 7; i = i + 1) begin
                    tmp_row = matrix_a[(255 - (32 * i))+:32];
                    tmp_item = tmp_row[0-:4];
                    tmp_row = tmp_row >> 4;
                    tmp_row[31+:4] = tmp_item;
                    output_matrix[(255 - (32 * i))+:32] = tmp_row;
                end
                ready = 1;
            end
        end
        usc: begin
            if (readed_lines_count == 8) begin
                tmp_row = matrix_a[255+:32];
                output_matrix = matrix_a << 32;
                output_matrix[0-:32] = tmp_row;
                ready = 1;
            end
        end
        lsr: begin
            if (readed_lines_count == 8) begin
                for (i = 0; i < 7; i = i + 1) begin
                    tmp_row = matrix_a[(255 - (32 * i))+:32];
                    tmp_item = tmp_row[31+:4];
                    tmp_row = tmp_row << 4;
                    tmp_row[0-:4] = tmp_item;
                    output_matrix[(255 - (32 * i))+:32] = tmp_row;
                end
                ready = 1;
            end
        end
        awc: begin
            if (readed_lines_count == 8) begin
                for (i = 0; i < 7; i = i + 1) begin
                    tmp_row = matrix_a[(255 - (32 * i))+:32];
                    tmp_row = tmp_row & constant;
                    output_matrix[(255 - (32 * i))+:32] = tmp_row;
                end
                ready = 1;
            end
        end
        and_: begin
            if (readed_lines_count == 16) begin
                output_matrix = matrix_a & matrix_b;
                ready = 1;
            end
        end
        xwc: begin
            if (readed_lines_count == 8) begin
                for (i = 0; i < 7; i = i + 1) begin
                    tmp_row = matrix_a[(255 - (32 * i))+:32];
                    tmp_row = tmp_row ^ constant;
                    output_matrix[(255 - (32 * i))+:32] = tmp_row;
                end
                ready = 1;
            end
        end
        or_: begin
            if (readed_lines_count == 16) begin
                output_matrix = matrix_a | matrix_b;
                ready = 1;
            end
        end
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset == 1)begin
        output_matrix = 0;
        ready = 0;
    end
end


endmodule