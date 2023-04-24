library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity RAM is
    port(--inouts
         RAM_addrs : in std_logic_vector(15 downto 0);
         RAM_in_bus : in std_logic_vector(7 downto 0);
         RAM_out_bus : out std_logic_vector(7 downto 0);
         --control signals
         RI : in std_logic;
         RO : in std_logic;
         CLK : in std_logic);
end entity;
  
architecture Behavioral of RAM  is
type RAM_array is array (0 to 65535) of std_logic_vector(7 downto 0);
signal RAM_data : RAM_array;

begin
process(CLK)
begin
  if (rising_edge(CLK)) then
   
    if (RI = '1') then
        RAM_data(to_integer(unsigned(RAM_addrs))) <= RAM_in_bus;
    end if;
    
  end if;
      
end process;
  
process(RO)
begin
    
if (RO = '1') then
    RAM_out_bus <= RAM_data(to_integer(unsigned(RAM_addrs)));
else
     RAM_out_bus <= (others => 'Z');
end if;
    
end process;


end Behavioral;
