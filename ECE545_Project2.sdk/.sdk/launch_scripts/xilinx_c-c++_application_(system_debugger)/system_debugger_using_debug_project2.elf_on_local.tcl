connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Nexys4DDR 210292A4BF46A"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Nexys4DDR 210292A4BF46A"} -index 0
dow C:/Users/wrayr/Documents/Xilinx_Projects/ECE544/ECE545_Project2/ECE545_Project2.sdk/Project2/Debug/Project2.elf
bpadd -addr &main
