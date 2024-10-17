LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY full_adder IS
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
END ENTITY full_adder;

ARCHITECTURE ripple_carry_adder OF full_adder IS
    SIGNAL c: std_logic_vector(N DOWNTO 0);
BEGIN

    c(0) <= c_in;
    ripple_carry: FOR i IN N-1 DOWNTO 0 GENERATE
        y(i) <= a(i) XOR b(i) XOR c(i);
        c(i+1) <= (a(i) AND b(i)) OR (b(i) AND c(i)) OR (c(i) AND a(i));
    END GENERATE;
    c_out <= c(N);

END ARCHITECTURE ripple_carry_adder;