//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
//Date        : Fri Feb 16 10:35:31 2018
//Host        : DESKTOP-J8VJUT9 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (ddr2_sdram_addr,
    ddr2_sdram_ba,
    ddr2_sdram_cas_n,
    ddr2_sdram_ck_n,
    ddr2_sdram_ck_p,
    ddr2_sdram_cke,
    ddr2_sdram_cs_n,
    ddr2_sdram_dm,
    ddr2_sdram_dq,
    ddr2_sdram_dqs_n,
    ddr2_sdram_dqs_p,
    ddr2_sdram_odt,
    ddr2_sdram_ras_n,
    ddr2_sdram_we_n,
    dip_switches_16bits_tri_i,
    ja_pin10_io,
    ja_pin1_io,
    ja_pin2_io,
    ja_pin3_io,
    ja_pin4_io,
    ja_pin7_io,
    ja_pin8_io,
    ja_pin9_io,
    jb_pin10_io,
    jb_pin1_io,
    jb_pin2_io,
    jb_pin3_io,
    jb_pin4_io,
    jb_pin7_io,
    jb_pin8_io,
    jb_pin9_io,
    jc_pin10_io,
    jc_pin1_io,
    jc_pin2_io,
    jc_pin3_io,
    jc_pin4_io,
    jc_pin7_io,
    jc_pin8_io,
    jc_pin9_io,
    led_16bits_tri_io,
    push_buttons_5bits_tri_i,
    reset,
    sys_clock,
    sys_rst,
    usb_uart_rxd,
    usb_uart_txd);
  output [12:0]ddr2_sdram_addr;
  output [2:0]ddr2_sdram_ba;
  output ddr2_sdram_cas_n;
  output [0:0]ddr2_sdram_ck_n;
  output [0:0]ddr2_sdram_ck_p;
  output [0:0]ddr2_sdram_cke;
  output [0:0]ddr2_sdram_cs_n;
  output [1:0]ddr2_sdram_dm;
  inout [15:0]ddr2_sdram_dq;
  inout [1:0]ddr2_sdram_dqs_n;
  inout [1:0]ddr2_sdram_dqs_p;
  output [0:0]ddr2_sdram_odt;
  output ddr2_sdram_ras_n;
  output ddr2_sdram_we_n;
  input [15:0]dip_switches_16bits_tri_i;
  inout ja_pin10_io;
  inout ja_pin1_io;
  inout ja_pin2_io;
  inout ja_pin3_io;
  inout ja_pin4_io;
  inout ja_pin7_io;
  inout ja_pin8_io;
  inout ja_pin9_io;
  inout jb_pin10_io;
  inout jb_pin1_io;
  inout jb_pin2_io;
  inout jb_pin3_io;
  inout jb_pin4_io;
  inout jb_pin7_io;
  inout jb_pin8_io;
  inout jb_pin9_io;
  inout jc_pin10_io;
  inout jc_pin1_io;
  inout jc_pin2_io;
  inout jc_pin3_io;
  inout jc_pin4_io;
  inout jc_pin7_io;
  inout jc_pin8_io;
  inout jc_pin9_io;
  inout [15:0]led_16bits_tri_io;
  input [4:0]push_buttons_5bits_tri_i;
  input reset;
  input sys_clock;
  input sys_rst;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire [12:0]ddr2_sdram_addr;
  wire [2:0]ddr2_sdram_ba;
  wire ddr2_sdram_cas_n;
  wire [0:0]ddr2_sdram_ck_n;
  wire [0:0]ddr2_sdram_ck_p;
  wire [0:0]ddr2_sdram_cke;
  wire [0:0]ddr2_sdram_cs_n;
  wire [1:0]ddr2_sdram_dm;
  wire [15:0]ddr2_sdram_dq;
  wire [1:0]ddr2_sdram_dqs_n;
  wire [1:0]ddr2_sdram_dqs_p;
  wire [0:0]ddr2_sdram_odt;
  wire ddr2_sdram_ras_n;
  wire ddr2_sdram_we_n;
  wire [15:0]dip_switches_16bits_tri_i;
  wire ja_pin10_i;
  wire ja_pin10_io;
  wire ja_pin10_o;
  wire ja_pin10_t;
  wire ja_pin1_i;
  wire ja_pin1_io;
  wire ja_pin1_o;
  wire ja_pin1_t;
  wire ja_pin2_i;
  wire ja_pin2_io;
  wire ja_pin2_o;
  wire ja_pin2_t;
  wire ja_pin3_i;
  wire ja_pin3_io;
  wire ja_pin3_o;
  wire ja_pin3_t;
  wire ja_pin4_i;
  wire ja_pin4_io;
  wire ja_pin4_o;
  wire ja_pin4_t;
  wire ja_pin7_i;
  wire ja_pin7_io;
  wire ja_pin7_o;
  wire ja_pin7_t;
  wire ja_pin8_i;
  wire ja_pin8_io;
  wire ja_pin8_o;
  wire ja_pin8_t;
  wire ja_pin9_i;
  wire ja_pin9_io;
  wire ja_pin9_o;
  wire ja_pin9_t;
  wire jb_pin10_i;
  wire jb_pin10_io;
  wire jb_pin10_o;
  wire jb_pin10_t;
  wire jb_pin1_i;
  wire jb_pin1_io;
  wire jb_pin1_o;
  wire jb_pin1_t;
  wire jb_pin2_i;
  wire jb_pin2_io;
  wire jb_pin2_o;
  wire jb_pin2_t;
  wire jb_pin3_i;
  wire jb_pin3_io;
  wire jb_pin3_o;
  wire jb_pin3_t;
  wire jb_pin4_i;
  wire jb_pin4_io;
  wire jb_pin4_o;
  wire jb_pin4_t;
  wire jb_pin7_i;
  wire jb_pin7_io;
  wire jb_pin7_o;
  wire jb_pin7_t;
  wire jb_pin8_i;
  wire jb_pin8_io;
  wire jb_pin8_o;
  wire jb_pin8_t;
  wire jb_pin9_i;
  wire jb_pin9_io;
  wire jb_pin9_o;
  wire jb_pin9_t;
  wire jc_pin10_i;
  wire jc_pin10_io;
  wire jc_pin10_o;
  wire jc_pin10_t;
  wire jc_pin1_i;
  wire jc_pin1_io;
  wire jc_pin1_o;
  wire jc_pin1_t;
  wire jc_pin2_i;
  wire jc_pin2_io;
  wire jc_pin2_o;
  wire jc_pin2_t;
  wire jc_pin3_i;
  wire jc_pin3_io;
  wire jc_pin3_o;
  wire jc_pin3_t;
  wire jc_pin4_i;
  wire jc_pin4_io;
  wire jc_pin4_o;
  wire jc_pin4_t;
  wire jc_pin7_i;
  wire jc_pin7_io;
  wire jc_pin7_o;
  wire jc_pin7_t;
  wire jc_pin8_i;
  wire jc_pin8_io;
  wire jc_pin8_o;
  wire jc_pin8_t;
  wire jc_pin9_i;
  wire jc_pin9_io;
  wire jc_pin9_o;
  wire jc_pin9_t;
  wire [0:0]led_16bits_tri_i_0;
  wire [1:1]led_16bits_tri_i_1;
  wire [10:10]led_16bits_tri_i_10;
  wire [11:11]led_16bits_tri_i_11;
  wire [12:12]led_16bits_tri_i_12;
  wire [13:13]led_16bits_tri_i_13;
  wire [14:14]led_16bits_tri_i_14;
  wire [15:15]led_16bits_tri_i_15;
  wire [2:2]led_16bits_tri_i_2;
  wire [3:3]led_16bits_tri_i_3;
  wire [4:4]led_16bits_tri_i_4;
  wire [5:5]led_16bits_tri_i_5;
  wire [6:6]led_16bits_tri_i_6;
  wire [7:7]led_16bits_tri_i_7;
  wire [8:8]led_16bits_tri_i_8;
  wire [9:9]led_16bits_tri_i_9;
  wire [0:0]led_16bits_tri_io_0;
  wire [1:1]led_16bits_tri_io_1;
  wire [10:10]led_16bits_tri_io_10;
  wire [11:11]led_16bits_tri_io_11;
  wire [12:12]led_16bits_tri_io_12;
  wire [13:13]led_16bits_tri_io_13;
  wire [14:14]led_16bits_tri_io_14;
  wire [15:15]led_16bits_tri_io_15;
  wire [2:2]led_16bits_tri_io_2;
  wire [3:3]led_16bits_tri_io_3;
  wire [4:4]led_16bits_tri_io_4;
  wire [5:5]led_16bits_tri_io_5;
  wire [6:6]led_16bits_tri_io_6;
  wire [7:7]led_16bits_tri_io_7;
  wire [8:8]led_16bits_tri_io_8;
  wire [9:9]led_16bits_tri_io_9;
  wire [0:0]led_16bits_tri_o_0;
  wire [1:1]led_16bits_tri_o_1;
  wire [10:10]led_16bits_tri_o_10;
  wire [11:11]led_16bits_tri_o_11;
  wire [12:12]led_16bits_tri_o_12;
  wire [13:13]led_16bits_tri_o_13;
  wire [14:14]led_16bits_tri_o_14;
  wire [15:15]led_16bits_tri_o_15;
  wire [2:2]led_16bits_tri_o_2;
  wire [3:3]led_16bits_tri_o_3;
  wire [4:4]led_16bits_tri_o_4;
  wire [5:5]led_16bits_tri_o_5;
  wire [6:6]led_16bits_tri_o_6;
  wire [7:7]led_16bits_tri_o_7;
  wire [8:8]led_16bits_tri_o_8;
  wire [9:9]led_16bits_tri_o_9;
  wire [0:0]led_16bits_tri_t_0;
  wire [1:1]led_16bits_tri_t_1;
  wire [10:10]led_16bits_tri_t_10;
  wire [11:11]led_16bits_tri_t_11;
  wire [12:12]led_16bits_tri_t_12;
  wire [13:13]led_16bits_tri_t_13;
  wire [14:14]led_16bits_tri_t_14;
  wire [15:15]led_16bits_tri_t_15;
  wire [2:2]led_16bits_tri_t_2;
  wire [3:3]led_16bits_tri_t_3;
  wire [4:4]led_16bits_tri_t_4;
  wire [5:5]led_16bits_tri_t_5;
  wire [6:6]led_16bits_tri_t_6;
  wire [7:7]led_16bits_tri_t_7;
  wire [8:8]led_16bits_tri_t_8;
  wire [9:9]led_16bits_tri_t_9;
  wire [4:0]push_buttons_5bits_tri_i;
  wire reset;
  wire sys_clock;
  wire sys_rst;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  design_1 design_1_i
       (.ddr2_sdram_addr(ddr2_sdram_addr),
        .ddr2_sdram_ba(ddr2_sdram_ba),
        .ddr2_sdram_cas_n(ddr2_sdram_cas_n),
        .ddr2_sdram_ck_n(ddr2_sdram_ck_n),
        .ddr2_sdram_ck_p(ddr2_sdram_ck_p),
        .ddr2_sdram_cke(ddr2_sdram_cke),
        .ddr2_sdram_cs_n(ddr2_sdram_cs_n),
        .ddr2_sdram_dm(ddr2_sdram_dm),
        .ddr2_sdram_dq(ddr2_sdram_dq),
        .ddr2_sdram_dqs_n(ddr2_sdram_dqs_n),
        .ddr2_sdram_dqs_p(ddr2_sdram_dqs_p),
        .ddr2_sdram_odt(ddr2_sdram_odt),
        .ddr2_sdram_ras_n(ddr2_sdram_ras_n),
        .ddr2_sdram_we_n(ddr2_sdram_we_n),
        .dip_switches_16bits_tri_i(dip_switches_16bits_tri_i),
        .ja_pin10_i(ja_pin10_i),
        .ja_pin10_o(ja_pin10_o),
        .ja_pin10_t(ja_pin10_t),
        .ja_pin1_i(ja_pin1_i),
        .ja_pin1_o(ja_pin1_o),
        .ja_pin1_t(ja_pin1_t),
        .ja_pin2_i(ja_pin2_i),
        .ja_pin2_o(ja_pin2_o),
        .ja_pin2_t(ja_pin2_t),
        .ja_pin3_i(ja_pin3_i),
        .ja_pin3_o(ja_pin3_o),
        .ja_pin3_t(ja_pin3_t),
        .ja_pin4_i(ja_pin4_i),
        .ja_pin4_o(ja_pin4_o),
        .ja_pin4_t(ja_pin4_t),
        .ja_pin7_i(ja_pin7_i),
        .ja_pin7_o(ja_pin7_o),
        .ja_pin7_t(ja_pin7_t),
        .ja_pin8_i(ja_pin8_i),
        .ja_pin8_o(ja_pin8_o),
        .ja_pin8_t(ja_pin8_t),
        .ja_pin9_i(ja_pin9_i),
        .ja_pin9_o(ja_pin9_o),
        .ja_pin9_t(ja_pin9_t),
        .jb_pin10_i(jb_pin10_i),
        .jb_pin10_o(jb_pin10_o),
        .jb_pin10_t(jb_pin10_t),
        .jb_pin1_i(jb_pin1_i),
        .jb_pin1_o(jb_pin1_o),
        .jb_pin1_t(jb_pin1_t),
        .jb_pin2_i(jb_pin2_i),
        .jb_pin2_o(jb_pin2_o),
        .jb_pin2_t(jb_pin2_t),
        .jb_pin3_i(jb_pin3_i),
        .jb_pin3_o(jb_pin3_o),
        .jb_pin3_t(jb_pin3_t),
        .jb_pin4_i(jb_pin4_i),
        .jb_pin4_o(jb_pin4_o),
        .jb_pin4_t(jb_pin4_t),
        .jb_pin7_i(jb_pin7_i),
        .jb_pin7_o(jb_pin7_o),
        .jb_pin7_t(jb_pin7_t),
        .jb_pin8_i(jb_pin8_i),
        .jb_pin8_o(jb_pin8_o),
        .jb_pin8_t(jb_pin8_t),
        .jb_pin9_i(jb_pin9_i),
        .jb_pin9_o(jb_pin9_o),
        .jb_pin9_t(jb_pin9_t),
        .jc_pin10_i(jc_pin10_i),
        .jc_pin10_o(jc_pin10_o),
        .jc_pin10_t(jc_pin10_t),
        .jc_pin1_i(jc_pin1_i),
        .jc_pin1_o(jc_pin1_o),
        .jc_pin1_t(jc_pin1_t),
        .jc_pin2_i(jc_pin2_i),
        .jc_pin2_o(jc_pin2_o),
        .jc_pin2_t(jc_pin2_t),
        .jc_pin3_i(jc_pin3_i),
        .jc_pin3_o(jc_pin3_o),
        .jc_pin3_t(jc_pin3_t),
        .jc_pin4_i(jc_pin4_i),
        .jc_pin4_o(jc_pin4_o),
        .jc_pin4_t(jc_pin4_t),
        .jc_pin7_i(jc_pin7_i),
        .jc_pin7_o(jc_pin7_o),
        .jc_pin7_t(jc_pin7_t),
        .jc_pin8_i(jc_pin8_i),
        .jc_pin8_o(jc_pin8_o),
        .jc_pin8_t(jc_pin8_t),
        .jc_pin9_i(jc_pin9_i),
        .jc_pin9_o(jc_pin9_o),
        .jc_pin9_t(jc_pin9_t),
        .led_16bits_tri_i({led_16bits_tri_i_15,led_16bits_tri_i_14,led_16bits_tri_i_13,led_16bits_tri_i_12,led_16bits_tri_i_11,led_16bits_tri_i_10,led_16bits_tri_i_9,led_16bits_tri_i_8,led_16bits_tri_i_7,led_16bits_tri_i_6,led_16bits_tri_i_5,led_16bits_tri_i_4,led_16bits_tri_i_3,led_16bits_tri_i_2,led_16bits_tri_i_1,led_16bits_tri_i_0}),
        .led_16bits_tri_o({led_16bits_tri_o_15,led_16bits_tri_o_14,led_16bits_tri_o_13,led_16bits_tri_o_12,led_16bits_tri_o_11,led_16bits_tri_o_10,led_16bits_tri_o_9,led_16bits_tri_o_8,led_16bits_tri_o_7,led_16bits_tri_o_6,led_16bits_tri_o_5,led_16bits_tri_o_4,led_16bits_tri_o_3,led_16bits_tri_o_2,led_16bits_tri_o_1,led_16bits_tri_o_0}),
        .led_16bits_tri_t({led_16bits_tri_t_15,led_16bits_tri_t_14,led_16bits_tri_t_13,led_16bits_tri_t_12,led_16bits_tri_t_11,led_16bits_tri_t_10,led_16bits_tri_t_9,led_16bits_tri_t_8,led_16bits_tri_t_7,led_16bits_tri_t_6,led_16bits_tri_t_5,led_16bits_tri_t_4,led_16bits_tri_t_3,led_16bits_tri_t_2,led_16bits_tri_t_1,led_16bits_tri_t_0}),
        .push_buttons_5bits_tri_i(push_buttons_5bits_tri_i),
        .reset(reset),
        .sys_clock(sys_clock),
        .sys_rst(sys_rst),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
  IOBUF ja_pin10_iobuf
       (.I(ja_pin10_o),
        .IO(ja_pin10_io),
        .O(ja_pin10_i),
        .T(ja_pin10_t));
  IOBUF ja_pin1_iobuf
       (.I(ja_pin1_o),
        .IO(ja_pin1_io),
        .O(ja_pin1_i),
        .T(ja_pin1_t));
  IOBUF ja_pin2_iobuf
       (.I(ja_pin2_o),
        .IO(ja_pin2_io),
        .O(ja_pin2_i),
        .T(ja_pin2_t));
  IOBUF ja_pin3_iobuf
       (.I(ja_pin3_o),
        .IO(ja_pin3_io),
        .O(ja_pin3_i),
        .T(ja_pin3_t));
  IOBUF ja_pin4_iobuf
       (.I(ja_pin4_o),
        .IO(ja_pin4_io),
        .O(ja_pin4_i),
        .T(ja_pin4_t));
  IOBUF ja_pin7_iobuf
       (.I(ja_pin7_o),
        .IO(ja_pin7_io),
        .O(ja_pin7_i),
        .T(ja_pin7_t));
  IOBUF ja_pin8_iobuf
       (.I(ja_pin8_o),
        .IO(ja_pin8_io),
        .O(ja_pin8_i),
        .T(ja_pin8_t));
  IOBUF ja_pin9_iobuf
       (.I(ja_pin9_o),
        .IO(ja_pin9_io),
        .O(ja_pin9_i),
        .T(ja_pin9_t));
  IOBUF jb_pin10_iobuf
       (.I(jb_pin10_o),
        .IO(jb_pin10_io),
        .O(jb_pin10_i),
        .T(jb_pin10_t));
  IOBUF jb_pin1_iobuf
       (.I(jb_pin1_o),
        .IO(jb_pin1_io),
        .O(jb_pin1_i),
        .T(jb_pin1_t));
  IOBUF jb_pin2_iobuf
       (.I(jb_pin2_o),
        .IO(jb_pin2_io),
        .O(jb_pin2_i),
        .T(jb_pin2_t));
  IOBUF jb_pin3_iobuf
       (.I(jb_pin3_o),
        .IO(jb_pin3_io),
        .O(jb_pin3_i),
        .T(jb_pin3_t));
  IOBUF jb_pin4_iobuf
       (.I(jb_pin4_o),
        .IO(jb_pin4_io),
        .O(jb_pin4_i),
        .T(jb_pin4_t));
  IOBUF jb_pin7_iobuf
       (.I(jb_pin7_o),
        .IO(jb_pin7_io),
        .O(jb_pin7_i),
        .T(jb_pin7_t));
  IOBUF jb_pin8_iobuf
       (.I(jb_pin8_o),
        .IO(jb_pin8_io),
        .O(jb_pin8_i),
        .T(jb_pin8_t));
  IOBUF jb_pin9_iobuf
       (.I(jb_pin9_o),
        .IO(jb_pin9_io),
        .O(jb_pin9_i),
        .T(jb_pin9_t));
  IOBUF jc_pin10_iobuf
       (.I(jc_pin10_o),
        .IO(jc_pin10_io),
        .O(jc_pin10_i),
        .T(jc_pin10_t));
  IOBUF jc_pin1_iobuf
       (.I(jc_pin1_o),
        .IO(jc_pin1_io),
        .O(jc_pin1_i),
        .T(jc_pin1_t));
  IOBUF jc_pin2_iobuf
       (.I(jc_pin2_o),
        .IO(jc_pin2_io),
        .O(jc_pin2_i),
        .T(jc_pin2_t));
  IOBUF jc_pin3_iobuf
       (.I(jc_pin3_o),
        .IO(jc_pin3_io),
        .O(jc_pin3_i),
        .T(jc_pin3_t));
  IOBUF jc_pin4_iobuf
       (.I(jc_pin4_o),
        .IO(jc_pin4_io),
        .O(jc_pin4_i),
        .T(jc_pin4_t));
  IOBUF jc_pin7_iobuf
       (.I(jc_pin7_o),
        .IO(jc_pin7_io),
        .O(jc_pin7_i),
        .T(jc_pin7_t));
  IOBUF jc_pin8_iobuf
       (.I(jc_pin8_o),
        .IO(jc_pin8_io),
        .O(jc_pin8_i),
        .T(jc_pin8_t));
  IOBUF jc_pin9_iobuf
       (.I(jc_pin9_o),
        .IO(jc_pin9_io),
        .O(jc_pin9_i),
        .T(jc_pin9_t));
  IOBUF led_16bits_tri_iobuf_0
       (.I(led_16bits_tri_o_0),
        .IO(led_16bits_tri_io[0]),
        .O(led_16bits_tri_i_0),
        .T(led_16bits_tri_t_0));
  IOBUF led_16bits_tri_iobuf_1
       (.I(led_16bits_tri_o_1),
        .IO(led_16bits_tri_io[1]),
        .O(led_16bits_tri_i_1),
        .T(led_16bits_tri_t_1));
  IOBUF led_16bits_tri_iobuf_10
       (.I(led_16bits_tri_o_10),
        .IO(led_16bits_tri_io[10]),
        .O(led_16bits_tri_i_10),
        .T(led_16bits_tri_t_10));
  IOBUF led_16bits_tri_iobuf_11
       (.I(led_16bits_tri_o_11),
        .IO(led_16bits_tri_io[11]),
        .O(led_16bits_tri_i_11),
        .T(led_16bits_tri_t_11));
  IOBUF led_16bits_tri_iobuf_12
       (.I(led_16bits_tri_o_12),
        .IO(led_16bits_tri_io[12]),
        .O(led_16bits_tri_i_12),
        .T(led_16bits_tri_t_12));
  IOBUF led_16bits_tri_iobuf_13
       (.I(led_16bits_tri_o_13),
        .IO(led_16bits_tri_io[13]),
        .O(led_16bits_tri_i_13),
        .T(led_16bits_tri_t_13));
  IOBUF led_16bits_tri_iobuf_14
       (.I(led_16bits_tri_o_14),
        .IO(led_16bits_tri_io[14]),
        .O(led_16bits_tri_i_14),
        .T(led_16bits_tri_t_14));
  IOBUF led_16bits_tri_iobuf_15
       (.I(led_16bits_tri_o_15),
        .IO(led_16bits_tri_io[15]),
        .O(led_16bits_tri_i_15),
        .T(led_16bits_tri_t_15));
  IOBUF led_16bits_tri_iobuf_2
       (.I(led_16bits_tri_o_2),
        .IO(led_16bits_tri_io[2]),
        .O(led_16bits_tri_i_2),
        .T(led_16bits_tri_t_2));
  IOBUF led_16bits_tri_iobuf_3
       (.I(led_16bits_tri_o_3),
        .IO(led_16bits_tri_io[3]),
        .O(led_16bits_tri_i_3),
        .T(led_16bits_tri_t_3));
  IOBUF led_16bits_tri_iobuf_4
       (.I(led_16bits_tri_o_4),
        .IO(led_16bits_tri_io[4]),
        .O(led_16bits_tri_i_4),
        .T(led_16bits_tri_t_4));
  IOBUF led_16bits_tri_iobuf_5
       (.I(led_16bits_tri_o_5),
        .IO(led_16bits_tri_io[5]),
        .O(led_16bits_tri_i_5),
        .T(led_16bits_tri_t_5));
  IOBUF led_16bits_tri_iobuf_6
       (.I(led_16bits_tri_o_6),
        .IO(led_16bits_tri_io[6]),
        .O(led_16bits_tri_i_6),
        .T(led_16bits_tri_t_6));
  IOBUF led_16bits_tri_iobuf_7
       (.I(led_16bits_tri_o_7),
        .IO(led_16bits_tri_io[7]),
        .O(led_16bits_tri_i_7),
        .T(led_16bits_tri_t_7));
  IOBUF led_16bits_tri_iobuf_8
       (.I(led_16bits_tri_o_8),
        .IO(led_16bits_tri_io[8]),
        .O(led_16bits_tri_i_8),
        .T(led_16bits_tri_t_8));
  IOBUF led_16bits_tri_iobuf_9
       (.I(led_16bits_tri_o_9),
        .IO(led_16bits_tri_io[9]),
        .O(led_16bits_tri_i_9),
        .T(led_16bits_tri_t_9));
endmodule
