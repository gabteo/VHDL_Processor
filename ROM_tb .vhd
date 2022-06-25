library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM_tb is
end entity ROM_tb;

architecture a_ROM_tb of ROM_tb  is
    component ROM is
        port
        (
            clk      : IN std_logic ;
            endereco : IN unsigned (15 downto 0);
            dado     : OUT unsigned (15 downto 0);
            en : in std_logic
        );
    end component;
    
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clk : std_logic;
    signal endereco, dado : unsigned(15 downto 0);
begin
    uut : ROM port map
    (
        clk => clk,
        endereco => endereco,
        dado => dado
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
--        wait for 200 ns;
--        
--        endereco <= "0000000000000000";
--        wait for 100 ns;
--        
--        endereco <= "0000000000000001";
--        wait for 100 ns;
--        
--        endereco <= "0000000000000010";
--        wait for 100 ns;
--        
--        endereco <= "0000000000000011";
--        wait for 100 ns;
--        
--        endereco <= "0000000000000100";
--        wait for 100 ns;
--        
--        endereco <= "0000000000000101";
--        wait for 100 ns;
--        
--        endereco <= "0000000000000110";
--        wait for 100 ns;
--        
--        endereco <= "0000000000000111";
--        wait for 100 ns;
--        
--        endereco <= "0000000000001000";
--        wait for 100 ns;
--        
--        endereco <= "0000000000001001";
--        wait for 100 ns;
--        
--        endereco <= "0000000000001010";
--        wait for 100 ns;
--        
--        endereco <= "0000000000001011";
--        wait for 100 ns;
--        
--        endereco <= "0000000001001011";
--        wait for 100 ns;
--        
--        endereco <= "0000000001110011";
--        wait for 100 ns;
--        endereco <= "0000000000001001";
--        wait for 100 ns;
        wait;
    end process;

end architecture a_ROM_tb;