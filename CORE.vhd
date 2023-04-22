library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CORE is
    Port ( DATA_BUS : inout STD_LOGIC_VECTOR (7 downto 0);
    RST : in std_logic;
    CLK : in std_logic);
    
end CORE;








architecture Behavioral of CORE is
-- A register
component A_REGISTER is
    Port ( AI : in STD_LOGIC;
           AO : in STD_LOGIC;
           --end of control signals
           A_inout_bus : inout STD_LOGIC_VECTOR (7 downto 0);
           A_value : out std_logic_vector (7 downto 0);
           CLK: in STD_LOGIC;
           RST : in STD_LOGIC);
end component;
-- B register
component B_REGISTER is
    Port ( BI : in STD_LOGIC;
           BO : in STD_LOGIC;
           --end of control signals
           B_inout_bus : inout STD_LOGIC_VECTOR (7 downto 0);
           B_value : out std_logic_vector (7 downto 0);
           CLK: in STD_LOGIC;
           RST : in STD_LOGIC);
end component;
-- ALU
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
-- FLAGS register
component FLAGS_REGISTER is 
    Port(--inouts 
         FLAGS : out STD_LOGIC_VECTOR(2 DOWNTO 0);
         N : in STD_LOGIC;
         C : in STD_LOGIC;
         Z : in STD_LOGIC; 
         --Control Signals
         FI : in STD_LOGIC;
         CLK : in STD_LOGIC);
end component;
-- INSTRUCTION register
component INSTRUCTION_REGISTER is
  Port(--inouts 
       IR_out : out STD_LOGIC_VECTOR(7 downto 0);
       IR_in : in STD_LOGIC_VECTOR(7 downto 0);
       --Control Signals
       II : in STD_LOGIC; 
       CLK : in STD_LOGIC);    
end component;
-- STEP counter 
component STEP_COUNTER is
    port(--inouts
         step_count : out std_logic_vector(3 downto 0);
         --control signals 
         SCR : in std_logic;
         CLK : in std_logic);
end component;
-- PROGRAM counter 
component PROGRAM_COUNTER is
    port(--inouts
         PC_inout_bus : inout std_logic_vector(7 downto 0);
         carryout : out std_logic;
         --control signals
         C_INC : in std_logic;
         CI : in std_logic;
         CO : in std_logic;
         CLK : in std_logic;
         RST : in std_logic);
end component;
-- MEMORY ADDRESS register 
component MEMADDR_REGISTER is
    port (--inouts
          MAR_in_bus : in std_logic_vector(7 downto 0);
          MAR_out : out std_logic_vector(7 downto 0);
          --control signal
          MARI : in std_logic;
          CLK : in std_logic);
end component;




signal AI, AO, BI, BO, SorD, ALUO, FI, II, SCR, HorL, CE, CI, CO : std_logic;
signal CIL, CIH, COL, COH : std_logic;
signal N, C, Z : std_logic;
signal A, B, INSTRUCTION : std_logic_vector(7 downto 0);
signal FLAGS : std_logic_vector(2 downto 0);
signal STEP_COUNT : std_logic_vector(3 downto 0);
signal PC_carry : std_logic;
begin
A_REG: A_REGISTER port map (A_inout_bus => DATA_BUS, 
                            CLK => CLK,
                            RST => RST,
                            AI => AI,
                            AO => AO,
                            A_value => A);
                            
B_REG: B_REGISTER port map (B_inout_bus => DATA_BUS, 
                            CLK => CLK,
                            RST => RST,
                            BI => BI,
                            BO => BO,
                            B_value => B);
                            
ALU_M : ALU port map (A => A,
                      B => B,
                      ALU_out_bus => DATA_BUS,
                      SorD => SorD,
                      ALU_O => ALUO,
                      N => N,
                      C => C,
                      Z => Z);     
                    
FLAGS_REG : FLAGS_REGISTER port map (--inouts 
                                     FLAGS => FLAGS,
                                     N => N,
                                     C => C,
                                     Z => Z,
                                     --Control Signals
                                     FI => FI,
                                     CLK => CLK);                   

I_REG : INSTRUCTION_REGISTER port map (IR_in => DATA_BUS,
                                       IR_out => INSTRUCTION,
                                       II => II,
                                       CLK => CLK);
                                       
STEP : STEP_COUNTER port map (step_count => STEP_COUNT,
                              SCR => SCR,
                              CLK => CLK);

PCL : PROGRAM_COUNTER port map (PC_inout_bus => DATA_BUS,
                                carryout => PC_carry,
                                C_INC => CE,
                                CI => CIL,
                                CO => COL,
                                CLK => CLK,
                                RST => RST);
                                
PCH : PROGRAM_COUNTER port map (PC_inout_bus => DATA_BUS,
                                C_INC => PC_carry,
                                CI => CIH,
                                CO => COH,
                                CLK => CLK,
                                RST => RST);

end Behavioral;
