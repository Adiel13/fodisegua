module ALU #(
    parameter WIDTH = 8
) (
    input [WIDTH-1:0] in1, in2,
    input [3:0] op,
    input invalid_data,
    output logic [2*WIDTH-1:0] out,
    output logic zero,
    output logic error
);

always_comb begin
    if (invalid_data) begin
        out = '0;
        error = 1'b0;
    end else begin
        error = 1'b0;
        case (op)
            4'b0000: out = in1 + in2;
            4'b0001: out = in1 - in2;
            4'b0010: out = in1 * in2;
            4'b0011: begin
                if (in2 == 0) begin
                    out = '0;
                    error = 1'b1;
                end else begin
                    out = in1 / in2;
                end
            end
            4'b0101,
            4'b0110: out = in2;
            default: out = '0;
        endcase
    end

    zero = (out == 0);
end

endmodule