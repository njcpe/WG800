----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02/06/2018 06:08:41 PM
-- Design Name:
-- Module Name: DAC_PREP_PROC - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity DAC_PREP_PROC is
	port
	(
		S_AXI_ACLK          : in std_logic;
		M_RESYNC            : in std_logic;
		
		ARB_0               : in std_logic_vector (11 downto 0);
		ARB_1               : in std_logic_vector (11 downto 0);
		ARB_2               : in std_logic_vector (11 downto 0);
		ARB_3               : in std_logic_vector (11 downto 0);
		ARB_4               : in std_logic_vector (11 downto 0);
		ARB_5               : in std_logic_vector (11 downto 0);
		ARB_6               : in std_logic_vector (11 downto 0);
		ARB_7               : in std_logic_vector (11 downto 0);
		
		PWM_0               : in std_logic_vector (11 downto 0);
		PWM_1               : in std_logic_vector (11 downto 0);
		PWM_2               : in std_logic_vector (11 downto 0);
		PWM_3               : in std_logic_vector (11 downto 0);
		PWM_4               : in std_logic_vector (11 downto 0);
		PWM_5               : in std_logic_vector (11 downto 0);
		PWM_6               : in std_logic_vector (11 downto 0);
		PWM_7               : in std_logic_vector (11 downto 0);
		
		DDS_TDATA						: in std_logic_vector (15 downto 0);
		DDS_TVALID					: in std_logic;
		DDS_TUSER						: in std_logic_vector (2 downto 0);
		
		GAIN_VECTOR_IN      : in std_logic_vector (95 downto 0);
		OFFSET_VECTOR_IN    : in std_logic_vector (95 downto 0);
		CHAN_MODE_VECTOR_IN : in std_logic_vector (31 downto 0);
		
		CH0_EN              : out std_logic;
		CH0_DOUT            : out std_logic_vector (11 downto 0);
		CH1_EN              : out std_logic;
		CH1_DOUT            : out std_logic_vector (11 downto 0);
		CH2_EN              : out std_logic;
		CH2_DOUT            : out std_logic_vector (11 downto 0);
		CH3_EN              : out std_logic;
		CH3_DOUT            : out std_logic_vector (11 downto 0);
		CH4_EN              : out std_logic;
		CH4_DOUT            : out std_logic_vector (11 downto 0);
		CH5_EN              : out std_logic;
		CH5_DOUT            : out std_logic_vector (11 downto 0);
		CH6_EN              : out std_logic;
		CH6_DOUT            : out std_logic_vector (11 downto 0);
		CH7_EN              : out std_logic;
		CH7_DOUT            : out std_logic_vector (11 downto 0)
	);
end DAC_PREP_PROC;

architecture Behavioral of DAC_PREP_PROC is
	signal PWM_in_0       : std_logic_vector(11 downto 0) := x"000";
	signal PWM_in_1       : std_logic_vector(11 downto 0) := x"000";
	signal PWM_in_2       : std_logic_vector(11 downto 0) := x"000";
	signal PWM_in_3       : std_logic_vector(11 downto 0) := x"000";
	signal PWM_in_4       : std_logic_vector(11 downto 0) := x"000";
	signal PWM_in_5       : std_logic_vector(11 downto 0) := x"000";
	signal PWM_in_6       : std_logic_vector(11 downto 0) := x"000";
	signal PWM_in_7       : std_logic_vector(11 downto 0) := x"000";
	signal ARB_in_0       : std_logic_vector(11 downto 0) := x"000";
	signal ARB_in_1       : std_logic_vector(11 downto 0) := x"000";
	signal ARB_in_2       : std_logic_vector(11 downto 0) := x"000";
	signal ARB_in_3       : std_logic_vector(11 downto 0) := x"000";
	signal ARB_in_4       : std_logic_vector(11 downto 0) := x"000";
	signal ARB_in_5       : std_logic_vector(11 downto 0) := x"000";
	signal ARB_in_6       : std_logic_vector(11 downto 0) := x"000";
	signal ARB_in_7       : std_logic_vector(11 downto 0) := x"000";
	
	signal DDS_new_data_in 			: std_logic_vector(11 downto 0) := x"000";
	signal DDS_new_data_valid 	: std_logic := '0';
	signal DDS_active_channel 	: std_logic_vector(2 downto 0) := "000";
	
	signal DDS_channel_0 : std_logic_vector(11 downto 0) := x"000";
	signal DDS_channel_1 : std_logic_vector(11 downto 0) := x"000";
	signal DDS_channel_2 : std_logic_vector(11 downto 0) := x"000";
	signal DDS_channel_3 : std_logic_vector(11 downto 0) := x"000";
	signal DDS_channel_4 : std_logic_vector(11 downto 0) := x"000";
	signal DDS_channel_5 : std_logic_vector(11 downto 0) := x"000";
	signal DDS_channel_6 : std_logic_vector(11 downto 0) := x"000";
	signal DDS_channel_7 : std_logic_vector(11 downto 0) := x"000";
	
	signal channel_states : std_logic_vector(31 downto 0) := x"00000000";
	signal gain_values    : std_logic_vector(95 downto 0) := x"000000000000000000000000";
	signal offset_values  : std_logic_vector(95 downto 0) := x"000000000000000000000000";
begin

	PWM_in_0       <= PWM_0;
	PWM_in_1       <= PWM_1;
	PWM_in_2       <= PWM_2;
	PWM_in_3       <= PWM_3;
	PWM_in_4       <= PWM_4;
	PWM_in_5       <= PWM_5;
	PWM_in_6       <= PWM_6;
	PWM_in_7       <= PWM_7;
	ARB_in_0       <= ARB_0;
	ARB_in_1       <= ARB_1;
	ARB_in_2       <= ARB_2;
	ARB_in_3       <= ARB_3;
	ARB_in_4       <= ARB_4;
	ARB_in_5       <= ARB_5;
	ARB_in_6       <= ARB_6;
	ARB_in_7       <= ARB_7;
	
	DDS_new_data_in 				<= DDS_TDATA(11 downto 0);
	DDS_new_data_valid 			<= DDS_TVALID;
	DDS_active_channel 			<= DDS_TUSER;
	
	channel_states <= CHAN_MODE_VECTOR_IN;
	gain_values    <= GAIN_VECTOR_IN;
	offset_values  <= OFFSET_VECTOR_IN;
	
	DDS_DATA_SEPERATOR : process(S_AXI_ACLK, M_RESYNC)
	begin
		if rising_edge (S_AXI_ACLK) then
			if M_RESYNC = '0' then
				--Resync
				DDS_channel_0 <= (others => '0');
				DDS_channel_1 <= (others => '0');
				DDS_channel_2 <= (others => '0');
				DDS_channel_3 <= (others => '0');
				DDS_channel_4 <= (others => '0');
				DDS_channel_5 <= (others => '0');
				DDS_channel_6 <= (others => '0');
				DDS_channel_7 <= (others => '0');
			else
				case(DDS_active_channel) is
					when "000" =>
						DDS_channel_0 <= DDS_new_data_in;
						DDS_channel_1 <= DDS_channel_1;
						DDS_channel_2 <= DDS_channel_2;
						DDS_channel_3 <= DDS_channel_3;
						DDS_channel_4 <= DDS_channel_4;
						DDS_channel_5 <= DDS_channel_5;
						DDS_channel_6 <= DDS_channel_6;
						DDS_channel_7 <= DDS_channel_7;
					when "001" =>
						DDS_channel_1 <= DDS_new_data_in;
						DDS_channel_0 <= DDS_channel_0;
						DDS_channel_2 <= DDS_channel_2;
						DDS_channel_3 <= DDS_channel_3;
						DDS_channel_4 <= DDS_channel_4;
						DDS_channel_5 <= DDS_channel_5;
						DDS_channel_6 <= DDS_channel_6;
						DDS_channel_7 <= DDS_channel_7;
					when "010" =>
						DDS_channel_2 <= DDS_new_data_in;
						DDS_channel_0 <= DDS_channel_0;
						DDS_channel_1 <= DDS_channel_1;
						DDS_channel_3 <= DDS_channel_3;
						DDS_channel_4 <= DDS_channel_4;
						DDS_channel_5 <= DDS_channel_5;
						DDS_channel_6 <= DDS_channel_6;
						DDS_channel_7 <= DDS_channel_7;
					when "011" =>
						DDS_channel_3 <= DDS_new_data_in;
						DDS_channel_0 <= DDS_channel_0;
						DDS_channel_1 <= DDS_channel_1;
						DDS_channel_2 <= DDS_channel_2;
						DDS_channel_4 <= DDS_channel_4;
						DDS_channel_5 <= DDS_channel_5;
						DDS_channel_6 <= DDS_channel_6;
						DDS_channel_7 <= DDS_channel_7;
					when "100" =>
						DDS_channel_4 <= DDS_new_data_in;
						DDS_channel_0 <= DDS_channel_0;
						DDS_channel_1 <= DDS_channel_1;
						DDS_channel_2 <= DDS_channel_2;
						DDS_channel_3 <= DDS_channel_3;
						DDS_channel_5 <= DDS_channel_5;
						DDS_channel_6 <= DDS_channel_6;
						DDS_channel_7 <= DDS_channel_7;
					when "101" =>
						DDS_channel_5 <= DDS_new_data_in;
						DDS_channel_0 <= DDS_channel_0;
						DDS_channel_1 <= DDS_channel_1;
						DDS_channel_2 <= DDS_channel_2;
						DDS_channel_3 <= DDS_channel_3;
						DDS_channel_4 <= DDS_channel_4;
						DDS_channel_6 <= DDS_channel_6;
						DDS_channel_7 <= DDS_channel_7;
					when "110" =>
						DDS_channel_6 <= DDS_new_data_in;
						DDS_channel_0 <= DDS_channel_0;
						DDS_channel_1 <= DDS_channel_1;
						DDS_channel_2 <= DDS_channel_2;
						DDS_channel_3 <= DDS_channel_3;
						DDS_channel_4 <= DDS_channel_4;
						DDS_channel_5 <= DDS_channel_5;
						DDS_channel_7 <= DDS_channel_7;
					when "111" =>
						DDS_channel_7 <= DDS_new_data_in;
						DDS_channel_0 <= DDS_channel_0;
						DDS_channel_1 <= DDS_channel_1;
						DDS_channel_2 <= DDS_channel_2;
						DDS_channel_3 <= DDS_channel_3;
						DDS_channel_4 <= DDS_channel_4;
						DDS_channel_5 <= DDS_channel_5;
						DDS_channel_6 <= DDS_channel_6;
					when others =>
						DDS_channel_0 <= DDS_channel_0;
						DDS_channel_1 <= DDS_channel_1;
						DDS_channel_2 <= DDS_channel_2;
						DDS_channel_3 <= DDS_channel_3;
						DDS_channel_4 <= DDS_channel_4;
						DDS_channel_5 <= DDS_channel_5;
						DDS_channel_6 <= DDS_channel_6;
						DDS_channel_7 <= DDS_channel_7;
				end case;
			end if;
		end if;
	end process DDS_DATA_SEPERATOR;
	
	DATA_PREP_CH0 : process (S_AXI_ACLK, M_RESYNC)
	begin
		if rising_edge(S_AXI_ACLK) then
			if M_RESYNC = '0' then
				--Resync
				CH0_DOUT <= x"000";
				CH0_EN   <= '0';
				
			else
				case(channel_states(31 downto 28)) is
					when x"0" =>
						CH0_DOUT <= x"000";
						CH0_EN   <= '0';
					when x"1" =>
						CH0_DOUT <= DDS_channel_0;
						CH0_EN   <= '1'; 
					when x"2" =>
						CH0_DOUT <= std_logic_vector(unsigned(PWM_in_0) + x"800");
						CH0_EN   <= '1';
					when x"8" =>
						CH0_DOUT <= std_logic_vector(unsigned(ARB_in_0) + x"800");
						CH0_EN   <= '1';
					when x"9" =>
						CH0_DOUT <= std_logic_vector(unsigned(ARB_in_1) + x"800");
						CH0_EN   <= '1';
					when x"A" =>
						CH0_DOUT <= std_logic_vector(unsigned(ARB_in_2) + x"800");
						CH0_EN   <= '1';
					when x"B" =>
						CH0_DOUT <= std_logic_vector(unsigned(ARB_in_3) + x"800");
						CH0_EN   <= '1';
					when x"C" =>
						CH0_DOUT <= std_logic_vector(unsigned(ARB_in_4) + x"800");
						CH0_EN   <= '1';
					when x"D" =>
						CH0_DOUT <= std_logic_vector(unsigned(ARB_in_5) + x"800");
						CH0_EN   <= '1';
					when x"E" =>
						CH0_DOUT <= std_logic_vector(unsigned(ARB_in_6) + x"800");
						CH0_EN   <= '1';
					when x"F" =>
						CH0_DOUT <= std_logic_vector(unsigned(ARB_in_7) + x"800");
						CH0_EN   <= '1';
					when others =>
						CH0_DOUT <= x"000";
						CH0_EN   <= '0';
				end case;
			end if;
		end if;
	end process DATA_PREP_CH0;
	DATA_PREP_CH1 : process (S_AXI_ACLK, M_RESYNC)
	begin
		if rising_edge(S_AXI_ACLK) then
			if M_RESYNC = '0' then
				--Resync
				CH1_DOUT <= x"000";
				CH1_EN   <= '0';
			else
				case(channel_states(27 downto 24)) is
					when x"0" =>
						CH1_DOUT <= x"000";
						CH1_EN   <= '0';
					when x"1" =>
						CH1_DOUT <= DDS_channel_1;
						CH1_EN   <= '1';
					when x"2" =>
						CH1_DOUT <= std_logic_vector(unsigned(PWM_in_1) + x"800");
						CH1_EN   <= '1';
					when x"8" =>
						CH1_DOUT <= std_logic_vector(unsigned(ARB_in_0) + x"800");
						CH1_EN   <= '1';
					when x"9" =>
						CH1_DOUT <= std_logic_vector(unsigned(ARB_in_1) + x"800");
						CH1_EN   <= '1';
					when x"A" =>
						CH1_DOUT <= std_logic_vector(unsigned(ARB_in_2) + x"800");
						CH1_EN   <= '1';
					when x"B" =>
						CH1_DOUT <= std_logic_vector(unsigned(ARB_in_3) + x"800");
						CH1_EN   <= '1';
					when x"C" =>
						CH1_DOUT <= std_logic_vector(unsigned(ARB_in_4) + x"800");
						CH1_EN   <= '1';
					when x"D" =>
						CH1_DOUT <= std_logic_vector(unsigned(ARB_in_5) + x"800");
						CH1_EN   <= '1';
					when x"E" =>
						CH1_DOUT <= std_logic_vector(unsigned(ARB_in_6) + x"800");
						CH1_EN   <= '1';
					when x"F" =>
						CH1_DOUT <= std_logic_vector(unsigned(ARB_in_7) + x"800");
						CH1_EN   <= '1';
					when others =>
						CH1_DOUT <= x"000";
				end case;
			end if;
		end if;
	end process DATA_PREP_CH1;
	DATA_PREP_CH2 : process (S_AXI_ACLK, M_RESYNC)
	begin
		if rising_edge(S_AXI_ACLK) then
			if M_RESYNC = '0' then
				--Resync
				CH2_DOUT <= x"000";
				CH2_EN   <= '0';
			else
				case(channel_states(23 downto 20)) is
					when x"0" =>
						CH2_DOUT <= x"000";
						CH2_EN   <= '0';
					when x"1" =>
						CH2_DOUT <= DDS_channel_2;
						CH2_EN   <= '1';
					when x"2" =>
						CH2_DOUT <= std_logic_vector(unsigned(PWM_in_2) + x"800");
						CH2_EN   <= '1';
					when x"8" =>
						CH2_DOUT <= std_logic_vector(unsigned(ARB_in_0) + x"800");
						CH2_EN   <= '1';
					when x"9" =>
						CH2_DOUT <= std_logic_vector(unsigned(ARB_in_1) + x"800");
						CH2_EN   <= '1';
					when x"A" =>
						CH2_DOUT <= std_logic_vector(unsigned(ARB_in_2) + x"800");
						CH2_EN   <= '1';
					when x"B" =>
						CH2_DOUT <= std_logic_vector(unsigned(ARB_in_3) + x"800");
						CH2_EN   <= '1';
					when x"C" =>
						CH2_DOUT <= std_logic_vector(unsigned(ARB_in_4) + x"800");
						CH2_EN   <= '1';
					when x"D" =>
						CH2_DOUT <= std_logic_vector(unsigned(ARB_in_5) + x"800");
						CH2_EN   <= '1';
					when x"E" =>
						CH2_DOUT <= std_logic_vector(unsigned(ARB_in_6) + x"800");
						CH2_EN   <= '1';
					when x"F" =>
						CH2_DOUT <= std_logic_vector(unsigned(ARB_in_7) + x"800");
						CH2_EN   <= '1';
					when others =>
						CH2_DOUT <= x"000";
						CH2_EN   <= '0';
				end case;
			end if;
		end if;
	end process DATA_PREP_CH2;
	DATA_PREP_CH3 : process (S_AXI_ACLK, M_RESYNC)
	begin
		if rising_edge(S_AXI_ACLK) then
			if M_RESYNC = '0' then
				--Resync
				CH3_DOUT <= x"000";
				CH3_EN   <= '0';
			else
				case(channel_states(19 downto 16)) is
					when x"0" =>
						CH3_DOUT <= x"000";
						CH3_EN   <= '0';
					when x"1" =>
						CH3_DOUT <= DDS_channel_3;
						CH3_EN   <= '1';
					when x"2" =>
						CH3_DOUT <= std_logic_vector(unsigned(PWM_in_3) + x"800");
						CH3_EN   <= '1';
					when x"8" =>
						CH3_DOUT <= std_logic_vector(unsigned(ARB_in_0) + x"800");
						CH3_EN   <= '1';
					when x"9" =>
						CH3_DOUT <= std_logic_vector(unsigned(ARB_in_1) + x"800");
						CH3_EN   <= '1';
					when x"A" =>
						CH3_DOUT <= std_logic_vector(unsigned(ARB_in_2) + x"800");
						CH3_EN   <= '1';
					when x"B" =>
						CH3_DOUT <= std_logic_vector(unsigned(ARB_in_3) + x"800");
						CH3_EN   <= '1';
					when x"C" =>
						CH3_DOUT <= std_logic_vector(unsigned(ARB_in_4) + x"800");
						CH3_EN   <= '1';
					when x"D" =>
						CH3_DOUT <= std_logic_vector(unsigned(ARB_in_5) + x"800");
						CH3_EN   <= '1';
					when x"E" =>
						CH3_DOUT <= std_logic_vector(unsigned(ARB_in_6) + x"800");
						CH3_EN   <= '1';
					when x"F" =>
						CH3_DOUT <= std_logic_vector(unsigned(ARB_in_7) + x"800");
						CH3_EN   <= '1';
					when others =>
						CH3_DOUT <= x"000";
						CH3_EN   <= '0';
				end case;
			end if;
		end if;
	end process DATA_PREP_CH3;
	DATA_PREP_CH4 : process (S_AXI_ACLK, M_RESYNC)
	begin
		if rising_edge(S_AXI_ACLK) then
			if M_RESYNC = '0' then
				--Resync
				CH4_DOUT <= x"000";
				CH4_EN   <= '0';
			else
				case(channel_states(15 downto 12)) is
					when x"0" =>
						CH4_DOUT <= x"000";
						CH4_EN   <= '0';
					when x"1" =>
						CH4_DOUT <= DDS_channel_4;
						CH4_EN   <= '1';
					when x"2" =>
						CH4_DOUT <= std_logic_vector(unsigned(PWM_in_4) + x"800");
						CH4_EN   <= '1';
					when x"8" =>
						CH4_DOUT <= std_logic_vector(unsigned(ARB_in_0) + x"800");
						CH4_EN   <= '1';
					when x"9" =>
						CH4_DOUT <= std_logic_vector(unsigned(ARB_in_1) + x"800");
						CH4_EN   <= '1';
					when x"A" =>
						CH4_DOUT <= std_logic_vector(unsigned(ARB_in_2) + x"800");
						CH4_EN   <= '1';
					when x"B" =>
						CH4_DOUT <= std_logic_vector(unsigned(ARB_in_3) + x"800");
						CH4_EN   <= '1';
					when x"C" =>
						CH4_DOUT <= std_logic_vector(unsigned(ARB_in_4) + x"800");
						CH4_EN   <= '1';
					when x"D" =>
						CH4_DOUT <= std_logic_vector(unsigned(ARB_in_5) + x"800");
						CH4_EN   <= '1';
					when x"E" =>
						CH4_DOUT <= std_logic_vector(unsigned(ARB_in_6) + x"800");
						CH4_EN   <= '1';
					when x"F" =>
						CH4_DOUT <= std_logic_vector(unsigned(ARB_in_7) + x"800");
						CH4_EN   <= '1';
					when others =>
						CH4_DOUT <= x"000";
						CH4_EN   <= '0';
				end case;
			end if;
		end if;
	end process DATA_PREP_CH4;
	DATA_PREP_CH5 : process (S_AXI_ACLK, M_RESYNC)
	begin
		if rising_edge(S_AXI_ACLK) then
			if M_RESYNC = '0' then
				--Resync
				CH5_DOUT <= x"000";
				CH5_EN   <= '0';
			else
				case(channel_states(11 downto 8)) is
					when x"0" =>
						CH5_DOUT <= x"000";
					when x"1" =>
						CH5_DOUT <= DDS_channel_5;
						CH5_EN   <= '1';
					when x"2" =>
						CH5_DOUT <= std_logic_vector(unsigned(PWM_in_5) + x"800");
						CH5_EN   <= '1';
					when x"8" =>
						CH5_DOUT <= std_logic_vector(unsigned(ARB_in_0) + x"800");
						CH5_EN   <= '1';
					when x"9" =>
						CH5_DOUT <= std_logic_vector(unsigned(ARB_in_1) + x"800");
						CH5_EN   <= '1';
					when x"A" =>
						CH5_DOUT <= std_logic_vector(unsigned(ARB_in_2) + x"800");
						CH5_EN   <= '1';
					when x"B" =>
						CH5_DOUT <= std_logic_vector(unsigned(ARB_in_3) + x"800");
						CH5_EN   <= '1';
					when x"C" =>
						CH5_DOUT <= std_logic_vector(unsigned(ARB_in_4) + x"800");
						CH5_EN   <= '1';
					when x"D" =>
						CH5_DOUT <= std_logic_vector(unsigned(ARB_in_5) + x"800");
						CH5_EN   <= '1';
					when x"E" =>
						CH5_DOUT <= std_logic_vector(unsigned(ARB_in_6) + x"800");
						CH5_EN   <= '1';
					when x"F" =>
						CH5_DOUT <= std_logic_vector(unsigned(ARB_in_7) + x"800");
						CH5_EN   <= '1';
					when others =>
						CH5_DOUT <= x"000";
						CH5_EN   <= '0';
				end case;
			end if;
		end if;
	end process DATA_PREP_CH5;
	DATA_PREP_CH6 : process (S_AXI_ACLK, M_RESYNC)
	begin
		if rising_edge(S_AXI_ACLK) then
			if M_RESYNC = '0' then
				--Resync
				CH6_DOUT <= x"000";
				CH6_EN   <= '0';
			else
				case(channel_states(7 downto 4)) is
					when x"0" =>
						CH6_DOUT <= x"000";
						CH6_EN   <= '0';
					when x"1" =>
						CH6_DOUT <= DDS_channel_6;
						CH6_EN   <= '1';
					when x"2" =>
						CH6_DOUT <= std_logic_vector(unsigned(PWM_in_6) + x"800");
						CH6_EN   <= '1';
					when x"8" =>
						CH6_DOUT <= std_logic_vector(unsigned(ARB_in_0) + x"800");
						CH6_EN   <= '1';
					when x"9" =>
						CH6_DOUT <= std_logic_vector(unsigned(ARB_in_1) + x"800");
						CH6_EN   <= '1';
					when x"A" =>
						CH6_DOUT <= std_logic_vector(unsigned(ARB_in_2) + x"800");
						CH6_EN   <= '1';
					when x"B" =>
						CH6_DOUT <= std_logic_vector(unsigned(ARB_in_3) + x"800");
						CH6_EN   <= '1';
					when x"C" =>
						CH6_DOUT <= std_logic_vector(unsigned(ARB_in_4) + x"800");
						CH6_EN   <= '1';
					when x"D" =>
						CH6_DOUT <= std_logic_vector(unsigned(ARB_in_5) + x"800");
						CH6_EN   <= '1';
					when x"E" =>
						CH6_DOUT <= std_logic_vector(unsigned(ARB_in_6) + x"800");
						CH6_EN   <= '1';
					when x"F" =>
						CH6_DOUT <= std_logic_vector(unsigned(ARB_in_7) + x"800");
						CH6_EN   <= '1';
					when others =>
						CH6_DOUT <= x"000";
						CH6_EN   <= '0';
				end case;
			end if;
		end if;
	end process DATA_PREP_CH6;
	DATA_PREP_CH7 : process (S_AXI_ACLK, M_RESYNC)
	begin
		if rising_edge(S_AXI_ACLK) then
			if M_RESYNC = '0' then
				--Resync
				CH7_DOUT <= x"000";
				CH7_EN   <= '0';
			else
				case(channel_states(3 downto 0)) is
					when x"0" =>
						CH7_DOUT <= x"000";
						CH7_EN   <= '0';
					when x"1" =>
						CH7_DOUT <= DDS_channel_7;
						CH7_EN   <= '1';
					when x"2" =>
						CH7_DOUT <= std_logic_vector(unsigned(PWM_in_7) + x"800");
						CH7_EN   <= '1';
					when x"8" =>
						CH7_DOUT <= std_logic_vector(unsigned(ARB_in_0) + x"800");
						CH7_EN   <= '1';
					when x"9" =>
						CH7_DOUT <= std_logic_vector(unsigned(ARB_in_1) + x"800");
						CH7_EN   <= '1';
					when x"A" =>
						CH7_DOUT <= std_logic_vector(unsigned(ARB_in_2) + x"800");
						CH7_EN   <= '1';
					when x"B" =>
						CH7_DOUT <= std_logic_vector(unsigned(ARB_in_3) + x"800");
						CH7_EN   <= '1';
					when x"C" =>
						CH7_DOUT <= std_logic_vector(unsigned(ARB_in_4) + x"800");
						CH7_EN   <= '1';
					when x"D" =>
						CH7_DOUT <= std_logic_vector(unsigned(ARB_in_5) + x"800");
						CH7_EN   <= '1';
					when x"E" =>
						CH7_DOUT <= std_logic_vector(unsigned(ARB_in_6) + x"800");
						CH7_EN   <= '1';
					when x"F" =>
						CH7_DOUT <= std_logic_vector(unsigned(ARB_in_7) + x"800");
						CH7_EN   <= '1';
					when others =>
						CH7_DOUT <= x"000";
						CH7_EN   <= '0';
				end case;
			end if;
		end if;
	end process DATA_PREP_CH7;
end Behavioral;