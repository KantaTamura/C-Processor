library IEEE;
use IEEE.std_logic_1164.all;

entity CLAdder16 is
    port (
        x   : in  std_logic_vector(15 downto 0);
        y   : in  std_logic_vector(15 downto 0);
        cin : in  std_logic;
        s   : out std_logic_vector(15 downto 0);
        c   : out std_logic
    );
end CLAdder16;

architecture rtl of CLAdder16 is
    signal g, p  : std_logic_vector(15 downto 0);
    signal ng, np : std_logic_vector(3 downto 0);
    signal buf_g, buf_p : std_logic;
    signal buf_carry1 : std_logic_vector(3 downto 0);
    signal buf_carry2 : std_logic_vector(3 downto 0);
    signal buf_carry3 : std_logic_vector(3 downto 0);
    signal buf_carry4 : std_logic_vector(3 downto 0);
    signal carry : std_logic_vector(3 downto 0);
    signal buf_s : std_logic_vector(3 downto 0);

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
    add_gen : for i in 0 to 15 generate
        adder : HalfAdder port map (x(i), y(i), p(i), g(i));
    end generate add_gen;
    CLA4_1 : CLA04 port map (g(3 downto 0)  , p(3 downto 0)  , cin     , s(3 downto 0)  , buf_carry1, np(0), ng(0));
    CLA4_2 : CLA04 port map (g(7 downto 4)  , p(7 downto 4)  , carry(0), s(7 downto 4)  , buf_carry2, np(1), ng(1));
    CLA4_3 : CLA04 port map (g(11 downto 8) , p(11 downto 8) , carry(1), s(11 downto 8) , buf_carry3, np(2), ng(2));
    CLA4_4 : CLA04 port map (g(15 downto 12), p(15 downto 12), carry(2), s(15 downto 12), buf_carry4, np(3), ng(3));
    CLA4   : CLA04 port map (ng, np, cin, buf_s, carry, buf_p, buf_g);
    c <= carry(3);
end rtl;