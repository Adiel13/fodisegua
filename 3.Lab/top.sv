module top #(
parameter WIDTH= 8
) (
    input clk,
    input rst,
    input [6:0] cmdin,
    input [WIDTH-1:0] din_1,
    input [WIDTH-1:0] din_2,
    input [WIDTH-1:0] din_3,
    output logic[WIDTH-1:0] dout_low,
    output logic[WIDTH-1:0] dout_high,
    output logic cpu_rdy,
    output logic zero,
    output logic error
);

endmodule