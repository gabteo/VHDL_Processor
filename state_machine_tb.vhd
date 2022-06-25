library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity state_machine_tb is
end entity state_machine_tb;

architecture a_state_mahcine_tb of state_machine_tb is
    component state_machine is
        port
        (
            clk    : IN std_logic ;
            rst    : IN std_logic ;
            estado : out unsigned(1 downto 0)
        );
    end component;
    
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clk : std_logic;
    signal rst : std_logic;
    signal estado_s : unsigned(1 downto 0);
    
begin
    uut : state_machine port map
    (
        clk => clk,
        rst => rst,
        estado => estado_s
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
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clock_proc;
    
    process
    begin
        wait;
    end process;

end architecture a_state_mahcine_tb;