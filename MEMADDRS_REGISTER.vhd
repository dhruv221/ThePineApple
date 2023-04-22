library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;


entity MEMADDR_REGISTER is
    port (--inouts
          MAR_in_bus : in std_logic_vector(7 downto 0);
          MAR_out : out std_logic_vector(7 downto 0);
          --control signal
          MARI : in std_logic;
          CLK : in std_logic);
end entity;

architecture Behavioral of MEMADDR_REGISTER is
signal MAR_value : std_logic_vector(7 downto 0);
begin

process(CLK, MARI) is
begin
    if (MARI = '1' and rising_edge(CLK)) then
        MAR_value <= MAR_in_bus;
    else
        MAR_value <= MAR_value;
    end if;
    MAR_out <= MAR_value;
end process;

end Behavioral;
