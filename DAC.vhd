--------------------------------------------------------------------------------
-- Company:        AstroNova, Inc.
-- Engineer:       
-- Create Date:    
-- Design Name:    
-- Module Name:    AD5443_Proc - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description:    This module serializes data to an output DAC.
--
-- Dependencies:   None.
-- 
-- Revisions:      00-00-2017 XXX Intial version from previous project.
--
-- Additional Comments:
--
--                 Signal/variable and coding conventions:
--                     - Signals can be upper case or mixed case.  Variables should be mixed case.
--                     - Make constants and generics all capitals.
--                     - Use spaces instead of tabs.
--                     - Tab stops in this module set to 3.
--                 VHDL Source Analysis Standard used is VHDL-93
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
---------------------------------- Libraries -----------------------------------
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
library UNISIM;
use UNISIM.VComponents.all;

--------------------------------------------------------------------------------
----------------------------- Entity Declaration -------------------------------
--------------------------------------------------------------------------------
entity AD5443_Proc is
   Generic ( DAC_DATA_WIDTH : positive := 12  );  -- This is how many actual valid data bits the DAC has.
   Port ( signal MAIN_CLOCK : in std_logic;              --       * * *  AD5443_Proc - port map  * * *
          signal DAC_CS_N   : out std_logic := '1';
          signal DAC_SCLK   : out std_logic := '0';
          signal DAC_DAT    : out std_logic := '0';
          signal DAC_ENABLE  : in std_logic := '0';
          signal NEW_DAC_VALUE      : in std_logic_vector((DAC_DATA_WIDTH-1) downto 0) := X"000" ); -- New DAC value.
end AD5443_Proc;


--------------------------------------------------------------------------------
-------------------------- Architecture Description ----------------------------
--------------------------------------------------------------------------------
architecture Behavioral of AD5443_Proc is


--------------------------------------------------------------------------------
---------------------------------- Constants -----------------------------------
--------------------------------------------------------------------------------


----------------------------
------ Misc Constants ------
----------------------------
-- DAC and shift register control constants.
constant DAC_COMMAND_WIDTH  : positive := 4;  -- This is how many bits wide the value is.
constant DAC_SHIFT_WIDTH    : positive := 16; -- This is the number of bits shifted to the AD5443 DAC.

-- Analog Devices AD5443 DAC command codes:
constant LOAD_AND_UPDATE_DAC_CMD : std_logic_vector((DAC_COMMAND_WIDTH-1) downto 0) := X"1";


--------------------------------------------------------------------------------
------------------------------------ Types -------------------------------------
--------------------------------------------------------------------------------
type DAC_Write_States is ( IDLE,
                           DAC_WRITE_STATE_1,
                           DAC_WRITE_STATE_2B,
                           DAC_WRITE_STATE_3B   );


--------------------------------------------------------------------------------
------------------------------ Internal Signals --------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
--------------------------------- Components -----------------------------------
--------------------------------------------------------------------------------


begin

--------------------------------------------------------------------------------
--------------------------------- Component Instantiation ----------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-------------------------- Misc Asynchronous Elements --------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------
--------------------- Write User DAC Data --------------------------
--------------------------------------------------------------------
-- Purpose:   This process writes parallel data to a user DAC.
--
-- Execution: This process contains synchronous elements.
--
-- Operation: This process allows the host to do a parallel write to a
--            user DAC.  This VHDL code then handles all timing and
--            operations to convert the parallel data to a serial data stream.
--
-- Input IOB Signals:       MAIN_CLOCK
--
-- Input Internal Signals:  NEW_DAC_DATA_FLAG, NEW_DAC_VALUE
--
-- Output IOB Signals:      DAC_CS_N, DAC_SCLK, DAC_DAT 
--
-- Output Internal Signals: None
--
-- Initialization:          Set DAC_Write_State to IDLE.
--                          Set DAC_Counter to 0.
--                          Set DAC_Value to X"1000".
--                          Set DAC_Counter to 0.
--                          Set DAC_Value to X"0000".
--
Write_DAC_Data: process (MAIN_CLOCK)
variable DAC_Write_State    : DAC_Write_States := IDLE;
variable DAC_Counter   : INTEGER range 0 to DAC_SHIFT_WIDTH := 0;
variable DAC_Value     : std_logic_vector((DAC_SHIFT_WIDTH-1) downto 0) := X"1000";
begin
   if rising_edge(MAIN_CLOCK) then
      case DAC_Write_State is
         when IDLE =>  -- IDLE state means that DAC data write processing is not in progress.
            -- See if the host has written new DAC data:
            if (DAC_ENABLE = '1') then
               DAC_Value := LOAD_AND_UPDATE_DAC_CMD & NEW_DAC_VALUE;

               -- Load the counter with the number of bits to serialize.
               DAC_Counter := DAC_SHIFT_WIDTH; 

               -- Set DAC clock signal high before starting the serial transfer.
               -- The DAC default is for the falling clock edge to be the active edge.
               DAC_SCLK <= '1';

               -- Assert DAC ~SYNC signal. 
               DAC_CS_N <= '0';

               DAC_Write_State := DAC_WRITE_STATE_1;
            end if; -- End of "if ( NEW_DAC_DATA_FLAG = '1' ) then..."

         when DAC_WRITE_STATE_1 =>        -- * * *  T O P   O F   L O O P  * * *
            DAC_SCLK  <= '1';
            DAC_DAT <= DAC_Value(DAC_SHIFT_WIDTH-1); -- Write out the next DAC serial data bit.
            DAC_Write_State := DAC_WRITE_STATE_2B;

         when DAC_WRITE_STATE_2B =>
            DAC_SCLK <= '0';              -- Clock the serial data bit in on the falling edge of the clock.

            -- Decrement the conversion counter since we just wrote another serial bit to the DAC.
            DAC_Counter := DAC_Counter - 1;

            if ( DAC_Counter = 0 ) then
               DAC_Write_State := DAC_WRITE_STATE_3B;
            else
               -- Shift the parallel data up (left) by one.  This places the next serial data bit on the MSB.
               DAC_Value((DAC_SHIFT_WIDTH-1) downto 1) := DAC_Value((DAC_SHIFT_WIDTH-2) downto 0);
               DAC_Write_State := DAC_WRITE_STATE_1;
            end if; -- End of "if ( DAC_Counter = 0 ) then..."

         when DAC_WRITE_STATE_3B =>
            DAC_SCLK  <= '1';
            DAC_CS_N <= '1';              -- De-assert DAC ~SYNC signal.
            DAC_Write_State := IDLE;

         --when others =>                 -- Commented out since not needed.
         --   DAC_CS_N <= '1';            -- De-assert DAC ~SYNC signal.
         --   DAC_Write_State := IDLE;    -- Set the DAC data write processing state machine to the IDLE state.

      end case; -- End of "case DAC_Write_State is"
   end if;  -- End of "if rising_edge(MAIN_CLOCK) then"
end process Write_DAC_Data;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end Behavioral;
