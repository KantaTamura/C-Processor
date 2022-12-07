library IEEE;
use IEEE.std_logic_1164.all;

entity CLAdder02 is
    port (
        x   : in  std_logic_vector(1 downto 0);
        y   : in  std_logic_vector(1 downto 0);
        cin : in  std_logic;
        s   : out std_logic_vector(1 downto 0);
        c   : out std_logic
    );
end CLAdder02;

architecture rtl of CLAdder02 is
    signal g, p  : std_logic_vector(1 downto 0);
    signal carry : std_logic_vector(1 downto 0);

    component HalfAdder
        port (
            x   : in  std_logic;
            y   : in  std_logic;
            s   : out std_logic;
            c   : out std_logic
        );
    end component;
    component CLA02
        port (
            g   : in  std_logic_vector(1 downto 0);
            p   : in  std_logic_vector(1 downto 0);
            cin : in  std_logic;
            s   : out std_logic_vector(1 downto 0);
            c   : out std_logic_vector(1 downto 0)
        );
    end component;
begin
    add_gen : for i in 0 to 1 generate
        adder : HalfAdder port map (x(i), y(i), p(i), g(i));
    end generate add_gen;
    CLA : CLA02 port map (g, p, cin, s, carry);
    c <= carry(1);
end rtl;