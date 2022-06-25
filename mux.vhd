library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux is
    port(
        in_mux_1, in_mux_2 : in unsigned(15 downto 0);
        sel_mux : in std_logic;
        out_mux : out unsigned(15 downto 0)
    );
end entity mux;

architecture a_mux of mux is
begin
    out_mux <=   in_mux_1 when sel_mux = '0' else --Registrador
                 in_mux_2 when sel_mux = '1' else --Constante
                 "0000000000000000";
end architecture a_mux;
