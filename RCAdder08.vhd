library IEEE;
use IEEE.std_logic_1164.all;

entity RCAdder08 is
    port (
        x   : in  std_logic_vector(7 downto 0);
        y   : in  std_logic_vector(7 downto 0);
        cin : in  std_logic;
        s   : out std_logic_vector(7 downto 0);
        c   : out std_logic
    );
end RCAdder08;

architecture rtl of RCAdder08 is
    component FullAdder
        port (
            x   : in  std_logic;
            y   : in  std_logic;
            cin : in  std_logic;
            s   : out std_logic;
            c   : out std_logic
        );
    end component;

    signal carry : std_logic_vector(8 downto 0);

begin
    carry(0) <= cin;
    add_gen : for i in 0 to 7 generate
        adderi : FullAdder port map (x(i), y(i), carry(i), s(i), carry(i + 1));
    end generate add_gen;
    c <= carry(8);
end rtl;