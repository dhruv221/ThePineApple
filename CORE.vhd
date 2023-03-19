library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CORE is
    Port ( DATA_BUS : inout STD_LOGIC_VECTOR (7 downto 0);
    RST : in std_logic;
    CLK : in std_logic);
    
end CORE;

architecture Behavioral of CORE is

component A_REGISTER is
    Port ( AI : in STD_LOGIC;
           AO : in STD_LOGIC;
           --end of control signals
           A_inout_bus : inout STD_LOGIC_VECTOR (7 downto 0);
           CLK: in STD_LOGIC;
           RST : in STD_LOGIC);
end component;

component B_REGISTER is
    Port ( BI : in STD_LOGIC;
           BO : in STD_LOGIC;
           --end of control signals
           B_inout_bus : inout STD_LOGIC_VECTOR (7 downto 0);
           CLK: in STD_LOGIC;
           RST : in STD_LOGIC);
end component;
signal A_IN, A_OUT, B_IN, B_OUT : std_logic;
begin
A_REG: A_REGISTER port map (A_inout_bus => DATA_BUS, 
                            CLK => CLK,
                            RST => RST,
                            AI => A_IN,
                            AO => A_OUT);
                            
B_REG: B_REGISTER port map (B_inout_bus => DATA_BUS, 
                            CLK => CLK,
                            RST => RST,
                            BI => B_IN,
                            BO => B_OUT);

end Behavioral;
