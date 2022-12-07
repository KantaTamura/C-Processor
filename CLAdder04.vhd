library IEEE;
use IEEE.std_logic_1164.all;

entity CLAdder04 is
    port (
        x   : in  std_logic_vector(3 downto 0);
        y   : in  std_logic_vector(3 downto 0);
        cin : in  std_logic;
        s   : out std_logic_vector(3 downto 0);
        c   : out std_logic
    );
end CLAdder04;

architecture rtl of CLAdder04 is
    signal lg, lp  : std_logic_vector(3 downto 0);
    signal buf_g, buf_p : std_logic;
    signal carry : std_logic_vector(3 downto 0);

    component HalfAdder
        port (
            x   : in  std_logic;
            y   : in  std_logic;
            s   : out std_logic;
            c   : out std_logic
        );
    end component;
    component CLA04
        port (
            g   : in  std_logic_vector(3 downto 0);
            p   : in  std_logic_vector(3 downto 0);
            cin : in  std_logic;
            s   : out std_logic_vector(3 downto 0);
            c   : out std_logic_vector(3 downto 0);
            bP   : out std_logic;
            bG   : out std_logic
        );
    end component;
begin
    add_gen : for i in 0 to 3 generate
        adder : HalfAdder port map (x(i), y(i), lp(i), lg(i));
    end generate add_gen;
    cla : CLA04 port map (lg, lp, cin, s, carry, buf_p, buf_g);
    c <= carry(3);
end rtl;