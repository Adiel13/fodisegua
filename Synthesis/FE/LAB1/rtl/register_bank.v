module register_bank (clk, rst, wr_en, in, out);

   parameter WIDTH = 8; 

   input clk, rst, wr_en;
   input  [WIDTH-1:0] in; 
   output [WIDTH-1:0] out;
   reg [WIDTH-1:0] out;

   always @(posedge clk) begin
      if (!rst) out <= 0;
      else if (wr_en) out <= in;
      else out <= out;
   end

endmodule
