library IEEE;
use IEEE.std_logic_1164.all;

entity Mux2x08 is
    port (
        a   : in  std_logic_vector(7 downto 0); 
        b   : in  std_logic_vector(7 downto 0);
        sel : in  std_logic;
        q   : out std_logic_vector(7 downto 0)
    ); 
end Mux2x08;

architecture logic of Mux2x08 is
begin
    q <= a when sel = '0' else b;
end logic;