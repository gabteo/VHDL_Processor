--Lucas Perin
--Gabriel Cobliski

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ULA is
    port (
        in_a , in_b : in unsigned (15 downto 0); --2 entradas de 16 bits
        saida_ula : out unsigned(15 downto 0);       --Saída de 16 bits
        op_ula : in unsigned (1 downto 0);       --Seletor de operações
        soma  : out unsigned(16 downto 0);  --Resultado Soma
        subt : out unsigned(15 downto 0);  --Resultado da Subtração
        carry_subt : out std_logic;       --Resultado da operação Menor
        carry_soma : out std_logic;
        mult  : out unsigned (31 downto 0)       --Resultado da operação Multiplicação
    );
end entity;

architecture a_ULA of ULA is
begin
    soma <= ('0' & in_a) + ('0' & in_b);                                          --Soma as 2 entradas
    subt <= in_a - in_b;                                          --Subtração a-b
    carry_subt <= '1' when in_b>=in_a else '0';                       --Operação "Menor", se a < b retorna 1 ou 0 caso contrário
    mult <= (in_a * in_b);                                        --Multiplicação das 2 entradas
    
    saida_ula <= soma(15 downto 0) when op_ula = "00" else              --Seletor em "00" -> Operação de Soma
    subt when op_ula = "01" else                           --Seletor em "01" -> Operação de Subtração
    "0000000000000001" when carry_subt = '1' and op_ula = "10"else     --Seletor em "10" -> Operação de Comparação.
    "0000000000000000" when carry_subt = '0' and op_ula = "10"else
                                                                        --Como a "resposta" da função ">" tem somente um bit, precisamos transforma-la em 16 bits para que a ULA consiga operar
    mult(15 downto 0) when op_ula = "11"else              --Seletor em "11" -> Operação de Multiplicação
    "0000000000000000";
    
    carry_soma <= soma(16);
end architecture a_ULA;

