----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2018 05:08:33 PM
-- Design Name: 
-- Module Name: wave_generation_tb - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity wave_generation_tb is
end wave_generation_tb;

architecture structure of wave_generation_tb is

	constant CLK_Period : time := 10 ns;
	
	component wave_generation_imp_1UCRYUV is
		port(
			--DAC
			CH1_DAC_CS : out STD_LOGIC;
			CH1_DAC_DAT : out STD_LOGIC;
			CH1_DAC_SCLK : out STD_LOGIC;
			CH2_DAC_CS : out STD_LOGIC;
			CH2_DAC_DAT : out STD_LOGIC;
			CH2_DAC_SCLK : out STD_LOGIC;
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
			CH7_DAC_SCLK : out STD_LOGIC;
			CH8_DAC_CS : out STD_LOGIC;
			CH8_DAC_DAT : out STD_LOGIC;
			CH8_DAC_SCLK : out STD_LOGIC;
			--AXI
			S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
			S_AXI_arready : out STD_LOGIC;
			S_AXI_arvalid : in STD_LOGIC;
			S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
			S_AXI_awready : out STD_LOGIC;
			S_AXI_awvalid : in STD_LOGIC;
			S_AXI_bready : in STD_LOGIC;
			S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
			S_AXI_bvalid : out STD_LOGIC;
			S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
			S_AXI_rready : in STD_LOGIC;
			S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
			S_AXI_rvalid : out STD_LOGIC;
			S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
			S_AXI_wready : out STD_LOGIC;
			S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
			S_AXI_wvalid : in STD_LOGIC;
			--CLK
			aclk : in STD_LOGIC;
			s_axi_aresetn : in std_logic 
			);
			end component ;
				
			--internal signals
			signal DAC_1_CS_N : STD_LOGIC;
			signal DAC_1_DAT : STD_LOGIC;
			signal DAC_1_SCLK : STD_LOGIC;
			signal DAC_2_CS_N : STD_LOGIC;
			signal DAC_2_DAT : STD_LOGIC;
			signal DAC_2_SCLK : STD_LOGIC;
			signal DAC_3_CS_N : STD_LOGIC;
			signal DAC_3_DAT : STD_LOGIC;
			signal DAC_3_SCLK : STD_LOGIC;
			signal DAC_4_CS_N : STD_LOGIC;
			signal DAC_4_DAT : STD_LOGIC;
			signal DAC_4_SCLK : STD_LOGIC;
			signal DAC_5_CS_N : STD_LOGIC;
			signal DAC_5_DAT : STD_LOGIC;
			signal DAC_5_SCLK : STD_LOGIC;
			signal DAC_6_CS_N : STD_LOGIC;
			signal DAC_6_DAT : STD_LOGIC;
			signal DAC_6_SCLK : STD_LOGIC;
			signal DAC_7_CS_N : STD_LOGIC;
			signal DAC_7_DAT : STD_LOGIC;
			signal DAC_7_SCLK : STD_LOGIC;
			signal DAC_8_CS_N : STD_LOGIC;
			signal DAC_8_DAT : STD_LOGIC;
			signal DAC_8_SCLK : STD_LOGIC;
			
			signal S_AXI_1_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
			signal S_AXI_1_ARREADY : STD_LOGIC;
			signal S_AXI_1_ARVALID : STD_LOGIC;
			signal S_AXI_1_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
			signal S_AXI_1_AWREADY : STD_LOGIC;
			signal S_AXI_1_AWVALID : STD_LOGIC;
			signal S_AXI_1_BREADY : STD_LOGIC;
			signal S_AXI_1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
			signal S_AXI_1_BVALID : STD_LOGIC;
			signal S_AXI_1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
			signal S_AXI_1_RREADY : STD_LOGIC;
			signal S_AXI_1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
			signal S_AXI_1_RVALID : STD_LOGIC;
			signal S_AXI_1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
			signal S_AXI_1_WREADY : STD_LOGIC;
			signal S_AXI_1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
			signal S_AXI_1_WVALID : STD_LOGIC;
			signal clk : STD_LOGIC;
			signal s_axi_aresetn_1 : STD_LOGIC;
			
			  Constant ClockPeriod : TIME := 5 ns;
			  Constant ClockPeriod2 : TIME := 10 ns;
			  shared variable ClockCount : integer range 0 to 50_000 := 10;
			  signal sendIt : std_logic := '0';
			  signal readIt : std_logic := '0';
			
			begin
			dut : wave_generation_imp_1UCRYUV
				port map (
					CH1_DAC_CS => DAC_1_CS_N,
					CH1_DAC_DAT => DAC_1_DAT,
					CH1_DAC_SCLK => DAC_1_SCLK,
					CH2_DAC_CS => DAC_2_CS_N,
					CH2_DAC_DAT => DAC_2_DAT,
					CH2_DAC_SCLK => DAC_2_SCLK,
					CH3_DAC_CS => DAC_3_CS_N,
					CH3_DAC_DAT => DAC_3_DAT,
					CH3_DAC_SCLK => DAC_3_SCLK,
					CH4_DAC_CS => DAC_4_CS_N,
					CH4_DAC_DAT => DAC_4_DAT,
					CH4_DAC_SCLK => DAC_4_SCLK,
					CH5_DAC_CS => DAC_5_CS_N,
					CH5_DAC_DAT => DAC_5_DAT,
					CH5_DAC_SCLK => DAC_5_SCLK,
					CH6_DAC_CS => DAC_6_CS_N,
					CH6_DAC_DAT => DAC_6_DAT,
					CH6_DAC_SCLK => DAC_6_SCLK,
					CH7_DAC_CS => DAC_7_CS_N,
					CH7_DAC_DAT => DAC_7_DAT,
					CH7_DAC_SCLK => DAC_7_SCLK,
					CH8_DAC_CS => DAC_8_CS_N,
					CH8_DAC_DAT => DAC_8_DAT,
					CH8_DAC_SCLK => DAC_8_SCLK,
							
					S_AXI_araddr(31 downto 0) => S_AXI_1_ARADDR(31 downto 0),
					S_AXI_arvalid => S_AXI_1_ARVALID,
					 S_AXI_awaddr(31 downto 0) => S_AXI_1_AWADDR(31 downto 0) ,
					S_AXI_awvalid => S_AXI_1_AWVALID,
					S_AXI_bready => S_AXI_1_BREADY,
					S_AXI_rready => S_AXI_1_RREADY,
					S_AXI_wdata(31 downto 0) => S_AXI_1_WDATA(31 downto 0), 
					S_AXI_wstrb(3 downto 0) => S_AXI_1_WSTRB(3 downto 0),
					S_AXI_wvalid => S_AXI_1_WVALID,
					S_AXI_arready => S_AXI_1_ARREADY,
					 S_AXI_awready => S_AXI_1_AWREADY,
					S_AXI_bresp(1 downto 0) => S_AXI_1_BRESP(1 downto 0),
					S_AXI_bvalid => S_AXI_1_BVALID, 
					S_AXI_rdata(31 downto 0) => S_AXI_1_RDATA(31 downto 0),
					S_AXI_rresp(1 downto 0) => S_AXI_1_RRESP(1 downto 0),
					S_AXI_rvalid => S_AXI_1_RVALID,
					S_AXI_wready => S_AXI_1_WREADY, 
					aclk => clk,
					s_axi_aresetn =>  s_axi_aresetn_1
				);
 -- Generate S_AXI_ACLK signal
GENERATE_REFCLOCK : process
begin
	wait for (CLK_Period / 2);
		--ClockCount:= ClockCount+1;
		clk <= '1';
	wait for (CLK_Period / 2);
		clk <= '0';
end process GENERATE_REFCLOCK;

 send : PROCESS
 BEGIN
    S_AXI_1_AWVALID<='0';
    S_AXI_1_WVALID<='0';
    S_AXI_1_BREADY<='0';
    loop
        wait until sendIt = '1';
        wait until clk= '0';
            S_AXI_1_AWVALID<='1';
            S_AXI_1_WVALID<='1';
        wait until (S_AXI_1_AWREADY and S_AXI_1_WREADY) = '1';  --Client ready to read address/data        
            S_AXI_1_BREADY<='1';
        wait until S_AXI_1_BVALID = '1';  -- Write result valid
            assert S_AXI_1_BRESP = "00" report "AXI data not written" severity failure;
            S_AXI_1_AWVALID<='0';
            S_AXI_1_WVALID<='0';
            S_AXI_1_BREADY<='1';
        wait until S_AXI_1_BVALID = '0';  -- All finished
            S_AXI_1_BREADY<='0';
    end loop;
 END PROCESS send;

  -- Initiate process which simulates a master wanting to read.
  -- This process is blocked on a "Read Flag" (readIt).
  -- When the flag goes to 1, the process exits the wait state and
  -- execute a read transaction.
  read : PROCESS
  BEGIN
    S_AXI_1_ARVALID<='0';
    S_AXI_1_RREADY<='0';
     loop
         wait until readIt = '1';
         wait until clk= '0';
             S_AXI_1_ARVALID<='1';
             S_AXI_1_RREADY<='1';
         wait until (S_AXI_1_RVALID and S_AXI_1_ARREADY) = '1';  --Client provided data
            assert S_AXI_1_RRESP = "00" report "AXI data not written" severity failure;
             S_AXI_1_ARVALID<='0';
            S_AXI_1_RREADY<='0';
     end loop;
  END PROCESS read;


 -- 
 tb : PROCESS
 BEGIN
        s_axi_aresetn_1<='0';
        sendIt<='0';
    wait for 15 ns;
        s_axi_aresetn_1<='1';

        S_AXI_1_AWADDR<="0000";
        S_AXI_1_WDATA<=x"00000001";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";

        S_AXI_1_AWADDR<="0001";
        S_AXI_1_WDATA<=x"00000002";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";

        S_AXI_1_AWADDR<="0010";
        S_AXI_1_WDATA<=x"00000003";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";

        S_AXI_1_AWADDR<="0011";
        S_AXI_1_WDATA<=x"00000004";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";

        S_AXI_1_AWADDR<="0100";
        S_AXI_1_WDATA<=x"00000005";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";

        S_AXI_1_AWADDR<="0101";
        S_AXI_1_WDATA<=x"00000006";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";

        S_AXI_1_AWADDR<="0110";
        S_AXI_1_WDATA<=x"00000007";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";

        S_AXI_1_AWADDR<="0111";
        S_AXI_1_WDATA<=x"00000008";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";

        S_AXI_1_AWADDR<="1000";
        S_AXI_1_WDATA<=x"00000009";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";

        S_AXI_1_AWADDR<="1001";
        S_AXI_1_WDATA<=x"00000010";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";
        
        S_AXI_1_AWADDR<="1010";
        S_AXI_1_WDATA<=x"00000011";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";
        
        S_AXI_1_AWADDR<="1011";
        S_AXI_1_WDATA<=x"00000012";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";
        
        S_AXI_1_AWADDR<="1100";
        S_AXI_1_WDATA<=x"00000013";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";
            
        S_AXI_1_AWADDR<="1101";
        S_AXI_1_WDATA<=x"00000014";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";
        
        S_AXI_1_AWADDR<="1110";
        S_AXI_1_WDATA<=x"00000015";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";

        S_AXI_1_AWADDR<="1111";
        S_AXI_1_WDATA<=x"00000016";
        S_AXI_1_WSTRB<=b"1111";
        sendIt<='1';                --Start AXI Write to Slave
        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
    wait until S_AXI_1_BVALID = '1';
    wait until S_AXI_1_BVALID = '0';  --AXI Write finished
        S_AXI_1_WSTRB<=b"0000";
        
--        S_AXI_ARADDR<=x"0";
--        readIt<='1';                --Start AXI Read from Slave
--        wait for 1 ns; readIt<='0'; --Clear "Start Read" Flag
--    wait until S_AXI_RVALID = '1';
--    wait until S_AXI_RVALID = '0';
       
        
     wait; -- will wait forever
 END PROCESS tb;

end architecture structure;
