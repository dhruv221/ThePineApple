library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ALU is
  Port (A_in: in std_logic_vector (7 downto 0);
        B_in: in std_logic_vector (7 downto 0);
        RESULT: out std_logic_vector(7 downto 0);
        CARRY: out std_logic;
        SO: in std_logic;
        DO: in std_logic);
end ALU;

architecture Behavioral of ALU is

begin


end Behavioral;
