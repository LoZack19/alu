LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY testbench IS
END ENTITY testbench;

ARCHITECTURE arch OF testbench IS
    SIGNAL a_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL b_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL c_in_s: std_logic;
    SIGNAL y_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL c_out_s: std_logic;

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

    uut: full_adder GENERIC MAP (
        N => 4
    ) PORT MAP (
        a => a_s,
        b => b_s,
        c_in => c_in_s,
        y => y_s,
        c_out => c_out_s
    );

    stimulus: PROCESS
    BEGIN
    
        a_s <= "0011";
        b_s <= "0101";
        c_in_s <= '0';
        WAIT FOR 10 NS;

        WAIT;
    END PROCESS;

END ARCHITECTURE arch;