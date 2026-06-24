module top #(
parameter WIDTH = 8
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

logic [WIDTH-1:0] mux_a_out;
logic [WIDTH-1:0] mux_b_out;
logic [WIDTH-1:0] reg_a_out;
logic [WIDTH-1:0] reg_b_out;
logic [2*WIDTH-1:0] alu_out;
logic [2*WIDTH-1:0] mem_out;
logic [2*WIDTH-1:0] final_out;
logic [7:0] memory_address;
logic [3:0] alu_opcode;
logic aluin_reg_en;
logic datain_reg_en;
logic memoryWrite;
logic memoryRead;
logic selmux2;
logic aluout_reg_en;
logic nvalid_data;
logic [1:0] in_select_a;
logic [1:0] in_select_b;
logic [3:0] opcode;
logic p_error;
logic alu_error;

assign p_error = 1'b0;
assign alu_opcode = opcode;
assign error = alu_error;

always_comb begin
    case (in_select_a)
        2'b00: mux_a_out = din_1;
        2'b01: mux_a_out = din_2;
        2'b10: mux_a_out = din_3;
        default: mux_a_out = dout_low;
    endcase

    case (in_select_b)
        2'b00: mux_b_out = din_1;
        2'b01: mux_b_out = din_2;
        2'b10: mux_b_out = din_3;
        default: mux_b_out = dout_low;
    endcase
end

generate
    if (WIDTH <= 8) begin
        assign memory_address = { {(8-WIDTH){1'b0}}, reg_a_out };
    end else begin
        assign memory_address = reg_a_out[7:0];
    end
endgenerate

control control_inst (
    .clk(clk),
    .rst(rst),
    .cmd_in(cmdin),
    .p_error(p_error),
    .aluin_reg_en(aluin_reg_en),
    .datain_reg_en(datain_reg_en),
    .memoryWrite(memoryWrite),
    .memoryRead(memoryRead),
    .selmux2(selmux2),
    .cpu_rdy(cpu_rdy),
    .aluout_reg_en(aluout_reg_en),
    .nvalid_data(nvalid_data),
    .in_select_a(in_select_a),
    .in_select_b(in_select_b),
    .opcode(opcode)
);

register_bank #(.WIDTH(WIDTH)) reg_a (
    .clk(clk),
    .rst(rst),
    .wr_en(aluin_reg_en),
    .in(mux_a_out),
    .out(reg_a_out)
);

register_bank #(.WIDTH(WIDTH)) reg_b (
    .clk(clk),
    .rst(rst),
    .wr_en(datain_reg_en),
    .in(mux_b_out),
    .out(reg_b_out)
);

ALU #(.WIDTH(WIDTH)) alu_inst (
    .in1(reg_a_out),
    .in2(reg_b_out),
    .op(alu_opcode),
    .invalid_data(nvalid_data),
    .out(alu_out),
    .zero(zero),
    .error(alu_error)
);

memory #(.WIDTH(WIDTH)) memory_inst (
    .clk(clk),
    .memoryWrite(memoryWrite),
    .memoryRead(memoryRead),
    .memoryWriteData(alu_out),
    .memoryAddress(memory_address),
    .memoryOutData(mem_out)
);

assign final_out = selmux2 ? mem_out : alu_out;

register_bank #(.WIDTH(2*WIDTH)) output_reg (
    .clk(clk),
    .rst(rst),
    .wr_en(aluout_reg_en),
    .in(final_out),
    .out({dout_high, dout_low})
);

endmodule