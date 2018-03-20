----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 01/15/2018 06:00:07 PM
-- Design Name:
-- Module Name: ARB_PWM_Generator - arch_impl
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ARB_PWM_Generator is
	port 
	(
		S_AXI_ACLK      : in STD_LOGIC;
		M_RESYNC        : in STD_LOGIC;
		M_WRITE         : in STD_LOGIC;
		PWM_ARB_TICK_IN : in STD_LOGIC;
 
		ARB_PWM_IN_0    : in STD_LOGIC_VECTOR (64 downto 0);
		ARB_PWM_IN_1    : in STD_LOGIC_VECTOR (64 downto 0);
		ARB_PWM_IN_2    : in STD_LOGIC_VECTOR (64 downto 0);
		ARB_PWM_IN_3    : in STD_LOGIC_VECTOR (64 downto 0);
		ARB_PWM_IN_4    : in STD_LOGIC_VECTOR (64 downto 0);
		ARB_PWM_IN_5    : in STD_LOGIC_VECTOR (64 downto 0);
		ARB_PWM_IN_6    : in STD_LOGIC_VECTOR (64 downto 0);
		ARB_PWM_IN_7    : in STD_LOGIC_VECTOR (64 downto 0);
 
		ARB_WADDR_0     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WADDR_1     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WADDR_2     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WADDR_3     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WADDR_4     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WADDR_5     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WADDR_6     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WADDR_7     : out STD_LOGIC_VECTOR (11 downto 0);
 
		ARB_WDATA_0     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WDATA_1     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WDATA_2     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WDATA_3     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WDATA_4     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WDATA_5     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WDATA_6     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_WDATA_7     : out STD_LOGIC_VECTOR (11 downto 0);
 
		ARB_WEN_0       : out STD_LOGIC;
		ARB_WEN_1       : out STD_LOGIC;
		ARB_WEN_2       : out STD_LOGIC;
		ARB_WEN_3       : out STD_LOGIC;
		ARB_WEN_4       : out STD_LOGIC;
		ARB_WEN_5       : out STD_LOGIC;
		ARB_WEN_6       : out STD_LOGIC;
		ARB_WEN_7       : out STD_LOGIC;
 
		ARB_RADDR_0     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_RADDR_1     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_RADDR_2     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_RADDR_3     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_RADDR_4     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_RADDR_5     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_RADDR_6     : out STD_LOGIC_VECTOR (11 downto 0);
		ARB_RADDR_7     : out STD_LOGIC_VECTOR (11 downto 0);
 
		ARB_REN_0       : out STD_LOGIC;
		ARB_REN_1       : out STD_LOGIC;
		ARB_REN_2       : out STD_LOGIC;
		ARB_REN_3       : out STD_LOGIC;
		ARB_REN_4       : out STD_LOGIC;
		ARB_REN_5       : out STD_LOGIC;
		ARB_REN_6       : out STD_LOGIC;
		ARB_REN_7       : out STD_LOGIC
	);
end ARB_PWM_Generator;

architecture arch_impl of ARB_PWM_Generator is
	signal clk                : std_logic := '0';
	signal resync             : std_logic := '1';
	signal write              : std_logic := '1';
	signal TICK               : std_logic := '0';
 
	signal ch_flag_vector     : std_logic_vector(7 downto 0) := x"00";
	signal arb_read_en_vector : std_logic_vector(7 downto 0) := x"00";

	signal hi_cnt_0           : std_logic_vector(19 downto 0) := x"00000";
	signal hi_cnt_1           : std_logic_vector(19 downto 0) := x"00000";
	signal hi_cnt_2           : std_logic_vector(19 downto 0) := x"00000";
	signal hi_cnt_3           : std_logic_vector(19 downto 0) := x"00000";
	signal hi_cnt_4           : std_logic_vector(19 downto 0) := x"00000";
	signal hi_cnt_5           : std_logic_vector(19 downto 0) := x"00000";
	signal hi_cnt_6           : std_logic_vector(19 downto 0) := x"00000";
	signal hi_cnt_7           : std_logic_vector(19 downto 0) := x"00000";
 
	signal lo_cnt_0           : std_logic_vector(19 downto 0) := x"00000";
	signal lo_cnt_1           : std_logic_vector(19 downto 0) := x"00000";
	signal lo_cnt_2           : std_logic_vector(19 downto 0) := x"00000";
	signal lo_cnt_3           : std_logic_vector(19 downto 0) := x"00000";
	signal lo_cnt_4           : std_logic_vector(19 downto 0) := x"00000";
	signal lo_cnt_5           : std_logic_vector(19 downto 0) := x"00000";
	signal lo_cnt_6           : std_logic_vector(19 downto 0) := x"00000";
	signal lo_cnt_7           : std_logic_vector(19 downto 0) := x"00000";
 
	signal hi_val_0           : std_logic_vector(11 downto 0) := x"000";
	signal hi_val_1           : std_logic_vector(11 downto 0) := x"000";
	signal hi_val_2           : std_logic_vector(11 downto 0) := x"000";
	signal hi_val_3           : std_logic_vector(11 downto 0) := x"000";
	signal hi_val_4           : std_logic_vector(11 downto 0) := x"000";
	signal hi_val_5           : std_logic_vector(11 downto 0) := x"000";
	signal hi_val_6           : std_logic_vector(11 downto 0) := x"000";
	signal hi_val_7           : std_logic_vector(11 downto 0) := x"000";
 
	signal lo_val_0           : std_logic_vector(11 downto 0) := x"000";
	signal lo_val_1           : std_logic_vector(11 downto 0) := x"000";
	signal lo_val_2           : std_logic_vector(11 downto 0) := x"000";
	signal lo_val_3           : std_logic_vector(11 downto 0) := x"000";
	signal lo_val_4           : std_logic_vector(11 downto 0) := x"000";
	signal lo_val_5           : std_logic_vector(11 downto 0) := x"000";
	signal lo_val_6           : std_logic_vector(11 downto 0) := x"000";
	signal lo_val_7           : std_logic_vector(11 downto 0) := x"000";

	signal OUT_0              : std_logic_vector(11 downto 0) := x"000";
	signal OUT_1              : std_logic_vector(11 downto 0) := x"000";
	signal OUT_2              : std_logic_vector(11 downto 0) := x"000";
	signal OUT_3              : std_logic_vector(11 downto 0) := x"000";
	signal OUT_4              : std_logic_vector(11 downto 0) := x"000";
	signal OUT_5              : std_logic_vector(11 downto 0) := x"000";
	signal OUT_6              : std_logic_vector(11 downto 0) := x"000";
	signal OUT_7              : std_logic_vector(11 downto 0) := x"000";
 
	signal count_0            : integer range 0 to 1048575 := 0;
	signal count_1            : integer range 0 to 1048575 := 0;
	signal count_2            : integer range 0 to 1048575 := 0;
	signal count_3            : integer range 0 to 1048575 := 0;
	signal count_4            : integer range 0 to 1048575 := 0;
	signal count_5            : integer range 0 to 1048575 := 0;
	signal count_6            : integer range 0 to 1048575 := 0;
	signal count_7            : integer range 0 to 1048575 := 0;
 
begin
	clk            <= S_AXI_ACLK;
	resync         <= M_RESYNC;
	write          <= M_WRITE;
	TICK           <= PWM_ARB_TICK_IN;
 
	ch_flag_vector <= ARB_PWM_IN_7(64) & ARB_PWM_IN_6(64) & 
		ARB_PWM_IN_5(64) & ARB_PWM_IN_4(64) & 
		ARB_PWM_IN_3(64) & ARB_PWM_IN_2(64) & 
		ARB_PWM_IN_1(64) & ARB_PWM_IN_0(64);
 
		arb_read_en_vector <= not(ch_flag_vector);
 
		hi_val_0           <= ARB_PWM_IN_0(63 downto 52);
		hi_val_1           <= ARB_PWM_IN_1(63 downto 52);
		hi_val_2           <= ARB_PWM_IN_2(63 downto 52);
		hi_val_3           <= ARB_PWM_IN_3(63 downto 52);
		hi_val_4           <= ARB_PWM_IN_4(63 downto 52);
		hi_val_5           <= ARB_PWM_IN_5(63 downto 52);
		hi_val_6           <= ARB_PWM_IN_6(63 downto 52);
		hi_val_7           <= ARB_PWM_IN_7(63 downto 52);
 
		lo_val_0           <= ARB_PWM_IN_0(51 downto 40); 
		lo_val_1           <= ARB_PWM_IN_1(51 downto 40);
		lo_val_2           <= ARB_PWM_IN_2(51 downto 40);
		lo_val_3           <= ARB_PWM_IN_3(51 downto 40);
		lo_val_4           <= ARB_PWM_IN_4(51 downto 40);
		lo_val_5           <= ARB_PWM_IN_5(51 downto 40);
		lo_val_6           <= ARB_PWM_IN_6(51 downto 40);
		lo_val_7           <= ARB_PWM_IN_7(51 downto 40);
 
		hi_cnt_0           <= ARB_PWM_IN_0(39 downto 20);
		hi_cnt_1           <= ARB_PWM_IN_1(39 downto 20);
		hi_cnt_2           <= ARB_PWM_IN_2(39 downto 20);
		hi_cnt_3           <= ARB_PWM_IN_3(39 downto 20);
		hi_cnt_4           <= ARB_PWM_IN_4(39 downto 20);
		hi_cnt_5           <= ARB_PWM_IN_5(39 downto 20);
		hi_cnt_6           <= ARB_PWM_IN_6(39 downto 20);
		hi_cnt_7           <= ARB_PWM_IN_7(39 downto 20);
 
		lo_cnt_0           <= ARB_PWM_IN_0(19 downto 0); 
		lo_cnt_1           <= ARB_PWM_IN_1(19 downto 0);
		lo_cnt_2           <= ARB_PWM_IN_2(19 downto 0);
		lo_cnt_3           <= ARB_PWM_IN_3(19 downto 0);
		lo_cnt_4           <= ARB_PWM_IN_4(19 downto 0);
		lo_cnt_5           <= ARB_PWM_IN_5(19 downto 0);
		lo_cnt_6           <= ARB_PWM_IN_6(19 downto 0);
		lo_cnt_7           <= ARB_PWM_IN_7(19 downto 0);
 
		ARB_RADDR_0        <= OUT_0;
		ARB_RADDR_1        <= OUT_1;
		ARB_RADDR_2        <= OUT_2;
		ARB_RADDR_3        <= OUT_3;
		ARB_RADDR_4        <= OUT_4;
		ARB_RADDR_5        <= OUT_5;
		ARB_RADDR_6        <= OUT_6;
		ARB_RADDR_7        <= OUT_7;
 
		CLOCK_DIV_0 : process (clk, TICK, resync)
		begin
			if rising_edge(clk) then
				if resync = '0' or write = '0' then
					OUT_0   <= (others => '0');
					count_0 <= 0;
 
				elsif (TICK = '1') then
 
					--PWM Logic (ie channel flag is '1')
					if (count_0 = to_integer(unsigned(hi_cnt_0)) and OUT_0 = hi_val_0 and ch_flag_vector(0) = '1') then
						OUT_0   <= lo_val_0;
						count_0 <= 0;
					elsif (count_0 = to_integer(unsigned(lo_cnt_0)) and OUT_0 = lo_val_0 and ch_flag_vector(0) = '1') then
						OUT_0   <= hi_val_0;
						count_0 <= 0;
 
						--Arb Address Increment Logic 
					elsif (count_0 = to_integer(unsigned(lo_cnt_0)) and ch_flag_vector(0) = '0') then
						if (OUT_0 = x"111") then
							OUT_0   <= x"000";
							count_0 <= 0;
						else
							OUT_0   <= std_logic_vector(unsigned(OUT_0) + natural(1));
							count_0 <= 0;
						end if;
					elsif write = '0' then
 
					else
						count_0 <= count_0 + 1;
					end if;
				end if;
			end if;
		end process CLOCK_DIV_0;

		CLOCK_DIV_1 : process (clk, TICK, resync)
		begin
			if rising_edge(clk) then
				if resync = '0' or write = '0' then
					OUT_1   <= (others => '0');
					count_1 <= 0;
 
				elsif (TICK = '1') then
 
					--PWM Logic (ie channel flag is '1')
					if (count_1 = to_integer(unsigned(hi_cnt_1)) and OUT_1 = hi_val_1 and ch_flag_vector(1) = '1') then
						OUT_1   <= lo_val_1;
						count_1 <= 0;
					elsif (count_1 = to_integer(unsigned(lo_cnt_1)) and OUT_1 = lo_val_1 and ch_flag_vector(1) = '1') then
						OUT_1   <= hi_val_1;
						count_1 <= 0;
 
						--Arb Address Increment Logic 
					elsif (count_1 = to_integer(unsigned(lo_cnt_1)) and ch_flag_vector(1) = '0') then
						--check if reached end of ARB Samples
						if (OUT_1 = x"111") then
							OUT_1   <= x"000";
							count_1 <= 0;
						else
							OUT_1   <= std_logic_vector(unsigned(OUT_1) + natural(1));
							count_1 <= 0;
						end if;
 
					else
						count_1 <= count_1 + 1;
					end if;
				end if;
			end if;
		end process CLOCK_DIV_1;

		CLOCK_DIV_2 : process (clk, TICK, resync)
		begin
			if rising_edge(clk) then
				if resync = '0' or write = '0' then
					OUT_2   <= (others => '0');
					count_2 <= 0;
 
				elsif (TICK = '1') then
 
					--PWM Logic (ie channel flag is '2')
					if (count_2 = to_integer(unsigned(hi_cnt_2)) and OUT_2 = hi_val_2 and ch_flag_vector(2) = '1') then
						OUT_2   <= lo_val_2;
						count_2 <= 0;
					elsif (count_2 = to_integer(unsigned(lo_cnt_2)) and OUT_2 = lo_val_2 and ch_flag_vector(2) = '1') then
						OUT_2   <= hi_val_2;
						count_2 <= 0;
 
						--Arb Address Increment Logic 
					elsif (count_2 = to_integer(unsigned(lo_cnt_2)) and ch_flag_vector(2) = '0') then
						--check if reached end of ARB Samples
						if (OUT_2 = x"111") then
							OUT_2   <= x"000";
							count_2 <= 0;
						else
							OUT_2   <= std_logic_vector(unsigned(OUT_2) + natural(1));
							count_2 <= 0;
						end if;
					else
						count_2 <= count_2 + 1;
					end if;
				end if;
			end if;
		end process CLOCK_DIV_2;

		CLOCK_DIV_3 : process (clk, TICK, resync)
		begin
			if rising_edge(clk) then
				if resync = '0' or write = '0' then
					OUT_3   <= (others => '0');
					count_3 <= 0;
 
				elsif (TICK = '1') then
 
					--PWM Logic (ie channel flag is '1')
					if (count_3 = to_integer(unsigned(hi_cnt_3)) and OUT_3 = hi_val_3 and ch_flag_vector(3) = '1') then
						OUT_3   <= lo_val_3;
						count_3 <= 0;
					elsif (count_3 = to_integer(unsigned(lo_cnt_3)) and OUT_3 = lo_val_3 and ch_flag_vector(3) = '1') then
						OUT_3   <= hi_val_3;
						count_3 <= 0;
 
						--Arb Address Increment Logic 
					elsif (count_3 = to_integer(unsigned(lo_cnt_3)) and ch_flag_vector(3) = '0') then
						--check if reached end of ARB Samples
						if (OUT_3 = x"111") then
							OUT_3   <= x"000";
							count_3 <= 0;
						else
							OUT_3   <= std_logic_vector(unsigned(OUT_3) + natural(1));
							count_3 <= 0;
						end if;
					else
						count_3 <= count_3 + 1;
					end if;
				end if;
			end if;
		end process CLOCK_DIV_3;

		CLOCK_DIV_4 : process (clk, TICK, resync)
		begin
			if rising_edge(clk) then
				if resync = '0' or write = '0' then
					OUT_4   <= (others => '0');
					count_4 <= 0;
 
				elsif (TICK = '1') then
 
					--PWM Logic (ie channel flag is '1')
					if (count_4 = to_integer(unsigned(hi_cnt_4)) and OUT_4 = hi_val_4 and ch_flag_vector(4) = '1') then
						OUT_4   <= lo_val_4;
						count_4 <= 0;
					elsif (count_4 = to_integer(unsigned(lo_cnt_4)) and OUT_4 = lo_val_4 and ch_flag_vector(4) = '1') then
						OUT_4   <= hi_val_4;
						count_4 <= 0;
 
						--Arb Address Increment Logic 
					elsif (count_4 = to_integer(unsigned(lo_cnt_4)) and ch_flag_vector(4) = '0') then
						--check if reached end of ARB Samples
						if (OUT_4 = x"111") then
							OUT_4   <= x"000";
							count_4 <= 0;
						else
							OUT_4   <= std_logic_vector(unsigned(OUT_4) + natural(1));
							count_4 <= 0;
						end if;
					else
						count_4 <= count_4 + 1;
					end if;
				end if;
			end if;
		end process CLOCK_DIV_4;

		CLOCK_DIV_5 : process (clk, TICK, resync)
		begin
			if rising_edge(clk) then
				if resync = '0' or write = '0' then
					OUT_5   <= (others => '0');
					count_5 <= 0;
 
				elsif (TICK = '1') then
 
					--PWM Logic (ie channel flag is '1')
					if (count_5 = to_integer(unsigned(hi_cnt_5)) and OUT_5 = hi_val_5 and ch_flag_vector(5) = '1') then
						OUT_5   <= lo_val_5;
						count_5 <= 0;
					elsif (count_5 = to_integer(unsigned(lo_cnt_5)) and OUT_5 = lo_val_5 and ch_flag_vector(5) = '1') then
						OUT_5   <= hi_val_5;
						count_5 <= 0;
 
						--Arb Address Increment Logic 
					elsif (count_5 = to_integer(unsigned(lo_cnt_5)) and ch_flag_vector(5) = '0') then
						--check if reached end of ARB Samples
						if (OUT_5 = x"111") then
							OUT_5   <= x"000";
							count_5 <= 0;
						else
							OUT_5   <= std_logic_vector(unsigned(OUT_5) + natural(1));
							count_5 <= 0;
						end if;
					else
						count_5 <= count_5 + 1;
					end if;
				end if;
			end if;
		end process CLOCK_DIV_5;

		CLOCK_DIV_6 : process (clk, TICK, resync)
		begin
			if rising_edge(clk) then
				if resync = '0' or write = '0' then
					OUT_6   <= (others => '0');
					count_6 <= 0;
 
				elsif (TICK = '1') then
 
					--PWM Logic (ie channel flag is '1')
					if (count_6 = to_integer(unsigned(hi_cnt_6)) and OUT_6 = hi_val_6 and ch_flag_vector(6) = '1') then
						OUT_6   <= lo_val_6;
						count_6 <= 0;
					elsif (count_6 = to_integer(unsigned(lo_cnt_6)) and OUT_6 = lo_val_6 and ch_flag_vector(6) = '1') then
						OUT_6   <= hi_val_6;
						count_6 <= 0;
 
						--Arb Address Increment Logic 
					elsif (count_6 = to_integer(unsigned(lo_cnt_6)) and ch_flag_vector(6) = '0') then
						--check if reached end of ARB Samples
						if (OUT_6 = x"111") then
							OUT_6   <= x"000";
							count_6 <= 0;
						else
							OUT_6   <= std_logic_vector(unsigned(OUT_6) + natural(1));
							count_6 <= 0;
						end if;
					else
						count_6 <= count_6 + 1;
					end if;
				end if;
			end if;
		end process CLOCK_DIV_6;

		CLOCK_DIV_7 : process (clk, TICK, resync)
		begin
			if rising_edge(clk) then
				if resync = '0' or write = '0' then
					OUT_7   <= (others => '0');
					count_7 <= 0;
 
				elsif (TICK = '1') then
 
					--PWM Logic (ie channel flag is '1')
					if (count_7 = to_integer(unsigned(hi_cnt_7)) and OUT_7 = hi_val_7 and ch_flag_vector(7) = '1') then
						OUT_7   <= lo_val_7;
						count_7 <= 0;
					elsif (count_7 = to_integer(unsigned(lo_cnt_7)) and OUT_7 = lo_val_7 and ch_flag_vector(7) = '1') then
						OUT_7   <= hi_val_7;
						count_7 <= 0;
 
						--Arb Address Increment Logic 
					elsif (count_7 = to_integer(unsigned(lo_cnt_7)) and ch_flag_vector(7) = '0') then
						--check if reached end of ARB Samples
						if (OUT_7 = x"111") then
							OUT_7   <= x"000";
							count_7 <= 0;
						else
							OUT_7   <= std_logic_vector(unsigned(OUT_7) + natural(1));
							count_7 <= 0;
						end if;
					else
						count_7 <= count_7 + 1;
					end if;
				end if;
			end if;
		end process CLOCK_DIV_7;

		ARB_READ_EN_LATCH : process (clk, resync)
		begin
			if rising_edge(clk) then
				if resync = '0' or write = '0' then
					ARB_REN_0 <= '0';
					ARB_REN_1 <= '0';
					ARB_REN_2 <= '0';
					ARB_REN_3 <= '0';
					ARB_REN_4 <= '0';
					ARB_REN_5 <= '0';
					ARB_REN_6 <= '0';
					ARB_REN_7 <= '0';
				else
					ARB_REN_0 <= arb_read_en_vector(0);
					ARB_REN_1 <= arb_read_en_vector(1);
					ARB_REN_2 <= arb_read_en_vector(2);
					ARB_REN_3 <= arb_read_en_vector(3);
					ARB_REN_4 <= arb_read_en_vector(4);
					ARB_REN_5 <= arb_read_en_vector(5);
					ARB_REN_6 <= arb_read_en_vector(6);
					ARB_REN_7 <= arb_read_en_vector(7);
				end if;
			end if; 
		end process ARB_READ_EN_LATCH;

end arch_impl;