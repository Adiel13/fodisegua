module top #( parameter WIDTH=8 ) (
input clk,
input rst,
input wr_en,
input [1:0] sel,
input [WIDTH-1:0] a, b,
output reg [WIDTH-1:0] out
);
 
wire [WIDTH-1:0] op_add, op_div, op_or, op_inv;

my_add #( .WIDTH(WIDTH) ) my_add_inst (.a(a),.b(b),.out(op_add));
my_div #( .WIDTH(WIDTH) ) my_div_inst (.a(a),.b(b),.out(op_div));
my_or  #( .WIDTH(WIDTH) ) my_or_inst  (.a(a),.b(b),.out(op_or));
my_inv #( .WIDTH(WIDTH) ) my_inv_inst (.a(a),.out(op_inv));

// Mux4-registered instance
mux4_registered #( .WIDTH(WIDTH) ) mux4reg_inst (
.clk(clk),
.rst(rst),
.wr_en(wr_en),
.sel(sel),
.in1(op_add), .in2(op_div), .in3(op_or), .in4(op_inv),
.out(out)
);
 
endmodule

// Module for addition
module my_add #( parameter WIDTH=8) (
input [WIDTH-1:0] a, b,
output [WIDTH-1:0] out );
	assign out = a + b;
endmodule

// Module for division
module my_div #( parameter WIDTH=8) (
input [WIDTH-1:0] a, b,
output [WIDTH-1:0] out );
	assign out = a / b;
endmodule

// Module for OR operation
module my_or #( parameter WIDTH=8) (
input [WIDTH-1:0] a, b,
output [WIDTH-1:0] out );
	assign out = a | b;
endmodule

// Module for inversion
module my_inv #( parameter WIDTH=8) (
input [WIDTH-1:0] a,
output [WIDTH-1:0] out );
	assign out = ~a;
endmodule
