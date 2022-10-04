library IEEE;
use IEEE.std_logic_1164.all;

entity FullAdder is
    port (
        x   : in  std_logic;
        y   : in  std_logic;
        cin : in  std_logic;
        s   : out std_logic;
        c   : out std_logic
    );
end FullAdder;

architecture rtl of FullAdder is
begin
    s <= x xor y xor cin;
    c <= (x and y) or ((x or y) and cin);
end rtl;