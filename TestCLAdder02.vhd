library IEEE;
use IEEE.std_logic_1164.all;

entity TestCLAdder02 is
end TestCLAdder02;

architecture behavior of TestCLAdder02 is
    constant STEP : Time := 100 ns;

    signal In_X : std_logic_vector(1 downto 0);
    signal IN_Y : std_logic_vector(1 downto 0);
    signal IN_C : std_logic;
    signal s    : std_logic_vector(1 downto 0);
    signal c    : std_logic;

    component CLAdder02
        port (
            x   : in  std_logic_vector(1 downto 0);
            y   : in  std_logic_vector(1 downto 0);
            cin : in  std_logic;
            s   : out std_logic_vector(1 downto 0);
            c   : out std_logic
        );
    end component;

begin
    Adder : CLAdder02 port map (IN_X, IN_Y, IN_C, s, c);

    process
    begin
        In_X <= "00";
        In_Y <= "11";
        IN_C <= '0';
        wait for STEP;
        In_X <= "01";
        In_Y <= "01";
        IN_C <= '0';
        wait for STEP;
        In_X <= "01";
        In_Y <= "01";
        IN_C <= '1';
        wait for STEP;
        In_X <= "11";
        In_Y <= "00";
        IN_C <= '1';
        wait for STEP;
    wait;
    end process;
end behavior;