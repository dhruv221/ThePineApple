library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CORE is
    Port (RST : in std_logic;
          CLK : in std_logic;
          --AI, AO, BI, BO, SorD, ALUO, FI, II, SCR, HL, CE, CI, CO, MI, RI, RO, OI : IN std_logic;
          DATA_BUS : inout STD_LOGIC_VECTOR (7 downto 0);
          leds : inout std_logic_vector(7 downto 0));
    
end CORE;




architecture Behavioral of CORE is
--signal DATA_BUS :  STD_LOGIC_VECTOR (7 downto 0);
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
         PC_in_bus : in std_logic_vector(7 downto 0);
         PC_out_bus : out std_logic_vector(7 downto 0);
         carryout : out std_logic;
         --control signals
         CE : in std_logic;
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

component RAM is
    port (--inouts 
          RAM_addrs : in std_logic_vector(15 downto 0);
          RAM_in_bus : in std_logic_vector(7 downto 0);
          RAM_out_bus : out std_logic_vector(7 downto 0);
          --control signals 
          RI : in std_logic;
          RO : in std_logic;
          CLK : in std_logic);
end component;

component OUTPUT_REGISTER is
    port (--inouts
          OUTREG_in : in std_logic_vector(7 downto 0);
          OUTREG_out : out std_logic_vector(7 downto 0);
          --control signals
          OI : in std_logic;
          CLK : in std_logic);
end component;

component pcmar_logic is
    port(--inouts
         HL : in std_logic;
         coh : out std_logic;
         col : out std_logic;
         cih : out std_logic;
         cil : out std_logic;
         mil : out std_logic;
         mih : out std_logic;
         -- control signals 
         CI : in std_logic;
         CO : in std_logic;
         MI : in std_logic);
end component;

component CONTROL_UNIT is
    port(ADDRESS : in std_logic_vector(14 downto 0);
         CONTROL : out std_logic_vector(17 downto 0));
end component;


signal AI, AO, BI, BO, SorD, ALUO, FI, II, SCR, HorL, CE, CI, CO, MI, RI, RO, OI, HL, HLT : std_logic;
signal CIL, CIH, COL, COH, MIL, MIH : std_logic;
signal N, C, Z : std_logic;
signal RAM_addrs : std_logic_vector(15 downto 0);
signal A, B, INSTRUCTION, OUTPUT_VALUE : std_logic_vector(7 downto 0);
signal FLAGS : std_logic_vector(2 downto 0);
signal STEP_COUNT : std_logic_vector(3 downto 0);
signal PC_carry : std_logic;
--signal OUTREG : std_logic_vector(7 downto 0);


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

PCL : PROGRAM_COUNTER port map (PC_in_bus => DATA_BUS,
                                PC_out_bus => DATA_BUS,
                                carryout => PC_carry,
                                CE => CE,
                                CI => CIL,
                                CO => COL,
                                CLK => CLK,
                                RST => RST);
                                
PCH : PROGRAM_COUNTER port map (PC_in_bus => DATA_BUS,
                                PC_out_bus => DATA_BUS,
                                CE => PC_carry,
                                CI => CIH,
                                CO => COH,
                                CLK => CLK,
                                RST => RST);
                                
MARL : MEMADDR_REGISTER port map (MAR_in_bus => DATA_BUS,
                                  MAR_out => RAM_addrs(7 downto 0),
                                  MARI => MIL,
                                  CLK => CLK);

MARH : MEMADDR_REGISTER port map (MAR_in_bus => DATA_BUS,
                                  MAR_out => RAM_addrs(15 downto 8),
                                  MARI => MIH,
                                  CLK => CLK);
                                  
RAM_M : RAM port map (RAM_addrs => RAM_addrs,
                      RAM_in_bus => DATA_BUS,
                      RAM_out_bus => DATA_BUS,
                      RI => RI,
                      RO => RO,
                      CLK => CLK);
                      
OUTREG_M : OUTPUT_REGISTER port map (OUTREG_in => DATA_BUS,
                                     OUTREG_out => leds,
                                     OI => OI,
                                     CLK => CLK);

pcmar_logic_m : pcmar_logic port map (HL => HL,
                                      CO => CO,
                                      CI => CI,
                                      MI => MI,
                                      coh => COH,
                                      col => COL,
                                      cih => CIH,
                                      cil => CIL,
                                      mil => MIL,
                                      mih => MIH);
                                      
CONTROL_UNIT_M : CONTROL_UNIT port map(ADDRESS(3 downto 0) => STEP_COUNT,
                                       ADDRESS(11 downto 4) => INSTRUCTION,
                                       ADDRESS(14 downto 12) => FLAGS,
                                       CONTROL(0) => SorD,
                                       CONTROL(1) => ALUO,
                                       CONTROL(2) => AI,
                                       CONTROL(3) => AO,
                                       CONTROL(4) => BI,
                                       CONTROL(5) => BO,
                                       CONTROL(6) => HL,
                                       CONTROL(7) => CE,
                                       CONTROL(8) => CI,
                                       CONTROL(9) => CO,
                                       CONTROL(10) => MI,
                                       CONTROL(11) => FI,
                                       CONTROL(12) => II,
                                       CONTROL(13) => RI,
                                       CONTROL(14) => RO,
                                       CONTROL(15) => OI,
                                       CONTROL(16) => SCR,
                                       CONTROL(17) => HLT);
                                       

end Behavioral;
