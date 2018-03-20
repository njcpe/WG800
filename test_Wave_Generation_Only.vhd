library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_Wave_Generation_Only is 
end test_Wave_Generation_Only;


architecture TB of test_Wave_Generation_Only is

component Wave_Generation_Only is
port (
  DAC_CS_N_0 : out STD_LOGIC;
  DAC_CS_N_1 : out STD_LOGIC;
  DAC_CS_N_2 : out STD_LOGIC;
  DAC_CS_N_3 : out STD_LOGIC;
  DAC_CS_N_4 : out STD_LOGIC;
  DAC_CS_N_5 : out STD_LOGIC;
  DAC_CS_N_6 : out STD_LOGIC;
  DAC_CS_N_7 : out STD_LOGIC;
  DAC_DAT_0 : out STD_LOGIC;
  DAC_DAT_1 : out STD_LOGIC;
  DAC_DAT_2 : out STD_LOGIC;
  DAC_DAT_3 : out STD_LOGIC;
  DAC_DAT_4 : out STD_LOGIC;
  DAC_DAT_5 : out STD_LOGIC;
  DAC_DAT_6 : out STD_LOGIC;
  DAC_DAT_7 : out STD_LOGIC;
  DAC_SCLK_0 : out STD_LOGIC;
  DAC_SCLK_1 : out STD_LOGIC;
  DAC_SCLK_2 : out STD_LOGIC;
  DAC_SCLK_3 : out STD_LOGIC;
  DAC_SCLK_4 : out STD_LOGIC;
  DAC_SCLK_5 : out STD_LOGIC;
  DAC_SCLK_6 : out STD_LOGIC;
  DAC_SCLK_7 : out STD_LOGIC;
  S_AXI_0_araddr : in STD_LOGIC_VECTOR (4 downto 0);
  S_AXI_0_arready : out STD_LOGIC;
  S_AXI_0_arvalid : in STD_LOGIC;
  S_AXI_0_awaddr : in STD_LOGIC_VECTOR (4 downto 0);
  S_AXI_0_awready : out STD_LOGIC;
  S_AXI_0_awvalid : in STD_LOGIC;
  S_AXI_0_bready : in STD_LOGIC;
  S_AXI_0_bresp : out STD_LOGIC_VECTOR (1 downto 0);
  S_AXI_0_bvalid : out STD_LOGIC;
  S_AXI_0_rdata : out STD_LOGIC_VECTOR (31 downto 0);
  S_AXI_0_rready : in STD_LOGIC;
  S_AXI_0_rresp : out STD_LOGIC_VECTOR (1 downto 0);
  S_AXI_0_rvalid : out STD_LOGIC;
  S_AXI_0_wdata : in STD_LOGIC_VECTOR (31 downto 0);
  S_AXI_0_wready : out STD_LOGIC;
  S_AXI_0_wstrb : in STD_LOGIC_VECTOR (3 downto 0);
  S_AXI_0_wvalid : in STD_LOGIC;
  S_AXI_ACLK_0 : in STD_LOGIC;
  S_AXI_ARESETN_0 : in STD_LOGIC
);
end component Wave_Generation_Only;

signal DAC_CS_N_0 : STD_LOGIC;
signal DAC_CS_N_1 : STD_LOGIC;
signal DAC_CS_N_2 : STD_LOGIC;
signal DAC_CS_N_3 : STD_LOGIC;
signal DAC_CS_N_4 : STD_LOGIC;
signal DAC_CS_N_5 : STD_LOGIC;
signal DAC_CS_N_6 : STD_LOGIC;
signal DAC_CS_N_7 : STD_LOGIC;
signal DAC_DAT_0 : STD_LOGIC;
signal DAC_DAT_1 : STD_LOGIC;
signal DAC_DAT_2 : STD_LOGIC;
signal DAC_DAT_3 : STD_LOGIC;
signal DAC_DAT_4 : STD_LOGIC;
signal DAC_DAT_5 : STD_LOGIC;
signal DAC_DAT_6 : STD_LOGIC;
signal DAC_DAT_7 : STD_LOGIC;
signal DAC_SCLK_0 : STD_LOGIC;
signal DAC_SCLK_1 : STD_LOGIC;
signal DAC_SCLK_2 : STD_LOGIC;
signal DAC_SCLK_3 : STD_LOGIC;
signal DAC_SCLK_4 : STD_LOGIC;
signal DAC_SCLK_5 : STD_LOGIC;
signal DAC_SCLK_6 : STD_LOGIC;
signal DAC_SCLK_7 : STD_LOGIC;
signal S_AXI_0_araddr : STD_LOGIC_VECTOR (4 downto 0);
signal S_AXI_0_arready : STD_LOGIC;
signal S_AXI_0_arvalid : STD_LOGIC;
signal S_AXI_0_awaddr : STD_LOGIC_VECTOR (4 downto 0);
signal S_AXI_0_awready : STD_LOGIC;
signal S_AXI_0_awvalid : STD_LOGIC;
signal S_AXI_0_bready : STD_LOGIC;
signal S_AXI_0_bresp : STD_LOGIC_VECTOR (1 downto 0);
signal S_AXI_0_bvalid : STD_LOGIC;
signal S_AXI_0_rdata : STD_LOGIC_VECTOR (31 downto 0);
signal S_AXI_0_rready : STD_LOGIC;
signal S_AXI_0_rresp : STD_LOGIC_VECTOR (1 downto 0);
signal S_AXI_0_rvalid : STD_LOGIC;
signal S_AXI_0_wdata : STD_LOGIC_VECTOR (31 downto 0);
signal S_AXI_0_wready : STD_LOGIC;
signal S_AXI_0_wstrb : STD_LOGIC_VECTOR (3 downto 0);
signal S_AXI_0_wvalid : STD_LOGIC;
signal S_AXI_ACLK_0 : STD_LOGIC;
signal S_AXI_ARESETN_0 : STD_LOGIC;

constant TbPeriod : time := 10 ns; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';
signal sendIt: std_logic := '0';
signal readIt: std_logic := '0';

begin

DUT: component Wave_Generation_Only port map (
  DAC_CS_N_0 => DAC_CS_N_0,
  DAC_CS_N_1 => DAC_CS_N_1,
  DAC_CS_N_2 => DAC_CS_N_2,
  DAC_CS_N_3 => DAC_CS_N_3,
  DAC_CS_N_4 => DAC_CS_N_4,
  DAC_CS_N_5 => DAC_CS_N_5,
  DAC_CS_N_6 => DAC_CS_N_6,
  DAC_CS_N_7 => DAC_CS_N_7,
  DAC_DAT_0 => DAC_DAT_0,
  DAC_DAT_1 => DAC_DAT_1,
  DAC_DAT_2 => DAC_DAT_2,
  DAC_DAT_3 => DAC_DAT_3,
  DAC_DAT_4 => DAC_DAT_4,
  DAC_DAT_5 => DAC_DAT_5,
  DAC_DAT_6 => DAC_DAT_6,
  DAC_DAT_7 => DAC_DAT_7,
  DAC_SCLK_0 => DAC_SCLK_0,
  DAC_SCLK_1 => DAC_SCLK_1,
  DAC_SCLK_2 => DAC_SCLK_2,
  DAC_SCLK_3 => DAC_SCLK_3,
  DAC_SCLK_4 => DAC_SCLK_4,
  DAC_SCLK_5 => DAC_SCLK_5,
  DAC_SCLK_6 => DAC_SCLK_6,
  DAC_SCLK_7 => DAC_SCLK_7,
  S_AXI_0_araddr => S_AXI_0_araddr,
  S_AXI_0_arready => S_AXI_0_arready,
  S_AXI_0_arvalid => S_AXI_0_arvalid,
  S_AXI_0_awaddr => S_AXI_0_awaddr,
  S_AXI_0_awready => S_AXI_0_awready,
  S_AXI_0_awvalid => S_AXI_0_awvalid,
  S_AXI_0_bready => S_AXI_0_bready,
  S_AXI_0_bresp => S_AXI_0_bresp,
  S_AXI_0_bvalid => S_AXI_0_bvalid,
  S_AXI_0_rdata => S_AXI_0_rdata,
  S_AXI_0_rready => S_AXI_0_rready,
  S_AXI_0_rresp => S_AXI_0_rresp,
  S_AXI_0_rvalid => S_AXI_0_rvalid,
  S_AXI_0_wdata => S_AXI_0_wdata,
  S_AXI_0_wready => S_AXI_0_wready,
  S_AXI_0_wstrb => S_AXI_0_wstrb,
  S_AXI_0_wvalid => S_AXI_0_wvalid,
  S_AXI_ACLK_0 => S_AXI_ACLK_0,
  S_AXI_ARESETN_0 => S_AXI_ARESETN_0
);

TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

-- EDIT: Check that S_AXI_ACLK is really your main clock signal
S_AXI_ACLK_0 <= TbClock;
send : PROCESS
 BEGIN
    S_AXI_0_AWVALID<='0';
    S_AXI_0_WVALID<='0';
    S_AXI_0_BREADY<='0';
    loop
        wait until sendIt = '1';
        wait until TbClock= '0';
            S_AXI_0_AWVALID<='1';
            S_AXI_0_WVALID<='1';
        wait until (S_AXI_0_AWREADY and S_AXI_0_WREADY) = '1';  --Client ready to read address/data        
            S_AXI_0_BREADY<='1';
        wait until S_AXI_0_BVALID = '1';  -- Write result valid
            assert S_AXI_0_BRESP = "00" report "AXI data not written" severity failure;
            S_AXI_0_AWVALID<='0';
            S_AXI_0_WVALID<='0';
            S_AXI_0_BREADY<='1';
        wait until S_AXI_0_BVALID = '0';  -- All finished
            S_AXI_0_BREADY<='0';
    end loop;
 END PROCESS send;

stimuli : process
begin
    -- EDIT Adapt initialization as needed
    S_AXI_ARESETN_0 <= '0';
  		sendIt <= '0';
  		wait for 100 ns;
		S_AXI_ARESETN_0 <= '1';

--Write 1: Ch 0 = Sine Wave, 10V Swing, No Voltage Offset, 2kHz, 90 deg offset 

	S_AXI_0_AWADDR<="00000";
    S_AXI_0_WDATA<=x"00100000";
    S_AXI_0_WSTRB<=b"1111";
    sendIt<='1';                --Start AXI Write to Slave
    wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
 		wait until S_AXI_0_BVALID = '1';
		wait until S_AXI_0_BVALID = '0';  --AXI Write finished
    S_AXI_0_WSTRB<=b"0000";

    S_AXI_0_AWADDR<="00100";
    S_AXI_0_WDATA<=x"FFF00000";
    S_AXI_0_WSTRB<=b"1111";
    sendIt<='1';                --Start AXI Write to Slave
    wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
		wait until S_AXI_0_BVALID = '1';
		wait until S_AXI_0_BVALID = '0';  --AXI Write finished
    S_AXI_0_WSTRB<=b"0000";

    S_AXI_0_AWADDR<="01000";
    S_AXI_0_WDATA<=x"00000000";
    S_AXI_0_WSTRB<=b"1111";
    sendIt<='1';                --Start AXI Write to Slave
    wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
		wait	until S_AXI_0_BVALID = '1';
		wait until S_AXI_0_BVALID = '0';  --AXI Write finished
    S_AXI_0_WSTRB<=b"0000";

    S_AXI_0_AWADDR<="01100";
    S_AXI_0_WDATA<=x"00000A00";
    S_AXI_0_WSTRB<=b"1111";
    sendIt<='1';                --Start AXI Write to Slave
    wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
		wait until S_AXI_0_BVALID = '1';
		wait until S_AXI_0_BVALID = '0';  --AXI Write finished
    S_AXI_0_WSTRB<=b"0000";

    S_AXI_0_AWADDR<="10000";
    S_AXI_0_WDATA<=x"053E2D62";
    S_AXI_0_WSTRB<=b"1111";
    sendIt<='1';                --Start AXI Write to Slave
    wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
		wait until S_AXI_0_BVALID = '1';
		wait until S_AXI_0_BVALID = '0';  --AXI Write finished
    S_AXI_0_WSTRB<=b"0000";
    
--End of Write 1

--Write 2: Ch 6 = PWM, 2V Swing , 4 Volt Offset, 5kHz + 75% Duty Cycle 

		S_AXI_0_AWADDR<="00000";
    S_AXI_0_WDATA<=x"06200000";
    S_AXI_0_WSTRB<=b"1111";
    sendIt<='1';                --Start AXI Write to Slave
    wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
 		wait until S_AXI_0_BVALID = '1';
		wait until S_AXI_0_BVALID = '0';  --AXI Write finished
    S_AXI_0_WSTRB<=b"0000";

    S_AXI_0_AWADDR<="00100";
    S_AXI_0_WDATA<=x"11100000";
    S_AXI_0_WSTRB<=b"1111";
    sendIt<='1';                --Start AXI Write to Slave
    wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
		wait until S_AXI_0_BVALID = '1';
		wait until S_AXI_0_BVALID = '0';  --AXI Write finished
    S_AXI_0_WSTRB<=b"0000";

    S_AXI_0_AWADDR<="01000";
    S_AXI_0_WDATA<=x"000021A7";
    S_AXI_0_WSTRB<=b"1111";
    sendIt<='1';                --Start AXI Write to Slave
    wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
		wait	until S_AXI_0_BVALID = '1';
		wait until S_AXI_0_BVALID = '0';  --AXI Write finished
    S_AXI_0_WSTRB<=b"0000";

    S_AXI_0_AWADDR<="01100";
    S_AXI_0_WDATA<=x"00003E61";
    S_AXI_0_WSTRB<=b"1111";
    sendIt<='1';                --Start AXI Write to Slave
    wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
		wait until S_AXI_0_BVALID = '1';
		wait until S_AXI_0_BVALID = '0';  --AXI Write finished
    S_AXI_0_WSTRB<=b"0000";

    S_AXI_0_AWADDR<="10000";
    S_AXI_0_WDATA<=x"00000000";
    S_AXI_0_WSTRB<=b"1111";
    sendIt<='1';                --Start AXI Write to Slave
    wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
		wait until S_AXI_0_BVALID = '1';
		wait until S_AXI_0_BVALID = '0';  --AXI Write finished
    S_AXI_0_WSTRB<=b"0000";
    
--End of Write 2
 		
 		
    -- Stop the clock and hence terminate the simulation
    --wait for 100 * TbPeriod;
    wait;
end process;

end TB;
