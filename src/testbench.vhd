LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY testbench IS
END ENTITY testbench;

ARCHITECTURE arch OF testbench IS
    SIGNAL cmd_s: std_logic_vector(2 DOWNTO 0);
    SIGNAL a_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL b_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL y_s: std_logic_vector(3 DOWNTO 0);

    COMPONENT alu IS
        GENERIC (
            N: integer
        );
        PORT (
            cmd: IN std_logic_vector(2 DOWNTO 0);
            a: IN std_logic_vector(N-1 DOWNTO 0);
            b: IN std_logic_vector(N-1 DOWNTO 0);
            y: OUT std_logic_vector(N-1 DOWNTO 0)
        );
    END COMPONENT alu;
BEGIN

    uut: alu GENERIC MAP (
        N => 4
    ) PORT MAP (
        cmd => cmd_s,
        a => a_s,
        b => b_s,
        y => y_s
    );

    stimulus: PROCESS
    BEGIN

        cmd_s <= "000";
        a_s <= "0000";
        b_s <= "0000";
        WAIT FOR 10 NS;

        cmd_s <= "100";
        a_s <= "0101";
        b_s <= "0011";
        WAIT FOR 10 NS;

        cmd_s <= "101";
        a_s <= "0101";
        b_s <= "0011";
        WAIT FOR 10 NS;

        cmd_s <= "110";
        a_s <= "0101";
        b_s <= "0011";
        WAIT FOR 10 NS;

        cmd_s <= "111";
        a_s <= "0101";
        b_s <= "0011";
        WAIT FOR 10 NS;

        WAIT;
    END PROCESS;

END ARCHITECTURE arch;