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

endmodule