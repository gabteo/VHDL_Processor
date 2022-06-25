library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM is
    port (
        clk         : in std_logic;
        endereco    : in unsigned(15 downto 0) ;
        dado        : out unsigned(15 downto 0);
        en : in STD_LOGIC
    );
end entity;

architecture a_ROM of ROM is
    type mem is array (0 to 127) of unsigned(15 downto 0);
    constant conteudo_rom : mem :=
    (
--        0   => "0000000000000000", --Do 1 vai pro 6,
--        1   => "1111000000000110",
--        2   => "0000000000000110",
--        3   => "0000001000100000",
--        4   => "0000000000000000",
--        5   => "0000000101001000",
--        6   => "1111000000001000", --j pro 8
--        7   => "0000001011011011",
--        8   => "1111000000000001", --j pro 1
--        9   => "0001010100011000",
--        10  => "0011011000101010",
--        0   => "0001011000000101", --R3 recebe 5
--        1   => "0001100000001000", --R4 recebe 8
--        2   => "0001101000000000", --Zera R5
--        3   => "0011101011000000", --Soma R5 com R3 e guarda em R5
--        4   => "0011101100000000", --Soma R5 com R4 e guarda em R5
--        --Agora temos R3 + R4 em R5
--        5   => "0001001000000001", --R1 recebe 1
--        6   => "0100101001000000", --R5 - 1(R1) e salva em R5
--        7   => "1111000000010100", --Jump para 20
--        20  => "0101001101111000", --R1 > R5? 0 em R7
--        21  => "0101101001110000", --R5 > R1? 1 em R6
--        22  => "0101101101110000", --R5 > R5? 0 em R7
--        23  => "0110101101010000", --R5 x R5 em R2
        
--        0   => "0001011000000101", --R3 recebe 5                                                MOV R3,#005h
--        1   => "0001100000001000", --R4 recebe 8                                                MOV R4,#008h
--        2   => "0010101011000000", --Move R5 para R3                                            MOV R5,R3
--        3   => "0011101100000000", --Soma R5 com R4 e guarda em R5                              ADD R5,R4
--        --Agora temos (R3 + R4) em R5
--        4  => "0001001000000001", --R1 recebe 1                                                 MOV R1,#001h
--        5   => "0100101001000000", --R5 - 1(R1) e salva em R5                                   SUB R5,R1
--        6   => "1111000000010100", --Jump para 20                                               JMPS 20
--        20  => "0010011101000000", --Move R5 para R3                                            MOV R3,R5
--        21  => "1111000000000010", --Volta para o endereco 2 onde (R5 <= R3+R4) comeca.         JMPS 2
        
--        0   => B"0001_011_000_000000", --R3 recebe 0                                                MOV R3,#000h
--        1   => B"0001_100_000_000000", --R4 recebe 0                                                MOV R4,#000h
--        2   => B"0011_100_011_000000", --Soma R4 com R3 e guarda em R4                              ADD R4,R3
--        3   => B"0001_001_000_000001", --R1 recebe 1                                                MOV R1,#001h
--        4   => B"0011_011_001_000000", --R3 + 1(R1) e salva em R3                                   SUB R5,R1
--        5   => B"0001_010_000_011110", --R2 recebe 30                                               MOV R2,#01Eh
--        6   => B"0010_111_011_000000", --Move R3 para R7                                            MOV R3,R7
--        7   => B"0100_111_010_000000", --Compara R7 com R2(30)                                      SUB R3,R2
--        8   => B"0111_111_111_111001", --Volta para instrução 2                                     JMPR -6
--        9   => B"0010_101_100_000000", --Carrega R4 em R5                                           MOV R5,R4
        
--         0   => B"0001_011_000_001000", --R3 recebe 8
--         1   => B"0001_100_000_001101", --R4 recebe 13
--         2   => B"1000_011_100_000000", --Copia R3 para (R4)  Ram(13)=8
--         3   => B"1000_100_011_000000", --Copia R4 para (R3)  Ram(8)=13
--         4   => B"1001_010_011_000000", --Copia (R3) para R2  R2=13
--         5   => B"1001_110_100_000000", --Copia (R4) para R6  R6=8
--         6   => B"0001_111_111111111", --R7 recebe 511
--         7   => B"0001_110_000110101", --R6 recebe 53
--         8   => B"1000_111_110_000000", --Copia R7 para (R6)  Ram(53)=511
--         9   => B"1001_010_110_000000", --Copia (R6) para R2  R2=511
--        10   => B"1001_111_100_000000", --Copia (R4) para R7  R7=8
--        11   => B"1000_010_111_000000", --Copia R2 para (R7)  Ram(8)=511
--        12   => B"1001_001_111_000000", --Copia (R7) para R1  R1=511
--        13   => B"1000_110_100_000000", --Copia R6 para (R4)  Ram(13)=53
--        14   => B"1001_101_100_000000", --Copia (R4) para R5  R5=53

--      Inserindo os números na RAM
        0   => B"0001_001_000000001", --R1 recebe 1                                 MOV R1,#001h
        1   => B"0001_010_000000001", --R2 recebe 1                                 MOV R2,#001h
        2   => B"0001_011_000100001", --R3 recebe 33                                MOV R3,#021h
        3   => B"1000_001_001_000000", --Copia R1 para (R1)  Ram(i)=i               MOV [R1],R1
        4   => B"0011_001_010_000000", --Soma R1 com R2 e guarda em R1              ADD R1,R2
        5   => B"0010_111_001_000000", --Copia R1 para R7                           MOV R7,R1
        6   => B"0100_111_011_000000", --Compara R7 com R3 (R7<33)                  SUB R7,R3
        7   => B"0111_111_111111011", --Volta para instrução 3                      JMPR ULE,#FFBh
        
--      Loop para garantir que os números foram corretamente inseridos na RAM
--      8    => B"0100_001_010_000000", --Subtrai 1 de R1
--      9    => B"1001_101_001_000000", --Copia (R1) para R5
--      10   => B"0010_111_001_000000", --Copia R1 para R7
--      11   => B"0001_100_000000000", --R4 recebe 0
--      12   => B"0100_100_111_000000", --Compara R4 com R7 (0<R7)
--      13   => B"0111_111_111111010", --Volta para instrução 8
        
        8   => B"0001_001_000_000001", --R1 recebe 1                                MOV R1,#001h
        9   => B"0001_010_000_000001", --R2 recebe 1                                MOV R2,#001h
        
        10   => B"0011_010_001_000000", --R2 <- R2+R1                               ADD R2,R1
        
        11   => B"0001_100_000_000110", --R4 recebe 5 (Raiz de 32)                  MOV R4,#005h
        12   => B"0010_110_010_000000", --R6 <- R2                                  MOV R6,R2
        13   => B"0100_100_110_000000", --Compara R4 com R6 (R2<Raiz de 32)         SUB R4,R6
        14   => B"0111_000000001011", --Vai para instrução Final                    JMPR ULE,#00Bh
        
        15   => B"1001_110_010_000000", --R6 recebe (R2)                            MOV R6,[R2]
        16   => B"0100_110_000_000000", --Compara R6 com R0                         SUB R6,R0
        17   => B"0111_111111111000", --Volta pra 10                                JMPR ULE,#FF8h
        
        18   => B"0010_101_010_000000", --R5 <- R2                                  MOV R5,R2
        19   => B"0011_101_010_000000", --R5 <- R5 + R2                             ADD R5,R2
        
        20   => B"1000_000_101_000000", --Mem(R5) = 0                               MOV [R5],R0
        21   => B"0011_101_010_000000", --R5 <- R5 + R2                             ADD R5,R2
        22   => B"0010_110_101_000000", --R6 <- R5                                  MOV R6,R5
        23   => B"0100_110_011_000000", --Compara R6 com R3 (limite)                SUB R6,R3
        24   => B"0111_111111111011", --Vai para instrução 20                       JMPR ULE,#FFBh
        25   => B"1111_000000001010", --Vai para instrução 10                       JMPS #00Ah
        --R1 Já está em 1
        26   => B"0001_010_000_000000", --R2 <- 0                                   MOV R2,#000h
        27   => B"0011_010_001_000000", --R2 <-R2 + R1                              ADD R2,R1
        28   => B"1001_101_010_000000", --Copia (R2) para R5                        MOV R5,[R2]
        29   => B"0100_101_000_000000", --Compara R5 com R0                         SUB R5,R0
        30   => B"0111_111_111111100", --Volta para instrução 26                    JMPR ULE,#FFCh
        31   => B"0010_111_101_000000", --Copia R5 para R7                          MOV R7,R5
        32   => B"1111_000000011011",--Volta para 27                                JMPS #01Bh
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
        if(en = '1') then
        dado <= conteudo_rom(to_integer(endereco));
    end if;
end if;
end process;
end architecture a_ROM;