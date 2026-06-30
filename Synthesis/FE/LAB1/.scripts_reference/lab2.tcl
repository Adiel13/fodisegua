# Search Path and Logic Library Setup
set_app_var search_path "$search_path . ./rtl ./libs"
set_app_var target_library "sky130_fd_sc_hd__ff_100C_1v95.db sky130_fd_sc_hd__ss_100C_1v40.db"
set_app_var link_library "* $target_library"

# RTL Reading and Link
analyze -format verilog {regbank.v muxed_regbank.v control.v alu.v top.v}
elaborate top -parameters "WIDTH=8"
link

# Constraints Setup
set clk_val 30

create_clock -period $clk_val [get_ports clk] -name clk
set_clock_uncertainty -setup [expr $clk_val*0.1] [get_clocks clk]
set_clock_transition -max [expr $clk_val*0.1] [get_clocks clk]
set_clock_latency -source -max [expr $clk_val*0.05] [get_clocks clk]
set_clock_latency -max [expr $clk_val*0.03] [get_clocks clk]

set_input_delay -max [expr $clk_val*0.4] -clock clk [get_ports [remove_from_collection [all_inputs] clk]]
set_output_delay -max [expr $clk_val*0.5] -clock clk [get_ports [all_outputs]]

set_load -max 0.04 [get_ports [all_outputs]]
set_input_transition -min [expr $clk_val*0.01] [get_ports [remove_from_collection [all_inputs] clk]]
set_input_transition -max [expr $clk_val*0.1] [get_ports [remove_from_collection [all_inputs] clk]]

# Pre-compile Reports
report_clock > ./reports/pre_syn_report_clock.rpt
report_clock -skew > ./reports/pre_syn_report_clock_skew.rpt
report_port -verbose > ./reports/pre_syn_report_port_constraints.rpt
check_timing > ./reports/pre_syn_check_timing.rpt
check_design > ./reports/pre_syn_check_design.rpt

# Compile/Synthesis
compile_ultra -no_autoungroup

# Post-compile Reports
report_timing > ./reports/report_timing.rpt
report_qor > ./reports/report_qor.rpt
report_constraints -all_violators > ./reports/report_constraints.rpt
report_power > ./reports/report_power.rpt
check_design > ./reports/check_design.rpt

# Save Design
write_file -format ddc -hierarchy -out outputs/mapped_CPU.ddc

write_file -format verilog -hierarchy -out outputs/mapped_CPU.v
write_sdc outputs/mapped_CPU.sdc

# Exit
return
#exit
