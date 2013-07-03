onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /glitch_power_tb/tb_clk_o
add wave -noupdate /glitch_power_tb/tb_rst_o
add wave -noupdate /glitch_power_tb/tb_run_o
add wave -noupdate -radix decimal /glitch_power_tb/tb_size_o
add wave -noupdate -radix decimal /glitch_power_tb/tb_step_o
add wave -noupdate /glitch_power_tb/tb_finished_i
add wave -noupdate /glitch_power_tb/tb_power_i
add wave -noupdate -divider internal
add wave -noupdate /glitch_power_tb/dgp/clk_i
add wave -noupdate /glitch_power_tb/dgp/rst_i
add wave -noupdate /glitch_power_tb/dgp/run_i
add wave -noupdate -radix decimal /glitch_power_tb/dgp/size_i
add wave -noupdate -radix decimal /glitch_power_tb/dgp/step_i
add wave -noupdate /glitch_power_tb/dgp/finished_o
add wave -noupdate /glitch_power_tb/dgp/power_o
add wave -noupdate -radix decimal /glitch_power_tb/dgp/run_cnt
add wave -noupdate -radix decimal /glitch_power_tb/dgp/iter_cnt
add wave -noupdate -radix decimal /glitch_power_tb/dgp/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {659000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 243
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {256348 ps}
