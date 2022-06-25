library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC_tb is
end entity PC_tb;

architecture a_PC_tb of PC_tb is
    component PC is
        port
        (
            wr_en_pc   : IN std_logic ;
            reset_pc   : IN STD_LOGIC ;
            clock_pc   : IN STD_LOGIC ;
            entrada_pc : IN unsigned (15 downto 0);
            saida_pc   : OUT unsigned (15 downto 0)
        );
    end component;
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clock_pc, reset_pc, wr_en_pc : std_logic;
    signal entrada_pc, saida_pc : unsigned(15 downto 0);
    
begin
    uut : PC port map
    (
        clock_pc => clock_pc,
        reset_pc => reset_pc,
        wr_en_pc => wr_en_pc,
        entrada_pc => entrada_pc,
        saida_pc => saida_pc
    );
    
    sim_time_proc: process
    begin
        wait for 10 us; -- <== TEMPO TOTAL DA SIMULAÇÃO!!!
        finished <= '1';
        wait;
    end process sim_time_proc;
    
    clock_proc: process
    begin -- gera clock até que sim_time_proc termine
        while finished /= '1' loop
            clock_pc <= '0';
            wait for period_time/2;
            clock_pc <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clock_proc;
    process
    begin
        wait;
    end process;

end architecture a_PC_tb;