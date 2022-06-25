library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity prox_inst is
    port(
        entrada : in unsigned(15 downto 0);
        saida : out unsigned(15 downto 0)
    );
end entity;

architecture a_prox_inst of prox_inst is
    begin
        saida <= entrada + "0000000000000001";
end architecture a_prox_inst;