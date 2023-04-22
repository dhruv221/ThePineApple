library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;


entity STEP_COUNTER is
    port(--inouts
         step_count : out std_logic_vector(3 downto 0);
         --control signals 
         SCR : in std_logic;
         CLK : in std_logic);
end entity;


architecture Behavioral of STEP_COUNTER is
signal step_counter_value : std_logic_vector(3 downto 0);
begin

process(CLK, SCR) is
begin
    if(rising_edge(CLK)) then
        step_counter_value <= step_counter_value + "0001";
    else
        step_counter_value <= step_counter_value;
    end if;
    if (SCR = '1') then
        step_counter_value <= "0000";
    end if;
    step_count <= step_counter_value;
end process;


end Behavioral;
