--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

--library xil_defaultlib;
--use xil_defaultlib.DAC_WG_CFG;

--entity testbench is
--generic
--(
--  C_S_AXI_DATA_WIDTH             : integer              := 32;
--  C_S_AXI_ADDR_WIDTH             : integer              := 4
--);

--end testbench;

--architecture Behavioral of testbench is
--    --signal LEDs_out		          : std_logic_vector(7 downto 0);
    
--    signal S_AXI_ACLK                     :  std_logic;
--    signal S_AXI_ARESETN                  :  std_logic;
--    signal S_AXI_AWADDR                   :  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
--    signal S_AXI_AWVALID                  :  std_logic;
--    signal S_AXI_WDATA                    :  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
--    signal S_AXI_WSTRB                    :  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
--    signal S_AXI_WVALID                   :  std_logic;
--    signal S_AXI_BREADY                   :  std_logic;
--    signal S_AXI_ARADDR                   :  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
--    signal S_AXI_ARVALID                  :  std_logic;
--    signal S_AXI_RREADY                   :  std_logic;
--    signal S_AXI_ARREADY                  : std_logic;
--    signal S_AXI_RDATA                    : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
--    signal S_AXI_RRESP                    : std_logic_vector(1 downto 0);
--    signal S_AXI_RVALID                   : std_logic;
--    signal S_AXI_WREADY                   : std_logic;
--    signal S_AXI_BRESP                    : std_logic_vector(1 downto 0);
--    signal S_AXI_BVALID                   : std_logic;
--    signal S_AXI_AWREADY                  : std_logic;
--    signal S_AXI_AWPROT                   : std_logic_vector(2 downto 0);
--    signal S_AXI_ARPROT                   : std_logic_vector(2 downto 0);

    
--    Constant ClockPeriod : TIME := 5 ns;
--    Constant ClockPeriod2 : TIME := 10 ns;
--    shared variable ClockCount : integer range 0 to 50_000 := 10;
--    signal sendIt : std_logic := '0';
--    signal readIt : std_logic := '0';

--begin
	
-- -- Generate S_AXI_ACLK signal
--GENERATE_REFCLOCK : process
--begin
--	wait for (ClockPeriod / 2);
--		ClockCount:= ClockCount+1;
--		S_AXI_ACLK <= '1';
--	wait for (ClockPeriod / 2);
--		S_AXI_ACLK <= '0';
--end process GENERATE_REFCLOCK;

-- -- Initiate process which simulates a master wanting to write.
-- -- This process is blocked on a "Send Flag" (sendIt).
-- -- When the flag goes to 1, the process exits the wait state and
-- -- execute a write transaction.
-- send : PROCESS
-- BEGIN
--    S_AXI_AWVALID<='0';
--    S_AXI_WVALID<='0';
--    S_AXI_BREADY<='0';
--    loop
--        wait until sendIt = '1';
--        wait until S_AXI_ACLK= '0';
--            S_AXI_AWVALID<='1';
--            S_AXI_WVALID<='1';
--        wait until (S_AXI_AWREADY and S_AXI_WREADY) = '1';  --Client ready to read address/data        
--            S_AXI_BREADY<='1';
--        wait until S_AXI_BVALID = '1';  -- Write result valid
--            assert S_AXI_BRESP = "00" report "AXI data not written" severity failure;
--            S_AXI_AWVALID<='0';
--            S_AXI_WVALID<='0';
--            S_AXI_BREADY<='1';
--        wait until S_AXI_BVALID = '0';  -- All finished
--            S_AXI_BREADY<='0';
--    end loop;
-- END PROCESS send;

--  -- Initiate process which simulates a master wanting to read.
--  -- This process is blocked on a "Read Flag" (readIt).
--  -- When the flag goes to 1, the process exits the wait state and
--  -- execute a read transaction.
--  read : PROCESS
--  BEGIN
--    S_AXI_ARVALID<='0';
--    S_AXI_RREADY<='0';
--     loop
--         wait until readIt = '1';
--         wait until S_AXI_ACLK= '0';
--             S_AXI_ARVALID<='1';
--             S_AXI_RREADY<='1';
--         wait until (S_AXI_RVALID and S_AXI_ARREADY) = '1';  --Client provided data
--            assert S_AXI_RRESP = "00" report "AXI data not written" severity failure;
--             S_AXI_ARVALID<='0';
--            S_AXI_RREADY<='0';
--     end loop;
--  END PROCESS read;


-- -- 
-- tb : PROCESS
-- BEGIN
--        S_AXI_ARESETN<='0';
--        sendIt<='0';
--    wait for 15 ns;
--        S_AXI_ARESETN<='1';

--        S_AXI_AWADDR<="0000";
--        S_AXI_WDATA<=x"00000001";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";

--        S_AXI_AWADDR<="0001";
--        S_AXI_WDATA<=x"00000002";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";

--        S_AXI_AWADDR<="0010";
--        S_AXI_WDATA<=x"00000003";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";

--        S_AXI_AWADDR<="0011";
--        S_AXI_WDATA<=x"00000004";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";

--        S_AXI_AWADDR<="0100";
--        S_AXI_WDATA<=x"00000005";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";

--        S_AXI_AWADDR<="0101";
--        S_AXI_WDATA<=x"00000006";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";

--        S_AXI_AWADDR<="0110";
--        S_AXI_WDATA<=x"00000007";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";

--        S_AXI_AWADDR<="0111";
--        S_AXI_WDATA<=x"00000008";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";

--        S_AXI_AWADDR<="1000";
--        S_AXI_WDATA<=x"00000009";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";

--        S_AXI_AWADDR<="1001";
--        S_AXI_WDATA<=x"00000010";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";
        
--        S_AXI_AWADDR<="1010";
--        S_AXI_WDATA<=x"00000011";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";
        
--        S_AXI_AWADDR<="1011";
--        S_AXI_WDATA<=x"00000012";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";
        
--        S_AXI_AWADDR<="1100";
--        S_AXI_WDATA<=x"00000013";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";
            
--        S_AXI_AWADDR<="1101";
--        S_AXI_WDATA<=x"00000014";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";
        
--        S_AXI_AWADDR<="1110";
--        S_AXI_WDATA<=x"00000015";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";

--        S_AXI_AWADDR<="1111";
--        S_AXI_WDATA<=x"00000016";
--        S_AXI_WSTRB<=b"1111";
--        sendIt<='1';                --Start AXI Write to Slave
--        wait for 1 ns; sendIt<='0'; --Clear Start Send Flag
--    wait until S_AXI_BVALID = '1';
--    wait until S_AXI_BVALID = '0';  --AXI Write finished
--        S_AXI_WSTRB<=b"0000";
        
--        S_AXI_ARADDR<=x"0";
--        readIt<='1';                --Start AXI Read from Slave
--        wait for 1 ns; readIt<='0'; --Clear "Start Read" Flag
--    wait until S_AXI_RVALID = '1';
--    wait until S_AXI_RVALID = '0';
       
        
--     wait; -- will wait forever
-- END PROCESS tb;

--end Behavioral;
