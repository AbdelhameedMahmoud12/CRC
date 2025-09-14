vlib work

vlog *.v

vsim -voptargs=+acc LFSR_CRC_tb 


add wave /LFSR_CRC_tb/DATA_tb
add wave /LFSR_CRC_tb/ACTIVTE_tb
add wave /LFSR_CRC_tb/CLK_tb
add wave /LFSR_CRC_tb/RST_tb
add wave /LFSR_CRC_tb/CRC_tb
add wave /LFSR_CRC_tb/VALID_tb

run -all