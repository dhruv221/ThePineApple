library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity FLAGS_REGISTER is
  Port( N : in STD_LOGIC;
        C : in STD_LOGIC;
        Z : in STD_LOGIC;
        FLAGS : out STD_LOGIC_VECTOR(2 DOWNTO 0);
       --Control Signals
        FI : in STD_LOGIC;
        CLK : in STD_LOGIC);
end FLAGS_REGISTER;

    
architecture Behavioral of FLAGS_REGISTER is
begin
  
process(CLK, FI)
begin
  if (rising_edge(CLK) and FI = '1') then
    FLAGS(0) <= Z;
    FLAGS(1) <= C;
    FLAGS(2) <= N;
  end if;
end process;

end Behavioral;
