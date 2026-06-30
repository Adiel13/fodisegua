`timescale 1ns/1ps

module mux4_registered #(
  parameter WIDTH=8
  ) (
  input  clk,
  input  rst,
  input  wr_en,
  input  [1:0] sel,
  input  [WIDTH-1:0] in1, in2, in3, in4,
  output reg [WIDTH-1:0] out
);
 
reg [WIDTH-1:0] muxout;
 
mux4 #( .WIDTH(WIDTH) ) mux4_inst (
  .din1(in1), .din2(in2), .din3(in3), .din4(in4),
  .select(sel),
  .dout(muxout)
);

register_bank #( .WIDTH(WIDTH) ) regbank_inst (
  .clk(clk),
  .rst(rst),
  .wr_en(wr_en),
  .in(muxout),
  .out(out)
);

endmodule
