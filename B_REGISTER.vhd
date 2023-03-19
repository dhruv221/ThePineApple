library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity B_REGISTER is
    Port ( BI : in STD_LOGIC;
           BO : in STD_LOGIC;
           --end of control signals
           B_inout_bus : inout STD_LOGIC_VECTOR (7 downto 0);
           CLK: in STD_LOGIC;
           RST : in STD_LOGIC);
end B_REGISTER;


architecture Behavioral of B_REGISTER is
signal B_reg_value: std_logic_vector(7 downto 0);
begin

process(CLK, RST)is
begin
  if (rst = '1') then
    B_reg_value <= (others => '0');
  elsif (rising_edge(CLK)) then
    if (BI = '1') then
      B_reg_value <= B_inout_bus;
    end if;
  end if;
end process;

process (BO) is
begin
  if (BO = '1') then
    B_inout_bus <= B_reg_value;
  else 
    B_inout_bus <= (others => 'Z');
  end if;
end process;

end Behavioral;
