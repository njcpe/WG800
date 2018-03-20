----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 01/02/2018 06:35:42 PM
-- Design Name:
-- Module Name: switchInput - translation
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

entity switchDebounce is
    Port ( 
        clock :           in std_logic;  
        sw1_in :        in std_logic;  
        sw2_in :        in std_logic;  
        sw3_in :        in std_logic;  
        sw4_in :        in std_logic;  
        sw5_in :        in std_logic;  
        sw6_in :        in std_logic;  
--        home :          out std_logic; 
--        slct :          out std_logic; 
--        incr_freq :     out std_logic; 
--        decr_freq :     out std_logic; 
--        up :            out std_logic; 
--        down :          out std_logic
        
        SW_out :      out std_logic_vector(5 downto 0)
        );
end switchDebounce;

architecture translation of switchDebounce is
        signal inputs : std_logic_vector(5 downto 0) := (sw6_in & sw5_in & sw4_in & sw3_in & sw2_in & sw1_in);
        signal outputs : std_logic_vector(5 downto 0) := "000000";
begin
--        home <=         outputs(5);
--        slct <=         outputs(4);
--        incr_freq <=    outputs(3);
--        decr_freq <=    outputs(2);
--        up <=           outputs(1);
--        down <=         outputs(0);
        SW_out <= outputs;
           
debounce : process(clock)
begin
    if(rising_edge(clock)) then
        outputs <= inputs;
    end if;    
end process debounce;

end translation;
