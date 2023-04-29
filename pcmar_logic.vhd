library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity pcmar_logic is
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
end entity;
  
architecture Behavioral of pcmar_logic  is
begin

process(CI, CO, MI)
begin

if (CI = '0' and CO = '0' and MI = '0') then
    coh <= '0';
    col <= '0';
    cih <= '0';
    cil <= '0';
    mil <= '0';
    mih <= '0';

elsif (HL = '0') then
    if (CI = '1') then
        coh <= '0';
        col <= '0';
        cih <= '0';
        cil <= '1';
        mil <= '0';
        mih <= '0';
    end if;
    
    if (CO = '1') then
        coh <= '0';
        col <= '1';
        cih <= '0';
        cil <= '0';
        --mil <= '0';
        mih <= '0';
    end if;
    
    if (MI = '1') then
        coh <= '0';
        --col <= '0';
        cih <= '0';
        cil <= '0';
        mil <= '1';
        mih <= '0';
    end if;

elsif (HL = '1') then
    if (CI = '1') then
        coh <= '0';
        col <= '0';
        cih <= '1';
        cil <= '0';
        mil <= '0';
        mih <= '0';
    end if;
    
    if (CO = '1') then
        coh <= '1';
        col <= '0';
        cih <= '0';
        cil <= '0';
        mil <= '0';
        --mih <= '0';
    end if;
    
    if (MI = '1') then
        --coh <= '0';
        col <= '0';
        cih <= '0';
        cil <= '0';
        mil <= '0';
        mih <= '1';
    end if;
end if;


end process;

end Behavioral;
