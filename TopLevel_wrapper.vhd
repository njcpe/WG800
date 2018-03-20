--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
--Date        : Mon Mar 19 16:44:11 2018
--Host        : DESKTOP-AGJA64N running 64-bit major release  (build 9200)
--Command     : generate_target TopLevel_wrapper.bd
--Design      : TopLevel_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity TopLevel_wrapper is
  port (
    AUX_A : out STD_LOGIC;
    AUX_B : out STD_LOGIC;
    BAT_LOW_N : in STD_LOGIC;
    CH1_DAC_CS : out STD_LOGIC;
    CH1_DAC_DAT : out STD_LOGIC;
    CH1_DAC_SCLK : out STD_LOGIC;
    CH2_DAC_CS : out STD_LOGIC;
    CH2_DAC_DAT : out STD_LOGIC;
    CH2_DAT_SCLK : out STD_LOGIC;
    CH3_DAC_CS : out STD_LOGIC;
    CH3_DAC_DAT : out STD_LOGIC;
    CH3_DAC_SCLK : out STD_LOGIC;
    CH4_DAC_CS : out STD_LOGIC;
    CH4_DAC_DAT : out STD_LOGIC;
    CH4_DAC_SCLK : out STD_LOGIC;
    CH5_DAC_CS : out STD_LOGIC;
    CH5_DAC_DAT : out STD_LOGIC;
    CH5_DAC_SCLK : out STD_LOGIC;
    CH6_DAC_CS : out STD_LOGIC;
    CH6_DAC_DAT : out STD_LOGIC;
    CH6_DAC_SCLK : out STD_LOGIC;
    CH7_DAC_CS : out STD_LOGIC;
    CH7_DAC_DAT : out STD_LOGIC;
    CH7_DAT_SCLK : out STD_LOGIC;
    CH8_DAC_CS : out STD_LOGIC;
    CH8_DAC_DAT : out STD_LOGIC;
    CH8_DAC_SCLK : out STD_LOGIC;
    CS2515 : out STD_LOGIC;
    DC_IN_OK_N : in STD_LOGIC;
    DIGITAL_OUTPUT_BUS : out STD_LOGIC_VECTOR ( 10 downto 0 );
    DISP_DB : out STD_LOGIC_VECTOR ( 7 downto 0 );
    DISP_E : out STD_LOGIC_VECTOR ( 0 to 0 );
    DISP_RS : out STD_LOGIC_VECTOR ( 0 to 0 );
    DISP_RW : out STD_LOGIC_VECTOR ( 0 to 0 );
    FPGA_LED_N : out STD_LOGIC;
    Flash_Mem_io0_io : inout STD_LOGIC;
    Flash_Mem_io1_io : inout STD_LOGIC;
    Flash_Mem_sck_io : inout STD_LOGIC;
    Flash_Mem_ss_io : inout STD_LOGIC_VECTOR ( 0 to 0 );
    INHIB_12V : out STD_LOGIC;
    MB_RESET_IN : in STD_LOGIC;
    OSC2515 : out STD_LOGIC;
    PWRHOLD : out STD_LOGIC;
    REF_EN_N : out STD_LOGIC;
    RST2515 : out STD_LOGIC;
    SCK2515 : out STD_LOGIC;
    SI2515 : out STD_LOGIC;
    SO2515 : in STD_LOGIC;
    SWITCH_1 : in STD_LOGIC;
    SWITCH_2 : in STD_LOGIC;
    SWITCH_3 : in STD_LOGIC;
    SWITCH_4 : in STD_LOGIC;
    SWITCH_5 : in STD_LOGIC;
    SWITCH_6 : in STD_LOGIC;
    SW_ON : in STD_LOGIC;
    USB_UART_RXD : out STD_LOGIC;
    USB_UART_TXD : in STD_LOGIC;
    sys_clock : in STD_LOGIC
  );
end TopLevel_wrapper;

architecture STRUCTURE of TopLevel_wrapper is
  component TopLevel is
  port (
    AUX_A : out STD_LOGIC;
    AUX_B : out STD_LOGIC;
    CS2515 : out STD_LOGIC;
    DIGITAL_OUTPUT_BUS : out STD_LOGIC_VECTOR ( 10 downto 0 );
    OSC2515 : out STD_LOGIC;
    RST2515 : out STD_LOGIC;
    SCK2515 : out STD_LOGIC;
    SI2515 : out STD_LOGIC;
    SO2515 : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    MB_RESET_IN : in STD_LOGIC;
    USB_UART_TXD : in STD_LOGIC;
    USB_UART_RXD : out STD_LOGIC;
    SWITCH_1 : in STD_LOGIC;
    SWITCH_2 : in STD_LOGIC;
    SWITCH_3 : in STD_LOGIC;
    SWITCH_4 : in STD_LOGIC;
    SWITCH_5 : in STD_LOGIC;
    SWITCH_6 : in STD_LOGIC;
    DISP_DB : out STD_LOGIC_VECTOR ( 7 downto 0 );
    DISP_RW : out STD_LOGIC_VECTOR ( 0 to 0 );
    DISP_E : out STD_LOGIC_VECTOR ( 0 to 0 );
    DISP_RS : out STD_LOGIC_VECTOR ( 0 to 0 );
    BAT_LOW_N : in STD_LOGIC;
    DC_IN_OK_N : in STD_LOGIC;
    SW_ON : in STD_LOGIC;
    FPGA_LED_N : out STD_LOGIC;
    INHIB_12V : out STD_LOGIC;
    PWRHOLD : out STD_LOGIC;
    REF_EN_N : out STD_LOGIC;
    CH8_DAC_DAT : out STD_LOGIC;
    CH7_DAC_DAT : out STD_LOGIC;
    CH3_DAC_DAT : out STD_LOGIC;
    CH2_DAC_DAT : out STD_LOGIC;
    CH6_DAC_DAT : out STD_LOGIC;
    CH5_DAC_DAT : out STD_LOGIC;
    CH4_DAC_DAT : out STD_LOGIC;
    CH1_DAC_DAT : out STD_LOGIC;
    CH1_DAC_CS : out STD_LOGIC;
    CH2_DAC_CS : out STD_LOGIC;
    CH3_DAC_CS : out STD_LOGIC;
    CH4_DAC_CS : out STD_LOGIC;
    CH5_DAC_CS : out STD_LOGIC;
    CH6_DAC_CS : out STD_LOGIC;
    CH7_DAC_CS : out STD_LOGIC;
    CH8_DAC_CS : out STD_LOGIC;
    CH1_DAC_SCLK : out STD_LOGIC;
    CH2_DAT_SCLK : out STD_LOGIC;
    CH3_DAC_SCLK : out STD_LOGIC;
    CH4_DAC_SCLK : out STD_LOGIC;
    CH5_DAC_SCLK : out STD_LOGIC;
    CH6_DAC_SCLK : out STD_LOGIC;
    CH7_DAT_SCLK : out STD_LOGIC;
    CH8_DAC_SCLK : out STD_LOGIC;
    Flash_Mem_io0_i : in STD_LOGIC;
    Flash_Mem_io0_o : out STD_LOGIC;
    Flash_Mem_io0_t : out STD_LOGIC;
    Flash_Mem_io1_i : in STD_LOGIC;
    Flash_Mem_io1_o : out STD_LOGIC;
    Flash_Mem_io1_t : out STD_LOGIC;
    Flash_Mem_sck_i : in STD_LOGIC;
    Flash_Mem_sck_o : out STD_LOGIC;
    Flash_Mem_sck_t : out STD_LOGIC;
    Flash_Mem_ss_i : in STD_LOGIC_VECTOR ( 0 to 0 );
    Flash_Mem_ss_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    Flash_Mem_ss_t : out STD_LOGIC
  );
  end component TopLevel;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal Flash_Mem_io0_i : STD_LOGIC;
  signal Flash_Mem_io0_o : STD_LOGIC;
  signal Flash_Mem_io0_t : STD_LOGIC;
  signal Flash_Mem_io1_i : STD_LOGIC;
  signal Flash_Mem_io1_o : STD_LOGIC;
  signal Flash_Mem_io1_t : STD_LOGIC;
  signal Flash_Mem_sck_i : STD_LOGIC;
  signal Flash_Mem_sck_o : STD_LOGIC;
  signal Flash_Mem_sck_t : STD_LOGIC;
  signal Flash_Mem_ss_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal Flash_Mem_ss_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal Flash_Mem_ss_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal Flash_Mem_ss_t : STD_LOGIC;
begin
Flash_Mem_io0_iobuf: component IOBUF
     port map (
      I => Flash_Mem_io0_o,
      IO => Flash_Mem_io0_io,
      O => Flash_Mem_io0_i,
      T => Flash_Mem_io0_t
    );
Flash_Mem_io1_iobuf: component IOBUF
     port map (
      I => Flash_Mem_io1_o,
      IO => Flash_Mem_io1_io,
      O => Flash_Mem_io1_i,
      T => Flash_Mem_io1_t
    );
Flash_Mem_sck_iobuf: component IOBUF
     port map (
      I => Flash_Mem_sck_o,
      IO => Flash_Mem_sck_io,
      O => Flash_Mem_sck_i,
      T => Flash_Mem_sck_t
    );
Flash_Mem_ss_iobuf_0: component IOBUF
     port map (
      I => Flash_Mem_ss_o_0(0),
      IO => Flash_Mem_ss_io(0),
      O => Flash_Mem_ss_i_0(0),
      T => Flash_Mem_ss_t
    );
TopLevel_i: component TopLevel
     port map (
      AUX_A => AUX_A,
      AUX_B => AUX_B,
      BAT_LOW_N => BAT_LOW_N,
      CH1_DAC_CS => CH1_DAC_CS,
      CH1_DAC_DAT => CH1_DAC_DAT,
      CH1_DAC_SCLK => CH1_DAC_SCLK,
      CH2_DAC_CS => CH2_DAC_CS,
      CH2_DAC_DAT => CH2_DAC_DAT,
      CH2_DAT_SCLK => CH2_DAT_SCLK,
      CH3_DAC_CS => CH3_DAC_CS,
      CH3_DAC_DAT => CH3_DAC_DAT,
      CH3_DAC_SCLK => CH3_DAC_SCLK,
      CH4_DAC_CS => CH4_DAC_CS,
      CH4_DAC_DAT => CH4_DAC_DAT,
      CH4_DAC_SCLK => CH4_DAC_SCLK,
      CH5_DAC_CS => CH5_DAC_CS,
      CH5_DAC_DAT => CH5_DAC_DAT,
      CH5_DAC_SCLK => CH5_DAC_SCLK,
      CH6_DAC_CS => CH6_DAC_CS,
      CH6_DAC_DAT => CH6_DAC_DAT,
      CH6_DAC_SCLK => CH6_DAC_SCLK,
      CH7_DAC_CS => CH7_DAC_CS,
      CH7_DAC_DAT => CH7_DAC_DAT,
      CH7_DAT_SCLK => CH7_DAT_SCLK,
      CH8_DAC_CS => CH8_DAC_CS,
      CH8_DAC_DAT => CH8_DAC_DAT,
      CH8_DAC_SCLK => CH8_DAC_SCLK,
      CS2515 => CS2515,
      DC_IN_OK_N => DC_IN_OK_N,
      DIGITAL_OUTPUT_BUS(10 downto 0) => DIGITAL_OUTPUT_BUS(10 downto 0),
      DISP_DB(7 downto 0) => DISP_DB(7 downto 0),
      DISP_E(0) => DISP_E(0),
      DISP_RS(0) => DISP_RS(0),
      DISP_RW(0) => DISP_RW(0),
      FPGA_LED_N => FPGA_LED_N,
      Flash_Mem_io0_i => Flash_Mem_io0_i,
      Flash_Mem_io0_o => Flash_Mem_io0_o,
      Flash_Mem_io0_t => Flash_Mem_io0_t,
      Flash_Mem_io1_i => Flash_Mem_io1_i,
      Flash_Mem_io1_o => Flash_Mem_io1_o,
      Flash_Mem_io1_t => Flash_Mem_io1_t,
      Flash_Mem_sck_i => Flash_Mem_sck_i,
      Flash_Mem_sck_o => Flash_Mem_sck_o,
      Flash_Mem_sck_t => Flash_Mem_sck_t,
      Flash_Mem_ss_i(0) => Flash_Mem_ss_i_0(0),
      Flash_Mem_ss_o(0) => Flash_Mem_ss_o_0(0),
      Flash_Mem_ss_t => Flash_Mem_ss_t,
      INHIB_12V => INHIB_12V,
      MB_RESET_IN => MB_RESET_IN,
      OSC2515 => OSC2515,
      PWRHOLD => PWRHOLD,
      REF_EN_N => REF_EN_N,
      RST2515 => RST2515,
      SCK2515 => SCK2515,
      SI2515 => SI2515,
      SO2515 => SO2515,
      SWITCH_1 => SWITCH_1,
      SWITCH_2 => SWITCH_2,
      SWITCH_3 => SWITCH_3,
      SWITCH_4 => SWITCH_4,
      SWITCH_5 => SWITCH_5,
      SWITCH_6 => SWITCH_6,
      SW_ON => SW_ON,
      USB_UART_RXD => USB_UART_RXD,
      USB_UART_TXD => USB_UART_TXD,
      sys_clock => sys_clock
    );
end STRUCTURE;
