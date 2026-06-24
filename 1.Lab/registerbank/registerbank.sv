module register_bank #(
    parameter WIDTH = 8
    ) (
        input clk,
        input rst,
        input wr_en,
        input [WIDTH-1:0] in,
        output logic [WIDTH-1:0] out
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        out <= '0;
    end else if (wr_en) begin
        out <= in;
    end
end

endmodule