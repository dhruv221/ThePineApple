library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;


entity PROGRAM_COUNTER is
    port(--inouts
         PC_in_bus : in std_logic_vector(7 downto 0);
         PC_out_bus : out std_logic_vector(7 downto 0);
         carryout : out std_logic;
         --control signals
         CE : in std_logic;
         CI : in std_logic;
         CO : in std_logic;
         CLK : in std_logic;
         RST : in std_logic);
end entity;



architecture Behavioral of PROGRAM_COUNTER is
signal PC_value : std_logic_vector(7 downto 0);

begin
process(CLK, RST)
begin

if (RST = '1') then
    PC_value <= "00000000";
else
    if(rising_edge(CLK)) then
        if (CE = '1' and CI = '0') then
            PC_value <= PC_value + "00000001";
        elsif (CI = '1' and CE = '0') then
            PC_value <= PC_in_bus;        
          else
            PC_value <= PC_value;          
        end if;
    end if;
end if;

if (PC_value = "11111111") then
    carryout <= '1';
else
    carryout <= '0';
end if;

end process;

process(CO)
begin

if (CO = '1') then
    PC_out_bus <= PC_value(7 downto 0);
else
    PC_out_bus <= (others => 'Z');
end if;

end process;

end Behavioral;
