library IEEE;
use IEEE.std_logic_1164.all;

entity TestMux4x08 is
end TestMux4x08;

architecture behavior of TestMux4x08 is
    constant STEP : Time := 100 ns;

    signal In_A : std_logic_vector(7 downto 0);
    signal IN_B : std_logic_vector(7 downto 0);
    signal IN_C : std_logic_vector(7 downto 0);
    signal IN_D : std_logic_vector(7 downto 0);
    signal Sel  : std_logic_vector(1 downto 0);
    signal Q    : std_logic_vector(7 downto 0);

    component Mux4x08
        port (
            a   : in  std_logic_vector(7 downto 0);
            b   : in  std_logic_vector(7 downto 0);
            c   : in  std_logic_vector(7 downto 0);
            d   : in  std_logic_vector(7 downto 0);
            sel : in  std_logic_vector(1 downto 0);
            q   : out std_logic_vector(7 downto 0)
        );
    end component;

begin
    Selector : Mux4x08 port map (IN_A, IN_B, IN_C, IN_D, Sel, Q);

    In_A <= "11110000";
    In_B <= "00001111";
    In_C <= "00111100";
    In_D <= "11000011";

    process
    begin
        Sel <= "00";
        wait for STEP;
        Sel <= "01";
        wait for STEP;
        Sel <= "11";
        wait for STEP;
        Sel <= "10";
        wait for STEP;
    wait;
    end process;
end behavior;