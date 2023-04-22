library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity A_REGISTER is
    Port (--inouts
          A_inout_bus : inout STD_LOGIC_VECTOR (7 downto 0);
          A_value : out std_logic_vector (7 downto 0);
          --control signals
          AI : in STD_LOGIC;
          AO : in STD_LOGIC;
          CLK: in STD_LOGIC;
          RST : in STD_LOGIC);
end A_REGISTER;


architecture Behavioral of A_REGISTER is
signal A_reg_value: std_logic_vector(7 downto 0):= (others => '0');
begin

process(CLK, RST)is
begin
  if (rst = '1') then
    A_reg_value <= (others => '0'); -- if reset Areg = 0
  elsif (rising_edge(CLK)) then --if reset 0 input enabled, update Areg
    if (AI = '1') then
      A_reg_value <= A_inout_bus;
    end if;
  end if;
  A_value <= A_reg_value;
end process;

process (AO) is
begin
  if (AO = '1') then
    A_inout_bus <= A_reg_value;
  else 
    A_inout_bus <= (others => 'Z');
  end if;
end process;

end Behavioral;
