LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY alu IS
    GENERIC (
        N: integer
    );
    PORT (
        cmd: IN std_logic_vector(2 DOWNTO 0);
        a: IN std_logic_vector(N-1 DOWNTO 0);
        b: IN std_logic_vector(N-1 DOWNTO 0);
        y: OUT std_logic_vector(N-1 DOWNTO 0)
    );
END ENTITY alu;

ARCHITECTURE arch OF alu IS
    SIGNAL a_cond_s: std_logic_vector(N-1 DOWNTO 0);    
    SIGNAL b_cond_s: std_logic_vector(N-1 DOWNTO 0);
    SIGNAL c_in_cond_s: std_logic;

    COMPONENT conditioner IS
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
    END COMPONENT conditioner;

    COMPONENT full_adder IS
        GENERIC (
            N: integer := 1
        );
        PORT (
            a: IN std_logic_vector(N-1 DOWNTO 0);
            b: IN std_logic_vector(N-1 DOWNTO 0);
            c_in: IN std_logic;
            y: OUT std_logic_vector(N-1 DOWNTO 0);
            c_out: OUT std_logic
        );
    END COMPONENT full_adder;
BEGIN
    cond: conditioner GENERIC MAP (
        N => N
    ) PORT MAP (
        cmd => cmd,
        a => a,
        b => b,
        a_cond => a_cond_s,
        b_cond => b_cond_s,
        c_in_cond => c_in_cond_s
    );

    adder: full_adder GENERIC MAP (
        N => N
    ) PORT MAP (
        a => a_cond_s,
        b => b_cond_s,
        c_in => c_in_cond_s,
        y => y,
        c_out => OPEN
    );
END ARCHITECTURE arch;