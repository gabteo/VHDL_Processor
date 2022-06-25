library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity un_controle_tb is
end entity un_controle_tb;

architecture a_un_controle_tb of un_controle_tb is
    component un_controle is
        port
        (
            instrucao   : IN unsigned (15 downto 0);
            carga       : OUT std_logic ;
            transfere   : OUT std_logic ;
            nop         : OUT std_logic ;
            jump        : OUT std_logic ;
            PC_enable   : OUT std_logic ;
            ROM_enable  : OUT std_logic ;
            reg_inst_en : OUT std_logic ;
            estado      : OUT unsigned (1 downto 0);
            op_ula      : OUT unsigned (1 downto 0);
            clk         : IN std_logic ;
            rst         : IN std_logic
        );
        
    end component;
    signal instrucao : unsigned(15 downto 0);
    signal jump, nop : STD_LOGIC;
begin
    uut : un_controle port map(
        instrucao => instrucao,
        jump => jump,
        nop => nop
    );
    
    process
    begin
        
    end process;
 

end architecture a_un_controle_tb;