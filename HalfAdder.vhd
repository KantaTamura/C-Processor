library IEEE;
use IEEE.std_logic_1164.all;

entity HalfAdder is
    port (
        x   : in  std_logic;
        y   : in  std_logic;
        s   : out std_logic;
        c   : out std_logic
    );
end HalfAdder;

architecture rtl of HalfAdder is
begin
    s <= x xor y;
    c <= x and y;
end rtl;