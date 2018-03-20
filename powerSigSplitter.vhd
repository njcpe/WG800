----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/04/2018 02:24:21 PM
-- Design Name: 
-- Module Name: powerSigSplitter - spiltter
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity powerSigSplitter is
    Port( 
            clock :         in std_logic;
            
            gpio_in :       in std_logic_vector(3 downto 0);
            bat_low :       in std_logic;
            dc_in_ok :      in std_logic;
            sw_on :         in std_logic;
            
            gpio_out :      out std_logic_vector(2 downto 0);
            fpga_led :      out std_logic;
            inhib_12v :     out std_logic;
            pwrhold :       out std_logic;
            ref_en_n :      out std_logic  
        );
end powerSigSplitter;

architecture spiltter_debouncer of powerSigSplitter is

        signal inputs:      std_logic_vector(2 downto 0) := bat_low & dc_in_ok & sw_on;
        
begin
        fpga_led <=         gpio_in(3);
        inhib_12v <=        gpio_in(2);
        pwrhold <=          gpio_in(1);
        ref_en_n <=         gpio_in(0);
        
debounce : process(clock)
begin

    if rising_edge(clock)then
        gpio_out <=         inputs;
    end if;
    
end process debounce;

end spiltter_debouncer;
