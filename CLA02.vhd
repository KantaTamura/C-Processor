library IEEE;
use IEEE.std_logic_1164.all;

entity CLA02 is
    port (
        g   : in  std_logic_vector(1 downto 0);
        p   : in  std_logic_vector(1 downto 0);
        cin : in  std_logic;
        s   : out std_logic_vector(1 downto 0);
        c   : out std_logic_vector(1 downto 0)
    );
end CLA02;

architecture rtl of CLA02 is
    signal carry : std_logic_vector(1 downto 0);
begin
    carry(0) <= not ((not g(0)) and (not (p(0) and cin)));
    carry(1) <= not ((not g(1)) and (not (p(1) and g(0))) and (not (p(1) and p(0) and cin)));

    s(0) <= p(0) xor cin;
    s(1) <= carry(0) xor p(1);
    c <= carry;
end rtl;