library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;


entity PROGRAM_COUNTER is
    port(--inouts
         PC_inout_bus : inout std_logic_vector(7 downto 0);
         carryout : out std_logic;
         --control signals
         C_INC : in std_logic;
         CI : in std_logic;
         CO : in std_logic;
         CLK : in std_logic;
         RST : in std_logic);
end entity;



architecture Behavioral of PROGRAM_COUNTER is
signal PC_value : std_logic_vector (7 downto 0);
begin

process(CLK, RST, C_INC, CI, CO)
begin
    if (C_INC = '1' and rising_edge(CLK)) then
    PC_value <= PC_value + "0001";
    end if;
    
    if (CI = '1' and rising_edge(CLK)) then
    PC_value <= PC_inout_bus;
    end if;
    
    if (CO = '1') then
    PC_inout_bus <= PC_value(7 downto 0);
    else
    PC_inout_bus <= (others => 'Z');
    end if;
    
    if (PC_value = "11111111") then
    carryout <= '1';
    else
    carryout <= '0';
    end if;
    
    if (RST = '1') then
    PC_value <= "00000000";
    end if;
end process;

end Behavioral;
