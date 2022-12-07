library IEEE;
use IEEE.std_logic_1164.all;

entity CLA04 is
    port (
        g   : in  std_logic_vector(3 downto 0);
        p   : in  std_logic_vector(3 downto 0);
        cin : in  std_logic;
        s   : out std_logic_vector(3 downto 0);
        c   : out std_logic_vector(3 downto 0);
        bP   : out std_logic;
        bG   : out std_logic
    );
end CLA04;

architecture rtl of CLA04 is
    signal lg, lp : std_logic;
    signal carry  : std_logic_vector(3 downto 0);
begin
    carry(0) <= not ((not g(0)) and (not (p(0) and cin)));
    carry(1) <= not ((not g(1)) and (not (p(1) and g(0))) and (not (p(1) and p(0) and cin)));
    carry(2) <= not ((not g(2)) and (not (p(2) and g(1))) and (not (p(2) and p(1) and g(0))) and (not (p(2) and p(1) and p(0) and cin)));
    lg <= not ((not g(3)) and (not (p(3) and g(2))) and (not (p(3) and p(2) and g(1))) and (not (p(3) and p(2) and p(1) and g(0))));
    lp <= p(3) and p(2) and p(1) and p(0);
    carry(3) <= not ((not lg) and (not (lp and cin)));

    s(0) <= p(0) xor cin;
    s(1) <= carry(0) xor p(1);
    s(2) <= carry(1) xor p(2);
    s(3) <= carry(2) xor p(3);
    c <= carry;
    bP <= lp;
    bG <= lg;
end rtl;