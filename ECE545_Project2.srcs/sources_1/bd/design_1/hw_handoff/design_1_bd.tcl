
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2017.3
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
   set_property BOARD_PART digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}


##################################################################
# MIG PRJ FILE TCL PROCs
##################################################################

proc write_mig_file_design_1_mig_7series_0_0 { str_mig_prj_filepath } {

   file mkdir [ file dirname "$str_mig_prj_filepath" ]
   set mig_prj_file [open $str_mig_prj_filepath  w+]

   puts $mig_prj_file {<?xml version='1.0' encoding='UTF-8'?>}
   puts $mig_prj_file {<!-- IMPORTANT: This is an internal file that has been generated by the MIG software. Any direct editing or changes made to this file may result in unpredictable behavior or data corruption. It is strongly advised that users do not edit the contents of this file. Re-run the MIG GUI with the required settings if any of the options provided below need to be altered. -->}
   puts $mig_prj_file {<Project NoOfControllers="1" >}
   puts $mig_prj_file {    <ModuleName>design_1_mig_7series_0_0</ModuleName>}
   puts $mig_prj_file {    <dci_inouts_inputs>1</dci_inouts_inputs>}
   puts $mig_prj_file {    <dci_inputs>1</dci_inputs>}
   puts $mig_prj_file {    <Debug_En>OFF</Debug_En>}
   puts $mig_prj_file {    <DataDepth_En>1024</DataDepth_En>}
   puts $mig_prj_file {    <LowPower_En>ON</LowPower_En>}
   puts $mig_prj_file {    <XADC_En>Enabled</XADC_En>}
   puts $mig_prj_file {    <TargetFPGA>xc7a100t-csg324/-1</TargetFPGA>}
   puts $mig_prj_file {    <Version>4.0</Version>}
   puts $mig_prj_file {    <SystemClock>No Buffer</SystemClock>}
   puts $mig_prj_file {    <ReferenceClock>Use System Clock</ReferenceClock>}
   puts $mig_prj_file {    <SysResetPolarity>ACTIVE LOW</SysResetPolarity>}
   puts $mig_prj_file {    <BankSelectionFlag>FALSE</BankSelectionFlag>}
   puts $mig_prj_file {    <InternalVref>1</InternalVref>}
   puts $mig_prj_file {    <dci_hr_inouts_inputs>50 Ohms</dci_hr_inouts_inputs>}
   puts $mig_prj_file {    <dci_cascade>0</dci_cascade>}
   puts $mig_prj_file {    <Controller number="0" >}
   puts $mig_prj_file {        <MemoryDevice>DDR2_SDRAM/Components/MT47H64M16HR-25E</MemoryDevice>}
   puts $mig_prj_file {        <TimePeriod>5000</TimePeriod>}
   puts $mig_prj_file {        <VccAuxIO>1.8V</VccAuxIO>}
   puts $mig_prj_file {        <PHYRatio>4:1</PHYRatio>}
   puts $mig_prj_file {        <InputClkFreq>200</InputClkFreq>}
   puts $mig_prj_file {        <UIExtraClocks>1</UIExtraClocks>}
   puts $mig_prj_file {        <MMCM_VCO>1200</MMCM_VCO>}
   puts $mig_prj_file {        <MMCMClkOut0>12.000</MMCMClkOut0>}
   puts $mig_prj_file {        <MMCMClkOut1>1</MMCMClkOut1>}
   puts $mig_prj_file {        <MMCMClkOut2>1</MMCMClkOut2>}
   puts $mig_prj_file {        <MMCMClkOut3>1</MMCMClkOut3>}
   puts $mig_prj_file {        <MMCMClkOut4>1</MMCMClkOut4>}
   puts $mig_prj_file {        <DataWidth>16</DataWidth>}
   puts $mig_prj_file {        <DeepMemory>1</DeepMemory>}
   puts $mig_prj_file {        <DataMask>1</DataMask>}
   puts $mig_prj_file {        <ECC>Disabled</ECC>}
   puts $mig_prj_file {        <Ordering>Normal</Ordering>}
   puts $mig_prj_file {        <BankMachineCnt>4</BankMachineCnt>}
   puts $mig_prj_file {        <CustomPart>FALSE</CustomPart>}
   puts $mig_prj_file {        <NewPartName></NewPartName>}
   puts $mig_prj_file {        <RowAddress>13</RowAddress>}
   puts $mig_prj_file {        <ColAddress>10</ColAddress>}
   puts $mig_prj_file {        <BankAddress>3</BankAddress>}
   puts $mig_prj_file {        <C0_MEM_SIZE>134217728</C0_MEM_SIZE>}
   puts $mig_prj_file {        <UserMemoryAddressMap>BANK_ROW_COLUMN</UserMemoryAddressMap>}
   puts $mig_prj_file {        <PinSelection>}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="M4" SLEW="" name="ddr2_addr[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="R2" SLEW="" name="ddr2_addr[10]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="K5" SLEW="" name="ddr2_addr[11]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="N6" SLEW="" name="ddr2_addr[12]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="P4" SLEW="" name="ddr2_addr[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="M6" SLEW="" name="ddr2_addr[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="T1" SLEW="" name="ddr2_addr[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="L3" SLEW="" name="ddr2_addr[4]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="P5" SLEW="" name="ddr2_addr[5]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="M2" SLEW="" name="ddr2_addr[6]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="N1" SLEW="" name="ddr2_addr[7]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="L4" SLEW="" name="ddr2_addr[8]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="N5" SLEW="" name="ddr2_addr[9]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="P2" SLEW="" name="ddr2_ba[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="P3" SLEW="" name="ddr2_ba[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="R1" SLEW="" name="ddr2_ba[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="L1" SLEW="" name="ddr2_cas_n" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL18_II" PADName="L5" SLEW="" name="ddr2_ck_n[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL18_II" PADName="L6" SLEW="" name="ddr2_ck_p[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="M1" SLEW="" name="ddr2_cke[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="K6" SLEW="" name="ddr2_cs_n[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="T6" SLEW="" name="ddr2_dm[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="U1" SLEW="" name="ddr2_dm[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="R7" SLEW="" name="ddr2_dq[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="V5" SLEW="" name="ddr2_dq[10]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="U4" SLEW="" name="ddr2_dq[11]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="V4" SLEW="" name="ddr2_dq[12]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="T4" SLEW="" name="ddr2_dq[13]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="V1" SLEW="" name="ddr2_dq[14]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="T3" SLEW="" name="ddr2_dq[15]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="V6" SLEW="" name="ddr2_dq[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="R8" SLEW="" name="ddr2_dq[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="U7" SLEW="" name="ddr2_dq[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="V7" SLEW="" name="ddr2_dq[4]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="R6" SLEW="" name="ddr2_dq[5]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="U6" SLEW="" name="ddr2_dq[6]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="R5" SLEW="" name="ddr2_dq[7]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="T5" SLEW="" name="ddr2_dq[8]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="U3" SLEW="" name="ddr2_dq[9]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL18_II" PADName="V9" SLEW="" name="ddr2_dqs_n[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL18_II" PADName="V2" SLEW="" name="ddr2_dqs_n[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL18_II" PADName="U9" SLEW="" name="ddr2_dqs_p[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL18_II" PADName="U2" SLEW="" name="ddr2_dqs_p[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="M3" SLEW="" name="ddr2_odt[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="N4" SLEW="" name="ddr2_ras_n" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL18_II" PADName="N2" SLEW="" name="ddr2_we_n" IN_TERM="" />}
   puts $mig_prj_file {        </PinSelection>}
   puts $mig_prj_file {        <System_Control>}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="sys_rst" />}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="init_calib_complete" />}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="tg_compare_error" />}
   puts $mig_prj_file {        </System_Control>}
   puts $mig_prj_file {        <TimingParameters>}
   puts $mig_prj_file {            <Parameters twtr="7.5" trrd="10" trefi="7.8" tfaw="45" trtp="7.5" trfc="127.5" trp="12.5" tras="40" trcd="15" />}
   puts $mig_prj_file {        </TimingParameters>}
   puts $mig_prj_file {        <mrBurstLength name="Burst Length" >8</mrBurstLength>}
   puts $mig_prj_file {        <mrBurstType name="Burst Type" >Sequential</mrBurstType>}
   puts $mig_prj_file {        <mrCasLatency name="CAS Latency" >3</mrCasLatency>}
   puts $mig_prj_file {        <mrMode name="Mode" >Normal</mrMode>}
   puts $mig_prj_file {        <mrDllReset name="DLL Reset" >No</mrDllReset>}
   puts $mig_prj_file {        <mrPdMode name="PD Mode" >Fast exit</mrPdMode>}
   puts $mig_prj_file {        <mrWriteRecovery name="Write Recovery" ></mrWriteRecovery>}
   puts $mig_prj_file {        <emrDllEnable name="DLL Enable" >Enable-Normal</emrDllEnable>}
   puts $mig_prj_file {        <emrOutputDriveStrength name="Output Drive Strength" >Fullstrength</emrOutputDriveStrength>}
   puts $mig_prj_file {        <emrCSSelection name="Controller Chip Select Pin" >Enable</emrCSSelection>}
   puts $mig_prj_file {        <emrCKSelection name="Memory Clock Selection" >1</emrCKSelection>}
   puts $mig_prj_file {        <emrRTT name="RTT (nominal) - ODT" >50ohms</emrRTT>}
   puts $mig_prj_file {        <emrPosted name="Additive Latency (AL)" >0</emrPosted>}
   puts $mig_prj_file {        <emrOCD name="OCD Operation" >OCD Exit</emrOCD>}
   puts $mig_prj_file {        <emrDQS name="DQS# Enable" >Enable</emrDQS>}
   puts $mig_prj_file {        <emrRDQS name="RDQS Enable" >Disable</emrRDQS>}
   puts $mig_prj_file {        <emrOutputs name="Outputs" >Enable</emrOutputs>}
   puts $mig_prj_file {        <PortInterface>AXI</PortInterface>}
   puts $mig_prj_file {        <AXIParameters>}
   puts $mig_prj_file {            <C0_C_RD_WR_ARB_ALGORITHM>RD_PRI_REG</C0_C_RD_WR_ARB_ALGORITHM>}
   puts $mig_prj_file {            <C0_S_AXI_ADDR_WIDTH>27</C0_S_AXI_ADDR_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_DATA_WIDTH>64</C0_S_AXI_DATA_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_ID_WIDTH>2</C0_S_AXI_ID_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_SUPPORTS_NARROW_BURST>0</C0_S_AXI_SUPPORTS_NARROW_BURST>}
   puts $mig_prj_file {        </AXIParameters>}
   puts $mig_prj_file {    </Controller>}
   puts $mig_prj_file {</Project>}

   close $mig_prj_file
}
# End of write_mig_file_design_1_mig_7series_0_0()



##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB

  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 lmb_bram ]
  set_property -dict [ list \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set ddr2_sdram [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 ddr2_sdram ]
  set dip_switches_16bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 dip_switches_16bits ]
  set ja [ create_bd_intf_port -mode Master -vlnv digilentinc.com:interface:pmod_rtl:1.0 ja ]
  set jb [ create_bd_intf_port -mode Master -vlnv digilentinc.com:interface:pmod_rtl:1.0 jb ]
  set jc [ create_bd_intf_port -mode Master -vlnv digilentinc.com:interface:pmod_rtl:1.0 jc ]
  set led_16bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 led_16bits ]
  set push_buttons_5bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 push_buttons_5bits ]
  set usb_uart [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 usb_uart ]

  # Create ports
  set reset [ create_bd_port -dir I -type rst reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $reset
  set sys_clock [ create_bd_port -dir I -type clk sys_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   CONFIG.PHASE {0.000} \
 ] $sys_clock

  # Create instance: PmodENC_0, and set properties
  set PmodENC_0 [ create_bd_cell -type ip -vlnv ece.pdx.edu:ece544:PmodENC:1.0 PmodENC_0 ]

  # Create instance: PmodOLEDrgb_0, and set properties
  set PmodOLEDrgb_0 [ create_bd_cell -type ip -vlnv digilentinc.com:IP:PmodOLEDrgb:1.0 PmodOLEDrgb_0 ]
  set_property -dict [ list \
   CONFIG.PMOD {jb} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $PmodOLEDrgb_0

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_INTERRUPT_PRESENT {1} \
   CONFIG.GPIO2_BOARD_INTERFACE {dip_switches_16bits} \
   CONFIG.GPIO_BOARD_INTERFACE {led_16bits} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_gpio_0

  # Create instance: axi_gpio_1, and set properties
  set axi_gpio_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_1 ]
  set_property -dict [ list \
   CONFIG.C_INTERRUPT_PRESENT {1} \
   CONFIG.GPIO_BOARD_INTERFACE {push_buttons_5bits} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_gpio_1

  # Create instance: axi_gpio_2, and set properties
  set axi_gpio_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_2 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_GPIO2_WIDTH {1} \
   CONFIG.C_GPIO_WIDTH {2} \
   CONFIG.C_INTERRUPT_PRESENT {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_2

  # Create instance: axi_timebase_wdt_0, and set properties
  set axi_timebase_wdt_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timebase_wdt:3.0 axi_timebase_wdt_0 ]
  set_property -dict [ list \
   CONFIG.ENABLE_WINDOW_WDT {0} \
 ] $axi_timebase_wdt_0

  # Create instance: axi_timer_0, and set properties
  set axi_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0 ]
  set_property -dict [ list \
   CONFIG.enable_timer2 {1} \
 ] $axi_timer_0

  # Create instance: axi_timer_1, and set properties
  set axi_timer_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_1 ]

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list \
   CONFIG.C_BAUDRATE {115200} \
   CONFIG.UARTLITE_BOARD_INTERFACE {usb_uart} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_uartlite_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.4 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKOUT2_JITTER {151.636} \
   CONFIG.CLKOUT2_PHASE_ERROR {98.575} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {50.000} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_JITTER {114.829} \
   CONFIG.CLKOUT3_PHASE_ERROR {98.575} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {200.000} \
   CONFIG.CLKOUT3_USED {true} \
   CONFIG.CLK_IN1_BOARD_INTERFACE {sys_clock} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {20} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {5} \
   CONFIG.MMCM_DIVCLK_DIVIDE {1} \
   CONFIG.NUM_OUT_CLKS {3} \
   CONFIG.USE_BOARD_FLOW {true} \
   CONFIG.USE_RESET {false} \
 ] $clk_wiz_0

  # Create instance: fit_timer_0, and set properties
  set fit_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fit_timer:2.0 fit_timer_0 ]
  set_property -dict [ list \
   CONFIG.C_NO_CLOCKS {20000} \
 ] $fit_timer_0

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]
  set_property -dict [ list \
   CONFIG.C_USE_UART {1} \
 ] $mdm_1

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:10.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_TAG_BITS {15} \
   CONFIG.C_CACHE_BYTE_SIZE {32768} \
   CONFIG.C_DCACHE_ADDR_TAG {15} \
   CONFIG.C_DCACHE_BYTE_SIZE {32768} \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_I_LMB {1} \
   CONFIG.C_USE_BARREL {1} \
   CONFIG.C_USE_DCACHE {1} \
   CONFIG.C_USE_FPU {1} \
   CONFIG.C_USE_ICACHE {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list \
   CONFIG.C_HAS_FAST {1} \
 ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {13} \
   CONFIG.NUM_SI {3} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: microblaze_0_xlconcat, and set properties
  set microblaze_0_xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 microblaze_0_xlconcat ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {9} \
 ] $microblaze_0_xlconcat

  # Create instance: mig_7series_0, and set properties
  set mig_7series_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series:4.0 mig_7series_0 ]

  # Generate the PRJ File for MIG
  set str_mig_folder [get_property IP_DIR [ get_ips [ get_property CONFIG.Component_Name $mig_7series_0 ] ] ]
  set str_mig_file_name mig_a.prj
  set str_mig_file_path ${str_mig_folder}/${str_mig_file_name}

  write_mig_file_design_1_mig_7series_0_0 $str_mig_file_path

  set_property -dict [ list \
   CONFIG.BOARD_MIG_PARAM {ddr2_sdram} \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.XML_INPUT_FILE {mig_a.prj} \
 ] $mig_7series_0

  # Create instance: pmod_bridge_0, and set properties
  set pmod_bridge_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:pmod_bridge:1.0 pmod_bridge_0 ]
  set_property -dict [ list \
   CONFIG.Bottom_Row_Interface {Disabled} \
   CONFIG.PMOD {ja} \
   CONFIG.Top_Row_Interface {None} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $pmod_bridge_0

  # Create instance: pmod_bridge_1, and set properties
  set pmod_bridge_1 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:pmod_bridge:1.0 pmod_bridge_1 ]
  set_property -dict [ list \
   CONFIG.Bottom_Row_Interface {Disabled} \
   CONFIG.PMOD {jc} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $pmod_bridge_1

  # Create instance: rst_clk_wiz_0_100M, and set properties
  set rst_clk_wiz_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_0_100M ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {reset} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $rst_clk_wiz_0_100M

  # Create instance: rst_mig_7series_0_81M, and set properties
  set rst_mig_7series_0_81M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_mig_7series_0_81M ]

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_WIDTH {1} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net PmodOLEDrgb_0_PmodOLEDrgb_out [get_bd_intf_ports jb] [get_bd_intf_pins PmodOLEDrgb_0/PmodOLEDrgb_out]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports led_16bits] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO2 [get_bd_intf_ports dip_switches_16bits] [get_bd_intf_pins axi_gpio_0/GPIO2]
  connect_bd_intf_net -intf_net axi_gpio_1_GPIO [get_bd_intf_ports push_buttons_5bits] [get_bd_intf_pins axi_gpio_1/GPIO]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports usb_uart] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DC [get_bd_intf_pins microblaze_0/M_AXI_DC] [get_bd_intf_pins microblaze_0_axi_periph/S01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_IC [get_bd_intf_pins microblaze_0/M_AXI_IC] [get_bd_intf_pins microblaze_0_axi_periph/S02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_dp [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI] [get_bd_intf_pins mig_7series_0/S_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins axi_timer_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins PmodOLEDrgb_0/AXI_LITE_GPIO] [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M05_AXI [get_bd_intf_pins PmodOLEDrgb_0/AXI_LITE_SPI] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M06_AXI [get_bd_intf_pins PmodENC_0/S00_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M07_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M08_AXI [get_bd_intf_pins axi_gpio_1/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M09_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M09_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M10_AXI [get_bd_intf_pins axi_timebase_wdt_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M10_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M11_AXI [get_bd_intf_pins axi_gpio_2/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M11_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M12_AXI [get_bd_intf_pins axi_timer_1/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M12_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_intc_axi [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]
  connect_bd_intf_net -intf_net microblaze_0_mdm_axi [get_bd_intf_pins mdm_1/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net mig_7series_0_DDR2 [get_bd_intf_ports ddr2_sdram] [get_bd_intf_pins mig_7series_0/DDR2]
  connect_bd_intf_net -intf_net pmod_bridge_0_Pmod_out [get_bd_intf_ports ja] [get_bd_intf_pins pmod_bridge_0/Pmod_out]
  connect_bd_intf_net -intf_net pmod_bridge_1_Pmod_out [get_bd_intf_ports jc] [get_bd_intf_pins pmod_bridge_1/Pmod_out]

  # Create port connections
  connect_bd_net -net axi_gpio_0_ip2intc_irpt [get_bd_pins axi_gpio_0/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In2]
  connect_bd_net -net axi_gpio_1_ip2intc_irpt [get_bd_pins axi_gpio_1/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In3]
  connect_bd_net -net axi_gpio_2_gpio2_io_o [get_bd_pins axi_gpio_2/gpio2_io_o] [get_bd_pins pmod_bridge_0/in0_O]
  connect_bd_net -net axi_gpio_2_ip2intc_irpt [get_bd_pins axi_gpio_2/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In8]
  connect_bd_net -net axi_timebase_wdt_0_timebase_interrupt [get_bd_pins axi_timebase_wdt_0/timebase_interrupt] [get_bd_pins microblaze_0_xlconcat/In4]
  connect_bd_net -net axi_timebase_wdt_0_wdt_interrupt [get_bd_pins axi_timebase_wdt_0/wdt_interrupt] [get_bd_pins microblaze_0_xlconcat/In5]
  connect_bd_net -net axi_timebase_wdt_0_wdt_reset [get_bd_pins axi_timebase_wdt_0/wdt_reset] [get_bd_pins rst_clk_wiz_0_100M/aux_reset_in]
  connect_bd_net -net axi_timer_0_interrupt [get_bd_pins axi_timer_0/interrupt] [get_bd_pins microblaze_0_xlconcat/In0]
  connect_bd_net -net axi_timer_1_interrupt [get_bd_pins axi_timer_1/interrupt] [get_bd_pins microblaze_0_xlconcat/In7]
  connect_bd_net -net axi_timer_1_pwm0 [get_bd_pins axi_timer_1/pwm0] [get_bd_pins pmod_bridge_0/in1_O]
  connect_bd_net -net axi_uartlite_0_interrupt [get_bd_pins axi_uartlite_0/interrupt] [get_bd_pins microblaze_0_xlconcat/In6]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins PmodOLEDrgb_0/ext_spi_clk] [get_bd_pins clk_wiz_0/clk_out2]
  connect_bd_net -net clk_wiz_0_clk_out3 [get_bd_pins clk_wiz_0/clk_out3] [get_bd_pins mig_7series_0/sys_clk_i]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins rst_clk_wiz_0_100M/dcm_locked]
  connect_bd_net -net fit_timer_0_Interrupt [get_bd_pins fit_timer_0/Interrupt] [get_bd_pins microblaze_0_xlconcat/In1]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rst_clk_wiz_0_100M/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins PmodENC_0/s00_axi_aclk] [get_bd_pins PmodOLEDrgb_0/s_axi_aclk] [get_bd_pins PmodOLEDrgb_0/s_axi_aclk2] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_gpio_1/s_axi_aclk] [get_bd_pins axi_gpio_2/s_axi_aclk] [get_bd_pins axi_timebase_wdt_0/s_axi_aclk] [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins axi_timer_1/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins fit_timer_0/Clk] [get_bd_pins mdm_1/S_AXI_ACLK] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/M06_ACLK] [get_bd_pins microblaze_0_axi_periph/M07_ACLK] [get_bd_pins microblaze_0_axi_periph/M08_ACLK] [get_bd_pins microblaze_0_axi_periph/M09_ACLK] [get_bd_pins microblaze_0_axi_periph/M10_ACLK] [get_bd_pins microblaze_0_axi_periph/M11_ACLK] [get_bd_pins microblaze_0_axi_periph/M12_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_axi_periph/S01_ACLK] [get_bd_pins microblaze_0_axi_periph/S02_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins rst_clk_wiz_0_100M/slowest_sync_clk]
  connect_bd_net -net microblaze_0_intr [get_bd_pins microblaze_0_axi_intc/intr] [get_bd_pins microblaze_0_xlconcat/dout]
  connect_bd_net -net mig_7series_0_mmcm_locked [get_bd_pins mig_7series_0/mmcm_locked] [get_bd_pins rst_mig_7series_0_81M/dcm_locked]
  connect_bd_net -net mig_7series_0_ui_clk [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins mig_7series_0/ui_clk] [get_bd_pins rst_mig_7series_0_81M/slowest_sync_clk]
  connect_bd_net -net mig_7series_0_ui_clk_sync_rst [get_bd_pins mig_7series_0/ui_clk_sync_rst] [get_bd_pins rst_mig_7series_0_81M/ext_reset_in]
  connect_bd_net -net pmod_bridge_0_in2_I [get_bd_pins pmod_bridge_0/in2_I] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net pmod_bridge_0_in3_I [get_bd_pins pmod_bridge_0/in3_I] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net pmod_bridge_1_in0_I [get_bd_pins PmodENC_0/pmodENC_A] [get_bd_pins pmod_bridge_1/in0_I]
  connect_bd_net -net pmod_bridge_1_in1_I [get_bd_pins PmodENC_0/pmodENC_B] [get_bd_pins pmod_bridge_1/in1_I]
  connect_bd_net -net pmod_bridge_1_in2_I [get_bd_pins PmodENC_0/pmodENC_btn] [get_bd_pins pmod_bridge_1/in2_I]
  connect_bd_net -net pmod_bridge_1_in3_I [get_bd_pins PmodENC_0/pmodENC_sw] [get_bd_pins pmod_bridge_1/in3_I]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins mig_7series_0/sys_rst] [get_bd_pins rst_clk_wiz_0_100M/ext_reset_in]
  connect_bd_net -net rst_clk_wiz_0_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins rst_clk_wiz_0_100M/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_0_100M_interconnect_aresetn [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins rst_clk_wiz_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_clk_wiz_0_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst] [get_bd_pins rst_clk_wiz_0_100M/mb_reset]
  connect_bd_net -net rst_clk_wiz_0_100M_peripheral_aresetn [get_bd_pins PmodENC_0/s00_axi_aresetn] [get_bd_pins PmodOLEDrgb_0/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_gpio_1/s_axi_aresetn] [get_bd_pins axi_gpio_2/s_axi_aresetn] [get_bd_pins axi_timebase_wdt_0/s_axi_aresetn] [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins axi_timer_1/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins mdm_1/S_AXI_ARESETN] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins microblaze_0_axi_periph/M06_ARESETN] [get_bd_pins microblaze_0_axi_periph/M07_ARESETN] [get_bd_pins microblaze_0_axi_periph/M08_ARESETN] [get_bd_pins microblaze_0_axi_periph/M09_ARESETN] [get_bd_pins microblaze_0_axi_periph/M10_ARESETN] [get_bd_pins microblaze_0_axi_periph/M11_ARESETN] [get_bd_pins microblaze_0_axi_periph/M12_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins microblaze_0_axi_periph/S01_ARESETN] [get_bd_pins microblaze_0_axi_periph/S02_ARESETN] [get_bd_pins rst_clk_wiz_0_100M/peripheral_aresetn]
  connect_bd_net -net rst_clk_wiz_0_100M_peripheral_reset [get_bd_pins fit_timer_0/Rst] [get_bd_pins rst_clk_wiz_0_100M/peripheral_reset]
  connect_bd_net -net rst_mig_7series_0_81M_peripheral_aresetn [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins mig_7series_0/aresetn] [get_bd_pins rst_mig_7series_0_81M/peripheral_aresetn]
  connect_bd_net -net sys_clock_1 [get_bd_ports sys_clock] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins axi_gpio_2/gpio_io_i] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins pmod_bridge_0/in2_T] [get_bd_pins pmod_bridge_0/in3_T] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins pmod_bridge_0/in0_T] [get_bd_pins pmod_bridge_0/in1_T] [get_bd_pins pmod_bridge_0/in2_O] [get_bd_pins pmod_bridge_0/in3_O] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins pmod_bridge_1/in0_O] [get_bd_pins pmod_bridge_1/in0_T] [get_bd_pins pmod_bridge_1/in1_O] [get_bd_pins pmod_bridge_1/in1_T] [get_bd_pins pmod_bridge_1/in2_O] [get_bd_pins pmod_bridge_1/in2_T] [get_bd_pins pmod_bridge_1/in3_O] [get_bd_pins pmod_bridge_1/in3_T] [get_bd_pins xlconstant_2/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs PmodENC_0/S00_AXI/S00_AXI_reg] SEG_PmodENC_0_S00_AXI_reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs PmodOLEDrgb_0/AXI_LITE_GPIO/AXI_LITE_GPIO_reg] SEG_PmodOLEDrgb_0_AXI_LITE_GPIO_reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs PmodOLEDrgb_0/AXI_LITE_SPI/AXI_LITE_SPI_reg] SEG_PmodOLEDrgb_0_AXI_LITE_SPI_reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40010000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_gpio_1/S_AXI/Reg] SEG_axi_gpio_1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40020000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_gpio_2/S_AXI/Reg] SEG_axi_gpio_2_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41A00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_timebase_wdt_0/S_AXI/Reg] SEG_axi_timebase_wdt_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_timer_0/S_AXI/Reg] SEG_axi_timer_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41C10000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_timer_1/S_AXI/Reg] SEG_axi_timer_1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41C10000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs axi_timer_1/S_AXI/Reg] SEG_axi_timer_1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00020000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00020000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs mdm_1/S_AXI/Reg] SEG_mdm_1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_axi_intc/S_AXI/Reg] SEG_microblaze_0_axi_intc_Reg
  create_bd_addr_seg -range 0x08000000 -offset 0x80000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs mig_7series_0/memmap/memaddr] SEG_mig_7series_0_memaddr
  create_bd_addr_seg -range 0x08000000 -offset 0x80000000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs mig_7series_0/memmap/memaddr] SEG_mig_7series_0_memaddr

  # Exclude Address Segments
  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs PmodENC_0/S00_AXI/S00_AXI_reg] SEG_PmodENC_0_S00_AXI_reg
  exclude_bd_addr_seg [get_bd_addr_segs microblaze_0/Instruction/SEG_PmodENC_0_S00_AXI_reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs PmodOLEDrgb_0/AXI_LITE_GPIO/AXI_LITE_GPIO_reg] SEG_PmodOLEDrgb_0_AXI_LITE_GPIO_reg
  exclude_bd_addr_seg [get_bd_addr_segs microblaze_0/Instruction/SEG_PmodOLEDrgb_0_AXI_LITE_GPIO_reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs PmodOLEDrgb_0/AXI_LITE_SPI/AXI_LITE_SPI_reg] SEG_PmodOLEDrgb_0_AXI_LITE_SPI_reg
  exclude_bd_addr_seg [get_bd_addr_segs microblaze_0/Instruction/SEG_PmodOLEDrgb_0_AXI_LITE_SPI_reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs microblaze_0/Instruction/SEG_axi_gpio_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x40010000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs axi_gpio_1/S_AXI/Reg] SEG_axi_gpio_1_Reg
  exclude_bd_addr_seg [get_bd_addr_segs microblaze_0/Instruction/SEG_axi_gpio_1_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x40020000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs axi_gpio_2/S_AXI/Reg] SEG_axi_gpio_2_Reg
  exclude_bd_addr_seg [get_bd_addr_segs microblaze_0/Instruction/SEG_axi_gpio_2_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x41A00000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs axi_timebase_wdt_0/S_AXI/Reg] SEG_axi_timebase_wdt_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs microblaze_0/Instruction/SEG_axi_timebase_wdt_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs axi_timer_0/S_AXI/Reg] SEG_axi_timer_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs microblaze_0/Instruction/SEG_axi_timer_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs microblaze_0/Instruction/SEG_axi_uartlite_0_Reg]

  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs mdm_1/S_AXI/Reg] SEG_mdm_1_Reg
  exclude_bd_addr_seg [get_bd_addr_segs microblaze_0/Instruction/SEG_mdm_1_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_axi_intc/S_AXI/Reg] SEG_microblaze_0_axi_intc_Reg
  exclude_bd_addr_seg [get_bd_addr_segs microblaze_0/Instruction/SEG_microblaze_0_axi_intc_Reg]



  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


