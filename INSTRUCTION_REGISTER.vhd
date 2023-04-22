library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;


entity INSTRUCTION_REGISTER is
  Port(--inouts 
       IR_out : out STD_LOGIC_VECTOR(7 downto 0);
       IR_in : in STD_LOGIC_VECTOR(7 downto 0);
       --Control Signals
       II : in STD_LOGIC; 
       CLK : in STD_LOGIC);    
end INSTRUCTION_REGISTER;

    
architecture Behavioral of INSTRUCTION_REGISTER is
begin
  
process(CLK, II)
begin
    if (rising_edge(CLK) and II = '1') then
        IR_out <= IR_in;
    end if;
end process;

end Behavioral;
