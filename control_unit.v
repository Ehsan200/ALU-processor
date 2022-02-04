module control_unit(
    input clk,
    input [3:0] opcode,

    output reg dsc,
    output reg rsr,
    output reg usc,
    output reg lsr,
    output reg awc,
    output reg and_,
    output reg xwc,
    output reg or_,

    output reg mult,
    output reg add,
    output reg sub
);

    parameter case_nop = 4'b0000, // no operation
              case_mult = 4'b0001, // mult 2 matrix
              case_add = 4'b0010, // add 2 matrix
              case_sub = 4'b0011, // sub 2 matrix
              case_dsc = 4'b1000, // down shift column
              case_rsr = 4'b1001, // right shift row
              case_usc = 4'b1010, // up shift column
              case_lsr = 4'b1011, // left shift row
              case_awc = 4'b1100, // and with constant
              case_and_ = 4'b1101, // and 2 matrix
              case_xwc = 4'b1110, // xor with constant
              case_or_ = 4'b1111; // or 2 matrix


always @(clk)
begin
    case (opcode)
        case_nop: begin
                dsc = 0;
                rsr = 0;
                usc = 0;
                lsr = 0;
                awc = 0;
                and_ = 0;
                xwc = 0;
                or_ = 0;

                mult = 0;
                add = 0;
                sub = 0;
        end
        case_mult: begin
                dsc = 0;
                rsr = 0;
                usc = 0;
                lsr = 0;
                awc = 0;
                and_ = 0;
                xwc = 0;
                or_ = 0;

                mult = 1;
                add = 0;
                sub = 0;
        end
        case_add: begin
                dsc = 0;
                rsr = 0;
                usc = 0;
                lsr = 0;
                awc = 0;
                and_ = 0;
                xwc = 0;
                or_ = 0;

                mult = 0;
                add = 1;
                sub = 0;
        end
        case_sub: begin
                dsc = 0;
                rsr = 0;
                usc = 0;
                lsr = 0;
                awc = 0;
                and_ = 0;
                xwc = 0;
                or_ = 0;

                mult = 0;
                add = 0;
                sub = 1;
        end
        case_dsc: begin
                dsc = 1;
                rsr = 0;
                usc = 0;
                lsr = 0;
                awc = 0;
                and_ = 0;
                xwc = 0;
                or_ = 0;

                mult = 0;
                add = 0;
                sub = 0;
        end
        case_rsr: begin
                dsc = 0;
                rsr = 1;
                usc = 0;
                lsr = 0;
                awc = 0;
                and_ = 0;
                xwc = 0;
                or_ = 0;

                mult = 0;
                add = 0;
                sub = 0;
        end
        case_usc: begin
                dsc = 0;
                rsr = 0;
                usc = 1;
                lsr = 0;
                awc = 0;
                and_ = 0;
                xwc = 0;
                or_ = 0;

                mult = 0;
                add = 0;
                sub = 0;
        end
        case_lsr: begin
                dsc = 0;
                rsr = 0;
                usc = 0;
                lsr = 1;
                awc = 0;
                and_ = 0;
                xwc = 0;
                or_ = 0;

                mult = 0;
                add = 0;
                sub = 0;
        end
        case_awc: begin
                dsc = 0;
                rsr = 0;
                usc = 0;
                lsr = 0;
                awc = 1;
                and_ = 0;
                xwc = 0;
                or_ = 0;

                mult = 0;
                add = 0;
                sub = 0;
        end
        case_and_: begin
                dsc = 0;
                rsr = 0;
                usc = 0;
                lsr = 0;
                awc = 0;
                and_ = 1;
                xwc = 0;
                or_ = 0;

                mult = 0;
                add = 0;
                sub = 0;
        end
        case_xwc: begin
                dsc = 0;
                rsr = 0;
                usc = 0;
                lsr = 0;
                awc = 0;
                and_ = 0;
                xwc = 1;
                or_ = 0;

                mult = 0;
                add = 0;
                sub = 0;
        end
        case_or_: begin
                dsc = 0;
                rsr = 0;
                usc = 0;
                lsr = 0;
                awc = 0;
                and_ = 0;
                xwc = 0;
                or_ = 1;

                mult = 0;
                add = 0;
                sub = 0;
        end
        default: begin 
                dsc = 0;
                rsr = 0;
                usc = 0;
                lsr = 0;
                awc = 0;
                and_ = 0;
                xwc = 0;
                or_ = 0;

                mult = 0;
                add = 0;
                sub = 0;
        end
    endcase
end

endmodule