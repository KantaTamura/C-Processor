library IEEE;
use IEEE.std_logic_1164.all;

entity Register01 is
    port (
        d     : in  std_logic;
        load  : in  std_logic;
        clock : in  std_logic;
        reset : in  std_logic;
        q     : out std_logic
    );
end Register01;

architecture logic of Register01 is
    signal Dtmp : std_logic;
    signal Qtmp : std_logic;

    component DFF
        port (
            d   : in  std_logic;
            clk : in  std_logic;
            rst : in  std_logic;
            q   : out std_logic;
            qb  : out std_logic
        );
    end component;

begin 
    dff1 : dff port map (Dtmp, clock, reset, Qtmp);
    Dtmp <= ( Qtmp and not load ) or ( d and load );
    q <= Qtmp;
end logic;