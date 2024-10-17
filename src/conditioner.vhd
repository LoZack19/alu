LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY conditioner IS
    GENERIC (
        N: integer
    );
    PORT (
        cmd: IN std_logic_vector(2 DOWNTO 0);
        a: IN std_logic_vector(N-1 DOWNTO 0);
        b: IN std_logic_vector(N-1 DOWNTO 0);
        a_cond: OUT std_logic_vector(N-1 DOWNTO 0);
        b_cond: OUT std_logic_vector(N-1 DOWNTO 0);
        c_in_cond: OUT std_logic
    );
END ENTITY conditioner;

ARCHITECTURE arch OF conditioner IS
    SIGNAL zero_s: std_logic_vector(N-1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL neg_s: std_logic_vector(N-1 DOWNTO 0);
    SIGNAL and_s: std_logic_vector(N-1 DOWNTO 0);
    SIGNAL or_s: std_logic_vector(N-1 DOWNTO 0);

    CONSTANT SEL_INC: std_logic_vector(2 DOWNTO 0) := "000";
    CONSTANT SEL_ADD: std_logic_vector(2 DOWNTO 0) := "100";
    CONSTANT SEL_SUB: std_logic_vector(2 DOWNTO 0) := "101";
    CONSTANT SEL_AND: std_logic_vector(2 DOWNTO 0) := "110";
    CONSTANT SEL_OR: std_logic_vector(2 DOWNTO 0) := "111";

    COMPONENT negator IS
        GENERIC (
            N: integer
        );
        PORT (
            x: IN std_logic_vector(N-1 DOWNTO 0);
            y: OUT std_logic_vector(N-1 DOWNTO 0)
        );
    END COMPONENT negator;

BEGIN

    and_net: FOR i IN N-1 DOWNTO 0 GENERATE
        and_s(i) <= a(i) AND b(i);
    END GENERATE;

    or_net: FOR i IN N-1 DOWNTO 0 GENERATE
        and_s(i) <= a(i) AND b(i);
    END GENERATE;

    neg: negator GENERIC MAP (
        N => N
    ) PORT MAP (
        x => b,
        y => neg_s
    );

    -- the OTHERS case defaults to SEL_INC
    WITH cmd SELECT a_cond <= a WHEN SEL_INC,
        a WHEN SEL_ADD,
        a WHEN SEL_SUB,
        and_s WHEN SEL_AND,
        or_s WHEN SEL_OR,
        a WHEN OTHERS;

    WITH cmd SELECT b_cond <= zero_s WHEN SEL_INC,
        b WHEN SEL_ADD,
        neg_s WHEN SEL_SUB,
        zero_s WHEN SEL_AND,
        zero_s WHEN SEL_OR,
        zero_s WHEN OTHERS;
    
    WITH cmd SELECT c_in_cond <= '1' WHEN SEL_INC,
        '0' WHEN SEL_ADD,
        '0' WHEN SEL_SUB,
        '0' WHEN SEL_AND,
        '0' WHEN SEL_OR,
        '1' WHEN OTHERS;
    
    WITH cmd SELECT c_in_cond <= '1' WHEN SEL_INC, '0' WHEN OTHERS;

END ARCHITECTURE arch;