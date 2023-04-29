library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;


entity CONTROL_UNIT is
  Port (ADDRESS : in std_logic_vector(14 downto 0);
        CONTROL : out std_logic_vector(17 downto 0));
end CONTROL_UNIT;

architecture Behavioral of CONTROL_UNIT is

begin

process(ADDRESS)
begin

if (ADDRESS(3 downto 0) = "0000") then
CONTROL <= (9 => '1', 10 => '1', others => '0'); -- CO MI 

elsif(ADDRESS(3 downto 0) = "0001") then
CONTROL <= (9 => '1', 10 => '1', 6 => '1', others => '0'); --CO MI HL

elsif(ADDRESS(3 downto 0) = "0010") then
CONTROL <= (14 => '1', 12 => '1', 7 => '1', others => '0'); -- RO II CE

--LDA imm
elsif(ADDRESS(11 downto 0) = "000000010011") then 
    CONTROL <= (9 => '1', 10 => '1', others => '0'); -- CO MI 
elsif(ADDRESS(11 downto 0) = "000000010100") then
    CONTROL <= (9 => '1', 10 => '1', 6 => '1', others => '0'); --CO MI HL
elsif(ADDRESS(11 downto 0) = "000000010101") then
    CONTROL <= (14 => '1', 2 => '1', 7 => '1', others => '0'); --RO AI CE
elsif(ADDRESS(11 downto 0) = "000000010110") then
    CONTROL <= (16 => '1', others => '0'); --SCR

--LDB imm
elsif(ADDRESS(11 downto 0) = "000000100011") then 
    CONTROL <= (9 => '1', 10 => '1', others => '0'); -- CO MI 
elsif(ADDRESS(11 downto 0) = "000000100100") then
    CONTROL <= (9 => '1', 10 => '1', 6 => '1', others => '0'); --CO MI HL
elsif(ADDRESS(11 downto 0) = "000000100101") then
    CONTROL <= (14 => '1', 4 => '1', 7 => '1', others => '0'); --RO BI CE
elsif(ADDRESS(11 downto 0) = "000000100110") then
    CONTROL <= (16 => '1', others => '0'); --SCR

--ADD
elsif(ADDRESS(11 downto 0) = "000000110011") then 
    CONTROL <= (1 => '1', 2 => '1', others => '0'); -- ALUO AI
elsif(ADDRESS(11 downto 0) = "000000110100") then 
    CONTROL <= (16 => '1', others => '0'); --SCR
    
--OUT
elsif(ADDRESS(11 downto 0) = "000001000011") then 
    CONTROL <= (3 => '1', 15 => '1', others => '0'); -- AO OI
elsif(ADDRESS(11 downto 0) = "000001000100") then 
    CONTROL <= (16 => '1', others => '0'); --SCR

else
CONTROL <= "000000000000000000";

end if;

end process;

end Behavioral;
