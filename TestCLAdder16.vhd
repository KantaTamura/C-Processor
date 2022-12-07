library IEEE;
use IEEE.std_logic_1164.all;

entity TestCLAdder16 is
end TestCLAdder16;

architecture behavior of TestCLAdder16 is
    constant STEP : Time := 100 ns;

    signal In_X : std_logic_vector(15 downto 0);
    signal IN_Y : std_logic_vector(15 downto 0);
    signal IN_C : std_logic;
    signal s    : std_logic_vector(15 downto 0);
    signal c    : std_logic;

    component CLAdder16
        port (
            x   : in  std_logic_vector(15 downto 0);
            y   : in  std_logic_vector(15 downto 0);
            cin : in  std_logic;
            s   : out std_logic_vector(15 downto 0);
            c   : out std_logic
        );
    end component;

begin
    Adder : CLAdder16 port map (IN_X, IN_Y, IN_C, s, c);

    process
    begin
        In_X <= "0000000000000000";
        In_Y <= "1111111111111111";
        IN_C <= '0';
        wait for STEP;
        In_X <= "0011001100110011";
        In_Y <= "0011001100110011";
        IN_C <= '0';
        wait for STEP;
        In_X <= "0011001100110011";
        In_Y <= "0011001100110011";
        IN_C <= '1';
        wait for STEP;
        In_X <= "0111111111111111";
        In_Y <= "1000000000000001";
        IN_C <= '0';
        wait for STEP;
        In_X <= "1111111111111111";
        In_Y <= "1111111111111111";
        IN_C <= '0';
        wait for STEP;
        In_X <= "1111111111111111";
        In_Y <= "0000000000000000";
        IN_C <= '1';
        wait for STEP;
        In_X <= "1111111111111111";
        In_Y <= "0000000000000010";
        IN_C <= '1';
        wait for STEP;
    wait;
    end process;
end behavior;