library IEEE;
use IEEE.std_logic_1164.all;

entity TestCLAdder08 is
end TestCLAdder08;

architecture behavior of TestCLAdder08 is
    constant STEP : Time := 100 ns;

    signal In_X : std_logic_vector(7 downto 0);
    signal IN_Y : std_logic_vector(7 downto 0);
    signal IN_C : std_logic;
    signal s    : std_logic_vector(7 downto 0);
    signal c    : std_logic;

    component CLAdder08
        port (
            x   : in  std_logic_vector(7 downto 0);
            y   : in  std_logic_vector(7 downto 0);
            cin : in  std_logic;
            s   : out std_logic_vector(7 downto 0);
            c   : out std_logic
        );
    end component;

begin
    Adder : CLAdder08 port map (IN_X, IN_Y, IN_C, s, c);

    process
    begin
        In_X <= "00000000";
        In_Y <= "11111111";
        IN_C <= '0';
        wait for STEP;
        In_X <= "00110011";
        In_Y <= "00110011";
        IN_C <= '0';
        wait for STEP;
        In_X <= "00110011";
        In_Y <= "00110011";
        IN_C <= '1';
        wait for STEP;
        In_X <= "01111111";
        In_Y <= "10000001";
        IN_C <= '0';
        wait for STEP;
        In_X <= "11111111";
        In_Y <= "11111111";
        IN_C <= '0';
        wait for STEP;
        In_X <= "11111111";
        In_Y <= "00000000";
        IN_C <= '1';
        wait for STEP;
        In_X <= "11111111";
        In_Y <= "00000010";
        IN_C <= '1';
        wait for STEP;
    wait;
    end process;
end behavior;