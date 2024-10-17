LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY testbench IS
END ENTITY testbench;

ARCHITECTURE arch OF testbench IS
    SIGNAL x_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL y_s: std_logic_vector(3 DOWNTO 0);

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

    uut: negator GENERIC MAP (
        N => 4
    ) PORT MAP (
        x => x_s,
        y => y_s
    );

    stimulus: PROCESS
    BEGIN

        x_s <= "0101";
        WAIT FOR 10 NS;

        WAIT;
    END PROCESS;

END ARCHITECTURE arch;