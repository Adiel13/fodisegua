module mux4 (din1, din2, din3, din4, select, dout);

   parameter WIDTH= 8;

   input  [WIDTH-1:0] din1, din2, din3, din4;
   input  [1:0] select;
   output [WIDTH-1:0] dout;
   reg [WIDTH-1:0] dout;

   always @* begin
      case (select)
         2'b00: dout = din1;
         2'b01: dout = din2;
         2'b10: dout = din3;
         2'b11: dout = din4;
      endcase
   end
endmodule
