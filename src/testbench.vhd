LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY testbench IS
END ENTITY testbench;

ARCHITECTURE arch OF testbench IS
    SIGNAL cmd_s: std_logic_vector(2 DOWNTO 0);
    SIGNAL a_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL b_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL a_cond_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL b_cond_s: std_logic_vector(3 DOWNTO 0);
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
BEGIN

    uut: conditioner GENERIC MAP (
        N => 4
    ) PORT MAP (
        cmd => cmd_s,
        a => a_s,
        b => b_s,
        a_cond => a_cond_s,
        b_cond => b_cond_s,
        c_in_cond => c_in_cond_s
    );

    stimulus: PROCESS
    BEGIN

        cmd_s <= "000";
        a_s <= "0101";
        b_s <= "0000";
        WAIT FOR 10 NS;

        WAIT;
    END PROCESS;

END ARCHITECTURE arch;