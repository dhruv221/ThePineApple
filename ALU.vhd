library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;



entity ALU is
  Port (--inouts
        ALU_out_bus: out std_logic_vector(7 downto 0);
        A: in std_logic_vector (7 downto 0);
        B: in std_logic_vector (7 downto 0);
        N: out std_logic;
        C: out std_logic;
        Z: out std_logic;
        --control signals:
        SorD: in std_logic;
        ALU_O: in std_logic);
end ALU;




architecture Behavioral of ALU is
signal ALU_value : std_logic_vector(7 downto 0);
signal carry : std_logic;
signal negetive : std_logic;
begin

process(A, B, SorD) is
    variable a_dash : unsigned(8 downto 0) := unsigned('0' & A);
    variable b_dash : unsigned(8 downto 0) := unsigned('0' & B);
    variable temp : unsigned(8 downto 0);
    begin
    temp := a_dash + b_dash;
    if (SorD = '0') then
        ALU_value <= std_logic_vector(temp(7 downto 0));
        --ALU_out_bus <= ALU_value;
    elsif (SorD = '1') then
        ALU_value <= A - B;
    end if;
    C <= std_logic(temp(8));
    N <= ALU_value(7);
    if (ALU_value = "00000000") then
        Z <= '1';
    else
        Z <= '0';
    end if;
end process;  

process(ALU_O) is
begin
    if (ALU_O = '1') then
        ALU_out_bus <= ALU_value;
    else 
        ALU_out_bus <= "ZZZZZZZZ";
    end if;
end process;

end Behavioral;
