library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processador is
    port (
        instrucao_atual, ula_saida, pc_saida, val_reg1, val_reg2 : out unsigned(15 downto 0);
        estado : out unsigned(1 downto 0);
        clock, reset : in STD_LOGIC
    );
end entity processador;

architecture a_processador of processador is
    component mux is
        port
        (
            in_mux_1 : IN unsigned (15 downto 0);
            in_mux_2 : IN unsigned (15 downto 0);
            sel_mux  : IN std_logic;
            out_mux  : out unsigned (15 downto 0)
        );
    end component;
    
    component reg16bits is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN unsigned (15 downto 0);
            data_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    component ULA is
        port
        (
            in_a       : IN unsigned (15 downto 0);
            in_b       : IN unsigned (15 downto 0);
            saida_ula  : OUT unsigned (15 downto 0);
            op_ula     : IN unsigned (1 downto 0);
            soma       : OUT unsigned (16 downto 0);
            subt       : OUT unsigned (15 downto 0);
            carry_subt : OUT std_logic ;
            carry_soma : OUT std_logic ;
            mult       : OUT unsigned (31 downto 0)
        );
    end component;
    
    component banco is
        port
        (
            reg_1         : IN unsigned (2 downto 0);
            reg_2         : IN unsigned (2 downto 0);
            sel_reg       : IN unsigned (2 downto 0);
            data_in_banco : IN unsigned (15 downto 0);
            write_en_banco      : IN std_logic ;
            clock         : IN std_logic ;
            reset         : IN std_logic ;
            data_reg_1    : OUT unsigned (15 downto 0);
            data_reg_2    : OUT unsigned (15 downto 0)
        );
    end component;
    
    component PC is
        port
        (
            wr_en_pc   : IN std_logic ;
            jump       : IN std_logic ;
            branch     : IN std_logic ;
            flag       : IN std_logic ;
            reset_pc   : IN STD_LOGIC ;
            clock_pc   : IN STD_LOGIC ;
            entrada_pc : IN unsigned (15 downto 0);
            saida_pc   : OUT unsigned (15 downto 0)
        );
    end component;
    
    component ROM is
        port
        (
            clk      : IN std_logic ;
            endereco : IN unsigned (15 downto 0);
            dado     : OUT unsigned (15 downto 0);
            en : in std_logic
        );
    end component;
    
    component un_controle is
        port
        (
            instrucao   : IN unsigned (15 downto 0);
            carga       : OUT std_logic ;
            transfere   : OUT std_logic ;
            nop         : OUT std_logic ;
            jump        : OUT std_logic ;
            PC_enable   : OUT std_logic ;
            RAM_escrita  : OUT std_logic ;
            RAM_leitura  : OUT std_logic ;
            ROM_enable  : OUT std_logic ;
            reg_inst_en : OUT std_logic ;
            branch      : OUT std_logic ;
            estado      : OUT unsigned (1 downto 0);
            op_ula      : OUT unsigned (1 downto 0);
            opcode_out  : OUT unsigned (3 downto 0);
            clk         : IN std_logic ;
            rst         : IN std_logic
        );
    end component;
    
    component flag is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN std_logic ;
            data_out : OUT std_logic
        );
    end component;
    
    component ram is
        port
        (
            clk      : IN std_logic ;
            endereco : IN unsigned (6 downto 0);
            wr_en    : IN std_logic ;
            dado_in  : IN unsigned (15 downto 0);
            dado_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    signal saida_rom, out_mux1, out_mux2, data_reg_1, data_reg_2, data_in_banco, saida_ula, out_ram : unsigned(15 downto 0);
    signal reg_1, reg_2, reg_dest : unsigned(2 downto 0);
    signal op_ula : unsigned(1 downto 0);
    signal nop, jump, PC_enable, ROM_enable, carga, transfere, write_en_banco, reg_inst_en, branch, wr_en_carry, carry_out, carry_soma, carry_subt, carry_mux, wr_ram, re_ram : STD_LOGIC;
    signal instrucao, constante, saida_pc : unsigned(15 downto 0);
    signal opcode_out : unsigned(3 downto 0);
    signal endereco_ram : unsigned(6 downto 0);
    
begin
    reg_inst: reg16bits port map(clk => clock, rst => reset, wr_en => reg_inst_en, data_in => saida_rom, data_out => instrucao);
    
    mux_reg2_const: mux port map(in_mux_1 => data_reg_2, in_mux_2 => constante, sel_mux => (jump or carga or transfere), out_mux => out_mux1);
    
    mux_ula_const: mux port map(in_mux_1 => saida_ula, in_mux_2 => constante, sel_mux => (jump or carga or re_ram), out_mux => out_mux2);
    
    ula1: ULA port map(in_a => data_reg_1, in_b => out_mux1, saida_ula => saida_ula, op_ula => op_ula, carry_soma => carry_soma, carry_subt => carry_subt);
    
    banco1: banco port map(reg_1 => reg_1, reg_2 => reg_2, sel_reg => reg_dest, data_in_banco => out_mux2,
        write_en_banco => write_en_banco, clock => clock, reset => reset, data_reg_1 => data_reg_1, data_reg_2 =>data_reg_2);
    
    ROM1: ROM port map (clk => clock, endereco => saida_pc, dado => saida_rom, en => ROM_enable);
    
    PC1: PC port map(wr_en_pc => PC_enable, reset_pc => reset, clock_pc => clock,
        entrada_pc => constante, saida_pc => saida_pc, jump => jump, branch => branch, flag => carry_out);
    
    uc1: un_controle port map (instrucao => instrucao, carga => carga, transfere => transfere, nop => nop, jump => jump,
        PC_enable => PC_enable, RAM_escrita => wr_ram, RAM_leitura => re_ram, ROM_enable => ROM_enable, estado => estado, op_ula => op_ula, clk => clock, rst => reset, reg_inst_en => reg_inst_en,
        opcode_out => opcode_out, branch => branch);
    
    RAM1: ram port map (clk => clock, endereco => endereco_ram, wr_en => wr_ram, dado_in => data_reg_1, dado_out => out_ram);
    
    op_carry: flag port map (clk => clock, rst => reset, wr_en => wr_en_carry, data_in => carry_mux, data_out => carry_out);
    
    write_en_banco <= '1' when carga = '1' and estado = "10" else
    '1' when transfere = '1' and estado = "10" else
    '1' when opcode_out = "0011" and estado = "10" else
    '1' when opcode_out = "0100" and estado = "10" else
    '1' when opcode_out = "0110" and estado = "10" else
    '1' when opcode_out = "1001" and estado = "10" else
    '0';
    
    wr_en_carry <= '1' when (opcode_out = "0011" or opcode_out = "0100" or
        opcode_out = "0111") and estado = "10" else '0';
    
    carry_mux <= carry_soma when opcode_out = "0011" and estado = "10" else
    carry_subt when opcode_out = "0100" and estado = "10" else
    carry_subt when opcode_out = "0111" and estado = "10" else
    '0';
    
    constante <= "0000000" & instrucao(8 downto 0) when carga = '1' else
                 "0000" & instrucao(11 downto 0) when jump = '1' else
                 "0000" & instrucao(11 downto 0) when branch = '1' and instrucao(11) = '0' else
                 "1111" & instrucao(11 downto 0) when branch = '1' and instrucao(11) = '1' else
    out_ram when opcode_out = "1001" else
                 "0000000000000000";
    
    endereco_ram <= data_reg_2(6 downto 0) when opcode_out = "1000" else-- and estado = "10" else
    data_reg_2(6 downto 0) when opcode_out = "1001"else-- and estado = "10" else
    "0000000";
    
    reg_1 <= instrucao(8 downto 6) when transfere = '1' else
    instrucao(11 downto 9);

    reg_2 <= instrucao(8 downto 6);

    reg_dest <= instrucao(5 downto 3) when opcode_out = "0110" else
    instrucao(11 downto 9);
    
    instrucao_atual <= instrucao;
    
    pc_saida <= saida_pc;
    
    ula_saida <= saida_ula;
    
    val_reg1 <= data_reg_1;
    
    val_reg2 <= data_reg_2;
    
end architecture a_processador;