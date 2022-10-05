library IEEE;
use IEEE.std_logic_1164.all;

entity Mux2x16 is
    port (
        a   : in  std_logic_vector(15 downto 0);
        b   : in  std_logic_vector(15 downto 0);
        sel : in  std_logic;
        q   : out std_logic_vector(15 downto 0)
    );
end Mux2x16;

architecture logic of Mux2x16 is
begin
    q <= a when sel = '0' else b;
end logic;