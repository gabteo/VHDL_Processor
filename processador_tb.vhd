library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processador_tb is
end entity processador_tb;

architecture a_processador_tb of processador_tb is
    component processador is
        port
        (
            instrucao_atual : OUT unsigned (15 downto 0);
            ula_saida       : OUT unsigned (15 downto 0);
            pc_saida        : OUT unsigned (15 downto 0);
            val_reg1        : OUT unsigned (15 downto 0);
            val_reg2        : OUT unsigned (15 downto 0);
            estado          : OUT unsigned (1 downto 0);
            clock           : IN STD_LOGIC ;
            reset           : IN STD_LOGIC
        );
    end component;
    
    -- 100 ns é o período que escolhi para o clock
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clock, reset : std_logic;
    signal instrucao_atual, ula_saida, pc_saida, val_reg1, val_reg2 : unsigned(15 downto 0);
    signal estado : unsigned(1 downto 0);
    
begin
    uut: processador port map(
        instrucao_atual => instrucao_atual,
        ula_saida => ula_saida,
        pc_saida => pc_saida,
        val_reg1 => val_reg1,
        val_reg2 => val_reg2,
        estado => estado,
        clock => clock,
        reset => reset
    );
    
    
    sim_time_proc: process
    begin
        wait for 156 us; -- <== TEMPO TOTAL DA SIMULAÇÃO!!!
        finished <= '1';
        wait;
    end process sim_time_proc;
    
    clock_proc: process
    begin -- gera clock até que sim_time_proc termine
        while finished /= '1' loop
            clock <= '0';
            wait for period_time/2;
            clock <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clock_proc;
    
    process
    begin
        reset <= '1';
        wait for period_time;
        reset <= '0';
        
        wait;
    end process;
end architecture a_processador_tb;