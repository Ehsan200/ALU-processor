`include "logical_unit.v"
`include "arithmatic_unit.v"
`include "control_unit.v"


module procesor(
    input [31:0] data,
    input data_ready,
    input clk,
    input reset,
    input [31:0] constant,
    input [3:0] opcode,
    output reg [31:0] out,
    output reg out_valid
);


reg [255:0] matrix_a;
reg [255:0] matrix_b;

wire [255:0] output_matrix;

reg [7:0] readed_lines_count;
reg [7:0] out_lines_count;

wire mult, add, sub, dsc, rsr, usc, lsr, awc, and_, xwc, or_, ready; 



arithmatic_unit au(
    .clk(clk),
    .reset(reset),
    .readed_lines_count(readed_lines_count),
    .ready(ready),
    .output_matrix(output_matrix),
    .matrix_a(matrix_a),
    .matrix_b(matrix_b),


    .mult(mult),
    .add(add),
    .sub(sub)

);

logical_unit lu(
    .clk(clk),
    .reset(reset),
    .readed_lines_count(readed_lines_count),
    .ready(ready),
    .output_matrix(output_matrix),
    .matrix_a(matrix_a),
    .matrix_b(matrix_b),

    .dsc(dsc),
    .rsr(rsr),
    .usc(usc),
    .lsr(lsr),
    .awc(awc),
    .and_(and_),
    .xwc(xwc),
    .or_(or_),
    .constant(constant)

);

control_unit cu(
    .clk(clk),
    .opcode(opcode),

    // lu
    .dsc(dsc),
    .rsr(rsr),
    .usc(usc),
    .lsr(lsr),
    .awc(awc),
    .and_(and_),
    .xwc(xwc),
    .or_(or_),

    // au
    .mult(mult),
    .add(add),
    .sub(sub)

);


always @(posedge clk or posedge reset) begin
    if (reset == 1)begin
        readed_lines_count = 0;
        out_lines_count = 0;
        out_valid = 0;
        matrix_a = 0;
        matrix_b = 0;
    end else begin
        if (data_ready == 1) begin
            if (readed_lines_count > 7) begin
                matrix_b[(255 - (readed_lines_count * 32))+:32] = data;
                readed_lines_count = readed_lines_count + 1;
            end
            else begin
                matrix_a[(255 - (readed_lines_count * 32))+:32] = data;
                readed_lines_count = readed_lines_count + 1;
            end
        end
        if (ready == 1) begin
            out = output_matrix[(255 - (out_lines_count * 32))+:32];
            out_valid = 1;
            out_lines_count = out_lines_count + 1;
        end
    end
end


endmodule