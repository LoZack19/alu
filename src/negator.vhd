LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY negator IS
    GENERIC (
        N: integer
    );
    PORT (
        x: IN std_logic_vector(N-1 DOWNTO 0);
        y: OUT std_logic_vector(N-1 DOWNTO 0)
    );
END ENTITY negator;

ARCHITECTURE arch OF negator IS
    SIGNAL comp: std_logic_vector(N-1 DOWNTO 0);

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

    inv: FOR i IN N-1 DOWNTO 0 GENERATE
        comp(i) <= NOT x(i);
    END GENERATE;

    inc: full_adder GENERIC MAP (
        N => N
    ) PORT MAP (
        a => comp,
        b => (OTHERS => '0'),
        c_in => '1',
        y => y,
        c_out => OPEN
    );

END ARCHITECTURE arch;