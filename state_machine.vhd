library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity state_machine is
    port(
        clk : in std_logic;
        rst : in std_logic;
        estado : out unsigned(1 downto 0)
    );
end entity;

architecture a_state_machine of state_machine is
    signal estado_s: unsigned(1 downto 0);
begin
    process(clk,rst)
    begin
        if rst='1' then
            estado_s <= "00";
        elsif rising_edge(clk) then
            if estado_s = "10" then
                estado_s <= "00";
            else
                estado_s <= estado_s + "01";
            end if;
        end if;
    end process;
    estado <= estado_s;
end architecture;