set PROJECT_ROOT /home/homeO5/user1/wuyu/ic/course_design

set SOURCE_DIR $PROJECT_ROOT/src

set REPORT_DIR $PROJECT_ROOT/syn/reports

set NETLIST_DIR $PROJECT_ROOT/syn/netlist
################################################################
##                                                            ##
##                          libraries setup                          ##
##                                                            ##
################################################################

set STD_CELL_LIB_PATH "/export/homeO5/libs/smic18/std_cell/2005q4v1/aci/sc-x/synopsys"


set DW_LIB_PATH "/export/homeO1/synopsys/syn2009/libraries/syn"

set search_path [concat . ${STD_CELL_LIB_PATH}  ${DW_LIB_PATH}]

set target_library {slow.db}

set synthetic_library {"gtech.db" "dw_foundation.sldb"  "standard.sldb"}

set link_library  [concat "*" ${target_library} ${synthetic_library}]

################################################################
##                                                            ##
##                   read and check designs                   ##
##                                                            ##
################################################################

set top_design top

file mkdir Work

define_design_lib work -path ./Work

analyze -f verilog -library work ${SOURCE_DIR}/top.v

analyze -f verilog -library work ${SOURCE_DIR}/top_in.v

analyze -f verilog -library work ${SOURCE_DIR}/top_out.v

analyze -f verilog -library work ${SOURCE_DIR}/data_in_64_to_8.v

analyze -f verilog -library work ${SOURCE_DIR}/uart_tx.v

analyze -f verilog -library work ${SOURCE_DIR}/uart_rx.v

analyze -f verilog -library work ${SOURCE_DIR}/data_out_8_to_64.v


elaborate $top_design

current_design $top_design

link

uniquify

check_design > $REPORT_DIR/check_design_before_compile.rpt

set_max_area 0

################################################################
##                                                            ##
##    set design constraints and optimization constraints     ##
##                                                            ##
################################################################
create_clock -name "clk" -period 20.0 -waveform [list 0 10] [get_ports clk]

set_ideal_network [get_ports [list  clk]]

set_ideal_network [get_ports rst_n]

set_dont_touch_network rst_n

set_dont_touch_network [get_ports [list clk]]

set_false_path -from [get_ports rst_n] -to [all_registers]

set_input_delay -clock clk -max 12 [all_inputs]

set_input_delay -clock clk -min 0 [all_inputs]

set_output_delay -clock clk -max 12 [all_outputs]

################################################################
##                                                            ##
##                   compile and optimization                 ##
##                                                            ##
################################################################

set hdlout_internal_busses true

set bus_naming_style  {%s[%d]}

set bus_inference_style  {%s[%d]}

define_name_rules NAME_RULES -max_length 25  -allowed {A-Za-z0-9_} -first_restricted "0-9" -replacement_char "_" -equal_ports_nets -check_internal_net_name -flatten_multi_dimension_busses

change_names -rules NAME_RULES -hier

remove_unconnected_ports [get_cells -hier *]

set verilogout_show_unconnected_pins true

set verilogout_no_tri ture

set_fix_multiple_port_nets -all -buffer_constants $top_design

change_names -rules verilog -hierarchy


compile

################################################################
##                                                            ##
##                        report results                      ##
##                                                            ##
################################################################

check_design  > $REPORT_DIR/check_design_after_compile.rpt

check_timing  > $REPORT_DIR/check_timing.rpt

report_area  > $REPORT_DIR/area.rpt

report_power  > $REPORT_DIR/power.rpt

report_constraint -all_violators -verbose > $REPORT_DIR/violators.rpt

report_timing -delay max -input_pins  -nets -capacitance -transition_time -slack_lesser_than 10 -max_paths 200 > $REPORT_DIR/timing_setup.rpt

report_timing -delay min -input_pins  -nets -capacitance -transition_time -slack_lesser_than 1 -max_paths 200 > $REPORT_DIR/timing_hold.rpt

report_qor  > $REPORT_DIR/qor.rpt

report_cell > $REPORT_DIR/cells.rpt


################################################################
##                                                            ##
##                          save datas                        ##
##                                                            ##
################################################################


write -f ddc -hier $top_design -output $REPORT_DIR/${top_design}.ddc

write -format verilog -hierarchy $top_design -output $NETLIST_DIR/${top_design}_syn.v

write_sdc  $NETLIST_DIR/${top_design}_syn.sdc

write_sdf -version 3.0 $NETLIST_DIR/${top_design}_syn.sdf

#exit

