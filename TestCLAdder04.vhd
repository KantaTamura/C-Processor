library IEEE;
use IEEE.std_logic_1164.all;

entity TestCLAdder04 is
end TestCLAdder04;

architecture behavior of TestCLAdder04 is
    constant STEP : Time := 100 ns;

    signal In_X : std_logic_vector(3 downto 0);
    signal IN_Y : std_logic_vector(3 downto 0);
    signal IN_C : std_logic;
    signal s    : std_logic_vector(3 downto 0);
    signal c    : std_logic;

    component CLAdder04
        port (
            x   : in  std_logic_vector(3 downto 0);
            y   : in  std_logic_vector(3 downto 0);
            cin : in  std_logic;
            s   : out std_logic_vector(3 downto 0);
            c   : out std_logic
        );
    end component;

begin
    Adder : CLAdder04 port map (IN_X, IN_Y, IN_C, s, c);

    process
    begin
        In_X <= "0000";
        In_Y <= "1111";
        IN_C <= '0';
        wait for STEP;
        In_X <= "0011";
        In_Y <= "0011";
        IN_C <= '0';
        wait for STEP;
        In_X <= "0011";
        In_Y <= "0011";
        IN_C <= '1';
        wait for STEP;
        In_X <= "0111";
        In_Y <= "1001";
        IN_C <= '0';
        wait for STEP;
    wait;
    end process;
end behavior;