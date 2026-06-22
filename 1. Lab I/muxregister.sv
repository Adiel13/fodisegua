module mux4_registered #(
parameter WIDTH= 8
) (
input clk,
input rst,
input wr_en,
input [1:0] sel,
input [WIDTH-1:0] in1, in2, in3, in4,
output logic [WIDTH-1:0] out
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        out <= '0;
    end else if (wr_en) begin
        case (sel)
            2'b00: out <= in1;
            2'b01: out <= in2;
            2'b10: out <= in3;
            2'b11: out <= in4;
        endcase
    end
end

endmodule