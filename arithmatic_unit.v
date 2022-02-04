module arithmatic_unit(
    input clk,
    input reset,
    input [7:0] readed_lines_count,
    input [255:0] matrix_a,
    input [255:0] matrix_b,
    input mult,
    input add,
    input sub,

    output reg ready,
    output reg [255:0] output_matrix

);


reg cout;
reg [3:0] mult_out;
integer i, j, k;

always @(clk)
begin
    case (1)
        mult: begin
            if (readed_lines_count == 16)
                begin
                for (i = 0; i < 7; i = i + 1) begin
                   for (j = 0; j < 7; j = j + 1) begin
                       for (k = 0; k < 7; k = k + 1) begin
                           {output_matrix[(255 - ((i * 32) + (j * 4)))+:4], mult_out} = matrix_a[(255 - ((i * 32) + (k * 4)))+:4] * matrix_b[(255 - ((k * 32) + (j * 4)))+:4];
                       end
                   end 
                end
                ready = 1;
            end
        end
        add: begin
            if (readed_lines_count == 16) begin
                for (i = 0; i < 64; i = i + 1) begin
                    {output_matrix[(255 - (4 * i))+:4], cout} = matrix_a[(255 - (4 * i))+4] + matrix_b[(255 - (4 * i))+:4];
                end
                ready = 1;
            end
        end
        sub: begin
            if (readed_lines_count == 16) begin
                output_matrix = matrix_a - matrix_b;
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