library IEEE;
use IEEE.std_logic_1164.all;

entity Register16in2 is
    port (
        dh    : in  std_logic_vector(7 downto 0);
        dl    : in  std_logic_vector(7 downto 0);
        loadh : in  std_logic;
        loadl : in  std_logic;
        clock : in  std_logic;
        reset : in  std_logic;
        q     : out std_logic_vector(15 downto 0)
    );
end Register16in2;

architecture logic of Register16in2 is
    component Register08
        port (
            d     : in  std_logic_vector(7 downto 0);
            load  : in  std_logic;
            clock : in  std_logic;
            reset : in  std_logic;
            q     : out std_logic_vector(7 downto 0)
        );
    end component;

begin
    RegH : Register08 port map(dh, loadh, clock, reset, q(15 downto 8));
    RegL : Register08 port map(dl, loadl, clock, reset, q(7 downto 0));
end logic;