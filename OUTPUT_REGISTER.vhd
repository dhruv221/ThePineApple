library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity OUTPUT_REGISTER is
    port (--inouts
          OUTREG_in : in std_logic_vector(7 downto 0);
          OUTREG_out : out std_logic_vector(7 downto 0);
          --control signals
          OI : in std_logic;
          CLK : in std_logic);
end entity;


architecture Behavioral of OUTPUT_REGISTER is
signal OUTREG_value : std_logic_vector(7 downto 0);
begin 
process(CLK, OI) is
begin
    if (OI = '1' and rising_edge(CLK)) then
        OUTREG_value <= OUTREG_in;
    else
        OUTREG_value <= OUTREG_value;
    end if;
    OUTREG_out <= OUTREG_value;
end process;
end Behavioral;          
