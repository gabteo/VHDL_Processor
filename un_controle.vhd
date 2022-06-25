library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity un_controle is
    port(
        instrucao : in unsigned(15 downto 0);
        carga, transfere, nop, jump, PC_enable, RAM_escrita, RAM_leitura, ROM_enable, reg_inst_en, branch : out std_logic;
        estado, op_ula : out unsigned(1 downto 0);
        opcode_out : out unsigned(3 downto 0);
        clk, rst : in std_logic
    );
end entity un_controle;

architecture a_un_controle of un_controle is
    component state_machine is
        port
        (
            clk    : IN std_logic ;
            rst    : IN std_logic ;
            estado : OUT unsigned(1 downto 0)
        );
    end component;
    
    signal opcode : unsigned(3 downto 0);
    signal estado_sm : unsigned(1 downto 0);
    
    
begin
    sm1: state_machine port map (clk => clk, rst => rst, estado => estado_sm);
    
    reg_inst_en <= '1' when estado_sm = "01" else
    '0';
    
    ROM_enable <=
    '1' when estado_sm = "00" else --Fetch
    '0';
    
    RAM_escrita <= '1' when opcode = "1000" and (estado = "10") else --Reg -> Mem
    '0';
    
    RAM_leitura <= '1' when opcode = "1001" and (estado = "10") else --Mem -> Reg
    '0';
    
    PC_enable <=
    '1' when estado_sm = "10" else --Execute
    '0';
    
    opcode <= instrucao(15 downto 12);
    
    nop <= '1' when opcode = "0000" and (estado = "10") else
    '0';
    
    jump <= '1' when opcode = "1111" and (estado = "10") else --Jump
    '0';
    
    carga <= '1' when opcode = "0001" and (estado = "10") else--Carga de constante no registrador
    '0';
    
    transfere <= '1' when opcode = "0010" and (estado = "10") else --Tranfere valor entre registradores
    '0';
    
    --Qual operação da ULA será utilizada
    op_ula <= "00" when opcode = "0011" and (estado = "10")  else --Soma
              "01" when opcode = "0100" and (estado = "10")  else --Subtração
              "10" when opcode = "0101" and (estado = "10")  else --Menor
              "11" when opcode = "0110" and (estado = "10")  else --Multiplicação
    "00";
    
    branch <= '1' when opcode = "0111" and (estado = "10") else --Branch
    '0';
    
    estado <= estado_sm;
    opcode_out <= opcode;
end architecture a_un_controle;