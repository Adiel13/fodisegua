module control (
    input clk,
    input rst,
    input [6:0] cmd_in,
    input p_error,
    output logic aluin_reg_en,
    output logic datain_reg_en,
    output logic memoryWrite, memoryRead, selmux2,
    output logic cpu_rdy,
    output logic aluout_reg_en,
    output logic nvalid_data,
    output logic[1:0] in_select_a,
    output logic[1:0] in_select_b,
    output logic[3:0] opcode
);

logic [2:0] opcode3;

assign in_select_a = cmd_in[6:5];
assign in_select_b = cmd_in[4:3];
assign opcode3 = cmd_in[2:0];
assign opcode = {1'b0, opcode3};

always_comb begin
    aluin_reg_en = 1'b0;
    datain_reg_en = 1'b0;
    memoryWrite = 1'b0;
    memoryRead = 1'b0;
    selmux2 = 1'b0;
    cpu_rdy = 1'b1;
    aluout_reg_en = 1'b0;
    nvalid_data = p_error;

    if (rst) begin
        aluin_reg_en = 1'b0;
        datain_reg_en = 1'b0;
        memoryWrite = 1'b0;
        memoryRead = 1'b0;
        selmux2 = 1'b0;
        cpu_rdy = 1'b0;
        aluout_reg_en = 1'b0;
        nvalid_data = 1'b1;
    end else begin
        case (opcode3)
            3'b000,
            3'b001,
            3'b010,
            3'b011: begin
                aluin_reg_en = 1'b1;
                datain_reg_en = 1'b1;
                selmux2 = 1'b0;
                aluout_reg_en = 1'b1;
            end
            3'b100,
            3'b111: begin
                aluin_reg_en = 1'b0;
                datain_reg_en = 1'b0;
                aluout_reg_en = 1'b0;
            end
            3'b101: begin
                aluin_reg_en = 1'b1;
                datain_reg_en = 1'b1;
                memoryRead = 1'b1;
                selmux2 = 1'b1;
                aluout_reg_en = 1'b1;
            end
            3'b110: begin
                aluin_reg_en = 1'b1;
                datain_reg_en = 1'b1;
                memoryWrite = 1'b1;
                selmux2 = 1'b0;
                aluout_reg_en = 1'b1;
            end
            default: begin
                aluin_reg_en = 1'b0;
                datain_reg_en = 1'b0;
                memoryWrite = 1'b0;
                memoryRead = 1'b0;
                selmux2 = 1'b0;
                aluout_reg_en = 1'b0;
            end
        endcase
    end

    if (p_error) begin
        cpu_rdy = 1'b0;
        nvalid_data = 1'b1;
    end
end

endmodule