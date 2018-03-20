-- args: --ieee<=synopsys

---------------------------------------------------------------------------------
-- Company: AstroNova Test and Mesurement / University of Rhode Island ELECOMP Program
-- Engineer: Noah Johnson
--
-- Create Date: 12/20/2017 07:21:44 PM
-- Design Name:
-- Module Name: DDS_config - Behavioral
-- Project Name: WG800_revB
-- Target Devices: WG800
-- Tool Versions: Vivado Design Suite 2017.3.1
-- Description: Sets up all DDS and signal generation signals (i.e. Division factors, Wave types, etc.)
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--------------------------------------------------------------------------------
----------------------------- Entity Declaration -------------------------------
--------------------------------------------------------------------------------
entity DAC_WG_CFG_B is
	generic 
	(
		DAC_DATA_WIDTH : positive := 12; -- This is how many actual valid data bits the DAC has.
		--WAVEGEN_CTR_WIDTH : positive := 20; -- This is how many bits wide the wavegen/PWM counter is.
		DDS_PHASE_WIDTH : positive := 29; -- This is the DDS phase width (PINC) register width.
		NUM_CHANNELS    : positive := 8; -- This is the number of DACs in the wavegen module.

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of S_AXI data bus
		C_S_AXI_DATA_WIDTH : integer := 32;
		-- Width of S_AXI address bus
		C_S_AXI_ADDR_WIDTH : integer := 5
	);

	port 
	(
		-- Users to add ports here
		----------------------------------------------------------------------------------
		--DDS (Sinusoidal)
		DDS_CONFIG_TDATA  : out std_logic_vector(79 downto 0) := (others => '0');
		DDS_CONFIG_TVALID : out std_logic;
		DDS_CONFIG_TLAST  : out std_logic;
 
		--Gain/Offset
		GAIN_VECTOR   : out std_logic_vector(95 downto 0);
		OFFSET_VECTOR : out std_logic_vector(95 downto 0);
 
		--CHANMODE
		CHAN_MODE_VECTOR : out std_logic_vector(31 downto 0);

		--Arbitrary/PWM
		PWM_ARB_0    : out std_logic_vector(64 downto 0);
		PWM_ARB_1    : out std_logic_vector(64 downto 0);
		PWM_ARB_2    : out std_logic_vector(64 downto 0);
		PWM_ARB_3    : out std_logic_vector(64 downto 0);
		PWM_ARB_4    : out std_logic_vector(64 downto 0);
		PWM_ARB_5    : out std_logic_vector(64 downto 0);
		PWM_ARB_6    : out std_logic_vector(64 downto 0);
		PWM_ARB_7    : out std_logic_vector(64 downto 0);
 
		PWM_ARB_TICK : out std_logic;
		RESYNC       : out std_logic;
		WRITE_ARB    : out std_logic;
 
		----------------------------------------------------------------------------------
		-- User ports ends
		-- Do not modify the ports beyond this line
 
		-----------------------------------------------------------------
		--------------------AXI INTERFACE SIGNALS------------------------
		----------------------------------------------------------------- 
		-- Global Clock Signal
		S_AXI_ACLK : in std_logic;
		-- Global Reset Signal. This Signal is Active LOW
		S_AXI_ARESETN : in std_logic;
 
		-----------------------------------------------------------------
		----------------------AXI WRITE SIGNALS--------------------------
		----------------------------------------------------------------- 
		-- Write address (issued by master, acceped by Slave)
		S_AXI_AWADDR : in std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
		-- Write address valid. This signal indicates that the master signaling
		-- valid write address and control information.
		S_AXI_AWVALID : in std_logic;
		-- Write address ready. This signal indicates that the slave is ready
		-- to accept an address and associated control signals.
		S_AXI_AWREADY : out std_logic;
		-- Write data (issued by master, acceped by Slave)
		S_AXI_WDATA : in std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
		-- Write strobes. This signal indicates which byte lanes hold
		-- valid data. There is one write strobe bit for each eight
		-- bits of the write data bus.
		S_AXI_WSTRB : in std_logic_vector((C_S_AXI_DATA_WIDTH/8) - 1 downto 0);
		-- Write valid. This signal indicates that valid write
		-- data and strobes are available.
		S_AXI_WVALID : in std_logic;
		-- Write ready. This signal indicates that the slave
		-- can accept the write data.
		S_AXI_WREADY : out std_logic;

		-----------------------------------------------------------------
		-----------------AXI WRITE RESPONSE SIGNALS----------------------
		----------------------------------------------------------------- 
		-- Write response. This signal indicates the status
		-- of the write transaction.
		S_AXI_BRESP : out std_logic_vector(1 downto 0);
		-- Write response valid. This signal indicates that the channel
		-- is signaling a valid write response.
		S_AXI_BVALID : out std_logic;
		-- Response ready. This signal indicates that the master
		-- can accept a write response.
		S_AXI_BREADY : in std_logic;
 
		-----------------------------------------------------------------
		----------------------AXI READ SIGNALS---------------------------
		----------------------------------------------------------------- 
		-- Read address (issued by master, acceped by Slave)
		S_AXI_ARADDR : in std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
		-- Read address valid. This signal indicates that the channel
		-- is signaling valid read address and control information.
		S_AXI_ARVALID : in std_logic;
		-- Read address ready. This signal indicates that the slave is
		-- ready to accept an address and associated control signals.
		S_AXI_ARREADY : out std_logic;
		-- Read data (issued by slave)
		S_AXI_RDATA : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
 
		-----------------------------------------------------------------
		------------------AXI READ RESPONSE SIGNALS----------------------
		----------------------------------------------------------------- 
		-- Read response. This signal indicates the status of the
		-- read transfer.
		S_AXI_RRESP : out std_logic_vector(1 downto 0);
		-- Read valid. This signal indicates that the channel is
		-- signaling the required read data.
		S_AXI_RVALID : out std_logic;
		-- Read ready. This signal indicates that the master can
		-- accept the read data and response information.
		S_AXI_RREADY : in std_logic
		);
	end DAC_WG_CFG_B;

	-------------------------------------------------------------------------------
	-------------------------- Architecture Description ----------------------------
	--------------------------------------------------------------------------------
	architecture arch_imp of DAC_WG_CFG_B is

		--USER SIGNALS--------------------------------------------------------------------

		----------------------------------------------------------------------------------
		------------------------------------ Constants -----------------------------------
		----------------------------------------------------------------------------------

		----------------------------------------------------------------------------------
		-------------------------------------- Types -------------------------------------
		----------------------------------------------------------------------------------

		type SETUP_REG_TYPE is array(7 downto 0) of std_logic_vector(127 downto 0);
		--------------------------------------------------------------------------------
		------------------------------ Internal Signals --------------------------------
		--------------------------------------------------------------------------------
		--128 bit general purpose setup registers
		signal Channel_Setup_Registers : SETUP_REG_TYPE := (others => x"00000000000000000000000000000000");

		--instruction interpretation signals
		type state_type is (idle, update, write);
		signal state           : state_type := idle;
		signal transaction_cnt : std_logic_vector(2 downto 0) := "000";

		--2MHz Timebase signals
		signal clkdiv : integer range 0 to 49 := 49;
		signal newclk : std_logic := '0';

		--DDS Encoder Signals
		signal DDS_counter : integer range 0 to 7 := 0;
		signal tvalid      : std_logic := '0';
		signal tlast       : std_logic := '0';
		signal tdata       : std_logic_vector(79 downto 0) := (others => '0');

		-- AXI4LITE signals
		signal axi_awaddr  : std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
		signal axi_awready : std_logic;
		signal axi_wready  : std_logic;
		signal axi_bresp   : std_logic_vector(1 downto 0);
		signal axi_bvalid  : std_logic;
		signal axi_araddr  : std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
		signal axi_arready : std_logic;
		signal axi_rdata   : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
		signal axi_rresp   : std_logic_vector(1 downto 0);
		signal axi_rvalid  : std_logic;

		-- Example-specific design signals
		-- local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
		-- ADDR_LSB is used for addressing 32/64 bit registers/memories
		-- ADDR_LSB = 2 for 32 bits (n downto 2)
		-- ADDR_LSB = 3 for 64 bits (n downto 3)
		constant ADDR_LSB          : integer := (C_S_AXI_DATA_WIDTH/32) + 1;
		constant OPT_MEM_ADDR_BITS : integer := 2;

		--CMD Word Signals
		signal CMDWord1     : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --32 bit instruction register
		signal CMDWord2     : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --32 bit target register, where target is a channel 0 to 7
		signal CMDWord3     : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --only used when lower is full, or in 2 part transactions (ie hi/lo update)
		signal CMDWord4     : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --general purpose data reg, no notes at this time (1/12/18)
		signal CMDWord5     : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --general purpose data reg, no notes at this time (1/12/18)

		signal slv_reg_rden : std_logic; --read enable
		signal slv_reg_wren : std_logic; --write enable
		signal reg_data_out : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0); --read port
		signal byte_index   : integer; 
		signal aw_en        : std_logic; --address write enable? seems not very useful

	begin
		-- I/O Connections assignments
		PWM_ARB_TICK      <= newclk;

		DDS_CONFIG_TDATA  <= tdata;
		DDS_CONFIG_TVALID <= tvalid;
		DDS_CONFIG_TLAST  <= tlast;

		S_AXI_AWREADY     <= axi_awready;
		S_AXI_WREADY      <= axi_wready;
		S_AXI_BRESP       <= axi_bresp;
		S_AXI_BVALID      <= axi_bvalid;
		S_AXI_ARREADY     <= axi_arready;
		S_AXI_RDATA       <= axi_rdata;
		S_AXI_RRESP       <= axi_rresp;
		S_AXI_RVALID      <= axi_rvalid;

		-- Implement axi_awready generation
		-- axi_awready is asserted for one S_AXI_ACLK clock cycle when both
		-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
		-- de-asserted when reset is low.
		AXI_AWRDY_GEN : process (S_AXI_ACLK)
		begin
			if rising_edge(S_AXI_ACLK) then
				if S_AXI_ARESETN = '0' then
					axi_awready <= '0';
					aw_en       <= '1';
				else
					if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
						-- slave is ready to accept write address when
						-- there is a valid write address and write data
						-- on the write address and data bus. This design
						-- expects no outstanding transactions.
						axi_awready <= '1';
					elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then
						aw_en       <= '1';
						axi_awready <= '0';
					else
						axi_awready <= '0';
					end if;
				end if;
			end if;
		end process AXI_AWRDY_GEN;

		-- Implement axi_awaddr latching
		-- This process is used to latch the address when both
		-- S_AXI_AWVALID and S_AXI_WVALID are valid.
		AXI_AWADDR_LATCH : process (S_AXI_ACLK)
		begin
			if rising_edge(S_AXI_ACLK) then
				if S_AXI_ARESETN = '0' then
					axi_awaddr <= (others => '0');
				else
					if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
						-- Write Address latching
						axi_awaddr <= S_AXI_AWADDR;
					end if;
				end if;
			end if;
		end process AXI_AWADDR_LATCH;

		-- Implement axi_wready generation
		-- axi_wready is asserted for one S_AXI_ACLK clock cycle when both
		-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is
		-- de-asserted when reset is low.
		AXI_WRDY_GEN : process (S_AXI_ACLK)
		begin
			if rising_edge(S_AXI_ACLK) then
				if S_AXI_ARESETN = '0' then
					axi_wready <= '0';
				else
					if (axi_wready = '0' and S_AXI_WVALID = '1' and S_AXI_AWVALID = '1' and aw_en = '1') then
						-- slave is ready to accept write data when
						-- there is a valid write address and write data
						-- on the write address and data bus. This design
						-- expects no outstanding transactions.
						axi_wready <= '1';
					else
						axi_wready <= '0';
					end if;
				end if;
			end if;
		end process AXI_WRDY_GEN;

		-- Implement memory mapped register select and write logic generation
		-- The write data is accepted and written to memory mapped registers when
		-- axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
		-- select byte enables of slave registers while writing.
		-- These registers are cleared when reset (active low) is applied.
		-- Slave register write enable is asserted when valid address and data are available
		-- and the slave is ready to accept the write address and write data.
		slv_reg_wren <= axi_wready and S_AXI_WVALID and axi_awready and S_AXI_AWVALID;
		AXI_SLV_REG_WRITE : process (S_AXI_ACLK)
			variable loc_addr : std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
		begin
			if rising_edge(S_AXI_ACLK) then
				if S_AXI_ARESETN = '0' then
					CMDWord1 <= (others => '0');
					CMDWord2 <= (others => '0');
					CMDWord3 <= (others => '0');
					CMDWord4 <= (others => '0');
					CMDWord5 <= (others => '0');
				else
					loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
					if (slv_reg_wren = '1') then
						case loc_addr is
							when b"000" => 
								for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8 - 1) loop
									if (S_AXI_WSTRB(byte_index) = '1') then
										-- Respective byte enables are asserted as per write strobes 
										-- slave registor 0
										CMDWord1(byte_index * 8 + 7 downto byte_index * 8) <= S_AXI_WDATA(byte_index * 8 + 7 downto byte_index * 8);
										transaction_cnt                                    <= "000";
									end if;
								end loop;
							when b"001" => 
								for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8 - 1) loop
									if (S_AXI_WSTRB(byte_index) = '1') then
										-- Respective byte enables are asserted as per write strobes 
										-- slave registor 1
										CMDWord2(byte_index * 8 + 7 downto byte_index * 8) <= S_AXI_WDATA(byte_index * 8 + 7 downto byte_index * 8);
										transaction_cnt                                    <= "001";
									end if;
								end loop;
							when b"010" => 
								for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8 - 1) loop
									if (S_AXI_WSTRB(byte_index) = '1') then
										-- Respective byte enables are asserted as per write strobes 
										-- slave registor 2
										CMDWord3(byte_index * 8 + 7 downto byte_index * 8) <= S_AXI_WDATA(byte_index * 8 + 7 downto byte_index * 8);
										transaction_cnt                                    <= "010";
									end if;
								end loop;
							when b"011" => 
								for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8 - 1) loop
									if (S_AXI_WSTRB(byte_index) = '1') then
										-- Respective byte enables are asserted as per write strobes 
										-- slave registor 3
										CMDWord4(byte_index * 8 + 7 downto byte_index * 8) <= S_AXI_WDATA(byte_index * 8 + 7 downto byte_index * 8);
										transaction_cnt                                    <= "011";
									end if;
								end loop;
							when b"100" => 
								for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8 - 1) loop
									if (S_AXI_WSTRB(byte_index) = '1') then
										-- Respective byte enables are asserted as per write strobes 
										-- slave registor 4
										CMDWord5(byte_index * 8 + 7 downto byte_index * 8) <= S_AXI_WDATA(byte_index * 8 + 7 downto byte_index * 8);
										transaction_cnt                                    <= "100";
									end if;
								end loop;
							when others => 
								CMDWord1 <= CMDWord1;
								CMDWord2 <= CMDWord2;
								CMDWord3 <= CMDWord3;
								CMDWord4 <= CMDWord4;
								CMDWord5 <= CMDWord5;
						end case;
					end if;
				end if;
			end if; 
		end process AXI_SLV_REG_WRITE;

		-- Implement write response logic generation
		-- The write response and response valid signals are asserted by the slave
		-- when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.
		-- This marks the acceptance of address and indicates the status of
		-- write transaction.

		AXI_WRITE_RESP_GEN : process (S_AXI_ACLK)
		begin
			if rising_edge(S_AXI_ACLK) then
				if S_AXI_ARESETN = '0' then
					axi_bvalid <= '0';
					axi_bresp  <= "00"; --need to work more on the responses
				else
					if (axi_awready = '1' and S_AXI_AWVALID = '1' and axi_wready = '1' and S_AXI_WVALID = '1' and axi_bvalid = '0') then
						axi_bvalid <= '1';
						axi_bresp  <= "00";
					elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then --check if bready is asserted while bvalid is high)
						axi_bvalid <= '0'; -- (there is a possibility that bready is always asserted high)
					end if;
				end if;
			end if;
		end process AXI_WRITE_RESP_GEN;

		AXI_ARREADY_GEN : process (S_AXI_ACLK)
		begin
			if rising_edge(S_AXI_ACLK) then
				if S_AXI_ARESETN = '0' then
					axi_arready <= '0';
					axi_araddr  <= (others => '1');
				else
					if (axi_arready = '0' and S_AXI_ARVALID = '1') then
						-- indicates that the slave has acceped the valid read address
						axi_arready <= '1';
						-- Read Address latching
						axi_araddr <= S_AXI_ARADDR;
					else
						axi_arready <= '0';
					end if;
				end if;
			end if;
		end process AXI_ARREADY_GEN;

		-- Implement axi_arvalid generation
		-- axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both
		-- S_AXI_ARVALID and axi_arready are asserted. The slave registers
		-- data are available on the axi_rdata bus at this instance. The
		-- assertion of axi_rvalid marks the validity of read data on the
		-- bus and axi_rresp indicates the status of read transaction.axi_rvalid
		-- is deasserted on reset (active low). axi_rresp and axi_rdata are
		-- cleared to zero on reset (active low).
		AXI_ARVALID_GEN : process (S_AXI_ACLK)
		begin
			if rising_edge(S_AXI_ACLK) then
				if S_AXI_ARESETN = '0' then
					axi_rvalid <= '0';
					axi_rresp  <= "00";
				else
					if (axi_arready = '1' and S_AXI_ARVALID = '1' and axi_rvalid = '0') then
						-- Valid read data is available at the read data bus
						axi_rvalid <= '1';
						axi_rresp  <= "00"; -- 'OKAY' response
					elsif (axi_rvalid = '1' and S_AXI_RREADY = '1') then
						-- Read data is accepted by the master
						axi_rvalid <= '0';
					end if;
				end if;
			end if;
		end process AXI_ARVALID_GEN;

		-- Implement memory mapped register select and read logic generation
		-- Slave register read enable is asserted when valid address is available
		-- and the slave is ready to accept the read address.
		slv_reg_rden <= axi_arready and S_AXI_ARVALID and (not axi_rvalid);

		AXI_SLV_REG_READ  : process (CMDWord1, CMDWord2, CMDWord3, CMDWord4, CMDWord5, axi_araddr, S_AXI_ARESETN, slv_reg_rden)
			variable loc_addr : std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
		begin
			-- Address decoding for reading registers
			loc_addr := axi_araddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
			case loc_addr is
				when b"000" => 
					reg_data_out <= CMDWord1;
				when b"001" => 
					reg_data_out <= CMDWord2;
				when b"010" => 
					reg_data_out <= CMDWord3;
				when b"011" => 
					reg_data_out <= CMDWord4;
				when b"100" => 
					reg_data_out <= CMDWord5;
				when others => 
					reg_data_out <= (others => '0');
			end case;
		end process AXI_SLV_REG_READ;

		-- Output register or memory read data
		AXI_SLV_REG_READ_OUTPUT : process (S_AXI_ACLK) is
		begin
			if (rising_edge (S_AXI_ACLK)) then
				if (S_AXI_ARESETN = '0') then
					axi_rdata <= (others => '0');
				else
					if (slv_reg_rden = '1') then
						-- When there is a valid read address (S_AXI_ARVALID) with
						-- acceptance of read address by the slave (axi_arready),
						-- output the read dada
						-- Read address mux
						axi_rdata <= reg_data_out; -- register read data
					end if;
				end if;
			end if;
		end process AXI_SLV_REG_READ_OUTPUT;
		RESYNC_GEN : process (S_AXI_ACLK, S_AXI_ARESETN)
		begin
			if rising_edge (S_AXI_ACLK) then
				if S_AXI_ARESETN = '0' then
					RESYNC <= '0';
				else
					RESYNC <= '1';
				end if;
			end if;
		end process RESYNC_GEN;
		--------------------------------------------------------------------------------
		--------------------------------- USER LOGIC -----------------------------------
		--------------------------------------------------------------------------------
		-- Implement interpretation of instructions and actions
		INSTRUCTION_INTERPRET   : process (S_AXI_ACLK, S_AXI_ARESETN)
			variable target_channel : integer range 0 to 7 := to_integer(unsigned(CMDWord1(27 downto 24)));
		begin
			if rising_edge(S_AXI_ACLK) then
				if S_AXI_ARESETN = '0' then
				elsif (CMDWord1(31 downto 28) = x"0" and transaction_cnt = "100") then --If Transaction type is update, and all cmd words have been written, then...
					case(CMDWord1(23 downto 20)) is
						when x"0" => --Turn off the channel, temporary
							Channel_Setup_Registers(to_integer(unsigned(CMDWord1(27 downto 24)))) <= x"00000000000000000000000000000000"; 
						when x"1" => --when sinusoid wave
							Channel_Setup_Registers(to_integer(unsigned(CMDWord1(27 downto 24)))) <= CMDWord1(23 downto 20) --Mode
								 & CMDWord2(31 downto 20) --Gain
								 & CMDWord2(11 downto 0) --reserved for V Offset
								 & x"00000" --unused 
								 & CMDWord3(15 downto 0) --POFF/PINC
								 & CMDWord4(31 downto 0) --POFF/PINC
								 & CMDWord5(31 downto 0); --POFF/PINC
						when x"2" => --when pulse train
							Channel_Setup_Registers(to_integer(unsigned(CMDWord1(27 downto 24)))) <= CMDWord1(23 downto 20) --Mode
								 & x"000000000000001" --unused
								 & CMDWord2(31 downto 20) --VHi
								 & CMDWord2(19 downto 8) --VLo
								 & CMDWord3(19 downto 0) --THi
								 & CMDWord4(19 downto 0); --TLo
						when x"8" => --when arb 1
							Channel_Setup_Registers(to_integer(unsigned(CMDWord1(27 downto 24)))) <= CMDWord1(23 downto 20) --Mode
								 & x"00000000000000000000000" --unused
								 & CMDWord2(31) --Loop Flag
								 & CMDWord2(30 downto 20) --Loop Count
								 & CMDWord2(19 downto 0); --Sample Delta T (TIme increment)
						when x"9" => --when arb 2
							Channel_Setup_Registers(to_integer(unsigned(CMDWord1(27 downto 24)))) <= CMDWord1(23 downto 20) --Mode
								 & x"00000000000000000000000" --unused
								 & CMDWord2(31) --Loop Flag
								 & CMDWord2(30 downto 20) --Loop Count
								 & CMDWord2(19 downto 0); --Sample Delta T (TIme increment)
								--The Code below is very inefficent, I need to find a way to reduce it if possible.
						when x"A" | x"B" | x"C" | x"D" | x"E" | x"F" => --when ARB
							Channel_Setup_Registers(to_integer(unsigned(CMDWord1(27 downto 24)))) <= CMDWord1(23 downto 20) --Mode
								 & CMDWord2(31) --Loop Flag
								 & x"00000000000000000000000" --unused
								 & CMDWord2(30 downto 20) --Loop Count
								 & CMDWord2(19 downto 0); --Sample Delta T (TIme increment)
						when others => 
							Channel_Setup_Registers(to_integer(unsigned(CMDWord1(27 downto 24)))) <= x"22222222222222222222222222222222"; --debug flag, should never reach this
							--TODO: ADD Hardware exception here? 2/3/18
					end case;
 
					--elsif(CMDWord1(31 downto 28) = x"1" and axi_araddr = x"3" and transaction_cnt = "00") then 
					-- WRITE_ARB <= '0';
 
				end if;
			end if;
		end process INSTRUCTION_INTERPRET;

		DDS_ENCODER : process (S_AXI_ACLK, S_AXI_ARESETN)
		begin
			if rising_edge(S_AXI_ACLK) then
				if S_AXI_ARESETN = '0' then
					DDS_Counter <= 0;
					tvalid      <= '0';
				elsif (DDS_counter = 7) then
					tlast       <= '1';
					DDS_counter <= 0;
					case(Channel_Setup_Registers(DDS_Counter)(127 downto 124)) is
						when x"1" => 
							tdata  <= Channel_Setup_Registers(DDS_Counter)(79 downto 0);
							tvalid <= '1';
						when others => 
							tvalid <= '0';
					end case;
 
				else
					tlast       <= '0';
					DDS_counter <= DDS_counter + 1; 
					case(Channel_Setup_Registers(DDS_Counter)(127 downto 124)) is
						when x"1" => 
							tdata  <= Channel_Setup_Registers(DDS_Counter)(79 downto 0);
							tvalid <= '1';
						when others => 
							tvalid <= '0';
					end case;
				end if;
			end if;
		end process DDS_ENCODER;

		ARB_PWM_DATA_OUT : process (S_AXI_ACLK, S_AXI_ARESETN)
		begin
			if rising_edge(S_AXI_ACLK) then
				if S_AXI_ARESETN = '0' then
				else
					PWM_ARB_0 <= Channel_Setup_Registers(0)(64 downto 0);
					PWM_ARB_1 <= Channel_Setup_Registers(1)(64 downto 0);
					PWM_ARB_2 <= Channel_Setup_Registers(2)(64 downto 0);
					PWM_ARB_3 <= Channel_Setup_Registers(3)(64 downto 0);
					PWM_ARB_4 <= Channel_Setup_Registers(4)(64 downto 0);
					PWM_ARB_5 <= Channel_Setup_Registers(5)(64 downto 0);
					PWM_ARB_6 <= Channel_Setup_Registers(6)(64 downto 0);
					PWM_ARB_7 <= Channel_Setup_Registers(7)(64 downto 0);
				end if;
			end if;
		end process ARB_PWM_DATA_OUT;

		ARB_PWM_TIMEBASE_GENERATOR : process (S_AXI_ACLK, S_AXI_ARESETN) --Generates the 2MHz clock used by PWM and ARB module.
		begin
			if rising_edge(S_AXI_ACLK) then
				if (S_AXI_ARESETN = '0') then
					clkdiv <= 49;
					newclk <= '0';
				elsif (clkdiv = 1) then
					newclk <= '1';
					clkdiv <= clkdiv - 1;
				elsif (clkdiv = 0) then
					newclk <= '0';
					clkdiv <= 49;
				else
					clkdiv <= clkdiv - 1;
				end if;
			end if;
		end process ARB_PWM_TIMEBASE_GENERATOR;

		VAR_LATCH : process (S_AXI_ACLK, S_AXI_ARESETN)
		begin
			if rising_edge(S_AXI_ACLK) then
				CHAN_MODE_VECTOR <= Channel_Setup_Registers(0)(127 downto 124)
					 & Channel_Setup_Registers(1)(127 downto 124)
					 & Channel_Setup_Registers(2)(127 downto 124)
					 & Channel_Setup_Registers(3)(127 downto 124)
					 & Channel_Setup_Registers(4)(127 downto 124)
					 & Channel_Setup_Registers(5)(127 downto 124)
					 & Channel_Setup_Registers(6)(127 downto 124)
					 & Channel_Setup_Registers(7)(127 downto 124);
 
				GAIN_VECTOR <= Channel_Setup_Registers(0)(123 downto 112)
					 & Channel_Setup_Registers(1)(123 downto 112)
					 & Channel_Setup_Registers(2)(123 downto 112)
					 & Channel_Setup_Registers(3)(123 downto 112)
					 & Channel_Setup_Registers(4)(123 downto 112)
					 & Channel_Setup_Registers(5)(123 downto 112)
					 & Channel_Setup_Registers(6)(123 downto 112)
					 & Channel_Setup_Registers(7)(123 downto 112);
 
				OFFSET_VECTOR <= Channel_Setup_Registers(0)(111 downto 100)
					 & Channel_Setup_Registers(1)(111 downto 100)
					 & Channel_Setup_Registers(2)(111 downto 100)
					 & Channel_Setup_Registers(3)(111 downto 100)
					 & Channel_Setup_Registers(4)(111 downto 100)
					 & Channel_Setup_Registers(5)(111 downto 100)
					 & Channel_Setup_Registers(6)(111 downto 100)
					 & Channel_Setup_Registers(7)(111 downto 100);
			end if;
		end process VAR_LATCH; 

		--------------------------------------------------------------------------------
		--------------------------------- Components -----------------------------------
		--------------------------------------------------------------------------------

		--------------------------------------------------------------------------------
		-------------------------- Component Instantiation -----------------------------
		--------------------------------------------------------------------------------

		--------------------------------------------------------------------------------
		-------------------------- Register Elements -----------------------------------
		--------------------------------------------------------------------------------
end arch_imp;