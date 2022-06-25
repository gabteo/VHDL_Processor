library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity banco is
    port (
        reg_1, reg_2, sel_reg : in unsigned(2 downto 0);
        data_in_banco : in unsigned(15 downto 0);
        write_en_banco, clock, reset : in std_logic;
        data_reg_1, data_reg_2 : out unsigned(15 downto 0)
    );
end entity;

architecture a_banco of banco is
    component mux is
        port
        (
            in_mux_1 : IN unsigned (15 downto 0);
            in_mux_2 : IN unsigned (15 downto 0);
            sel_mux  : IN std_logic;
            out_mux  : out unsigned (15 downto 0)
        );
    end component;
    
    component ULA is
        port
        (
            in_a    : IN unsigned (15 downto 0);
            in_b    : IN unsigned (15 downto 0);
            saida   : OUT unsigned (15 downto 0);
            seletor : IN unsigned (1 downto 0);
            soma    : OUT unsigned (15 downto 0);
            subt    : OUT unsigned (15 downto 0);
            maior   : OUT unsigned (0 downto 0);
            mult    : OUT unsigned (31 downto 0)
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
    signal out_mux : unsigned(15 downto 0);
    signal saida : unsigned(15 downto 0);
    signal r0, r1, r2, r3, r4, r5, r6, r7 : unsigned(15 downto 0);
    signal w0, w1, w2, w3, w4, w5, w6, w7 : std_logic;
begin
    
    reg0: reg16bits port map(clk => clock, rst => reset, wr_en => '1', data_in => "0000000000000000", data_out => r0);
    reg1: reg16bits port map(clk => clock, rst => reset, wr_en => w1, data_in => data_in_banco, data_out => r1);
    reg2: reg16bits port map(clk => clock, rst => reset, wr_en => w2, data_in => data_in_banco, data_out => r2);
    reg3: reg16bits port map(clk => clock, rst => reset, wr_en => w3, data_in => data_in_banco, data_out => r3);
    reg4: reg16bits port map(clk => clock, rst => reset, wr_en => w4, data_in => data_in_banco, data_out => r4);
    reg5: reg16bits port map(clk => clock, rst => reset, wr_en => w5, data_in => data_in_banco, data_out => r5);
    reg6: reg16bits port map(clk => clock, rst => reset, wr_en => w6, data_in => data_in_banco, data_out => r6);
    reg7: reg16bits port map(clk => clock, rst => reset, wr_en => w7, data_in => data_in_banco, data_out => r7);
    
    data_reg_1 <=
    r0 when reg_1 = "000" else
    r1 when reg_1 = "001" else
    r2 when reg_1 = "010" else
    r3 when reg_1 = "011" else
    r4 when reg_1 = "100" else
    r5 when reg_1 = "101" else
    r6 when reg_1 = "110" else
    r7 when reg_1 = "111" else
    "0000000000000000";
    
    data_reg_2 <=
    r0 when reg_2 = "000" else
    r1 when reg_2 = "001" else
    r2 when reg_2 = "010" else
    r3 when reg_2 = "011" else
    r4 when reg_2 = "100" else
    r5 when reg_2 = "101" else
    r6 when reg_2 = "110" else
    r7 when reg_2 = "111" else
    "0000000000000000";
    
    w1 <= '1' when sel_reg = "001" and write_en_banco = '1' else '0';
    w2 <= '1' when sel_reg = "010" and write_en_banco = '1' else '0';
    w3 <= '1' when sel_reg = "011" and write_en_banco = '1' else '0';
    w4 <= '1' when sel_reg = "100" and write_en_banco = '1' else '0';
    w5 <= '1' when sel_reg = "101" and write_en_banco = '1' else '0';
    w6 <= '1' when sel_reg = "110" and write_en_banco = '1' else '0';
    w7 <= '1' when sel_reg = "111" and write_en_banco = '1' else '0';
    
    
end architecture a_banco;