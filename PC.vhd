library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC is
    port (
        
        wr_en_pc, jump, branch, flag : in std_logic;
        reset_pc : in STD_LOGIC;
        clock_pc : in STD_LOGIC;
        entrada_pc : in unsigned(15 downto 0);
        saida_pc : out unsigned(15 downto 0)
    );
end entity;

architecture a_PC of PC is
    component reg_pc is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN unsigned (15 downto 0);
            data_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    component prox_inst is
        port
        (
            entrada : IN unsigned (15 downto 0);
            saida   : OUT unsigned (15 downto 0)
        );
    end component;
    
    signal data_in, data_out, out_reg_pc, out_prox: unsigned(15 downto 0);
    
begin
    reg_pc1 : reg_pc port map (clk => clock_pc, rst => reset_pc,
        wr_en => wr_en_pc, data_in => data_in, data_out => out_reg_pc);
    prox_inst1: prox_inst port map (entrada => out_reg_pc, saida => out_prox);
    
    saida_pc <= out_reg_pc;
    --data_in <= out_prox when jump = '0' else "0000000000000000";
    data_in <=  out_prox when jump = '0' and branch = '0' else   --se instrução seguinte
    out_prox when jump = '0' and branch = '1' and flag = '0' else
    (entrada_pc + out_prox) when jump = '0' and branch = '1' and flag = '1' else
    entrada_pc when jump = '1' and branch = '0'else
    "0000000000000000";
end architecture  a_PC;