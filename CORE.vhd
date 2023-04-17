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
           A_value : out std_logic_vector (7 downto 0);
           CLK: in STD_LOGIC;
           RST : in STD_LOGIC);
end component;

component B_REGISTER is
    Port ( BI : in STD_LOGIC;
           BO : in STD_LOGIC;
           --end of control signals
           B_inout_bus : inout STD_LOGIC_VECTOR (7 downto 0);
           B_value : out std_logic_vector (7 downto 0);
           CLK: in STD_LOGIC;
           RST : in STD_LOGIC);
end component;

component ALU is
    Port (A: in std_logic_vector (7 downto 0);
          B: in std_logic_vector (7 downto 0);
          ALU_out_bus: out std_logic_vector(7 downto 0);
          N: out std_logic;
          C: out std_logic;
          Z: out std_logic;
          --control signals:
          SorD: in std_logic;
          ALU_O: in std_logic);
end component;

signal A_IN, A_OUT, B_IN, B_OUT, SorD, ALU_O : std_logic;
signal A, B : std_logic_vector(7 downto 0);
begin
A_REG: A_REGISTER port map (A_inout_bus => DATA_BUS, 
                            CLK => CLK,
                            RST => RST,
                            AI => A_IN,
                            AO => A_OUT,
                            A_value => A);
                            
B_REG: B_REGISTER port map (B_inout_bus => DATA_BUS, 
                            CLK => CLK,
                            RST => RST,
                            BI => B_IN,
                            BO => B_OUT,
                            B_value => B);
                            
ALU_M : ALU port map (A => A,
                    B => B,
                    ALU_out_bus => DATA_BUS,
                    SorD => SorD,
                    ALU_O => ALU_O);                          

end Behavioral;
