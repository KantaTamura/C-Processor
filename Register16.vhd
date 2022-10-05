library IEEE;
use IEEE.std_logic_1164.all;

entity Register16 is
    port (
        d     : in  std_logic_vector(15 downto 0);
        load  : in  std_logic;
        clock : in  std_logic;
        reset : in  std_logic;
        q     : out std_logic_vector(15 downto 0)
    );
end Register16;

architecture logic of Register16 is
    signal Dtmp : std_logic_vector(15 downto 0);
    signal Qtmp : std_logic_vector(15 downto 0);

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
    Generate_Registers : for i in 0 to 15 generate
        dffi : dff port map (Dtmp(i), clock, reset, Qtmp(i));
        Dtmp(i) <= (Qtmp(i) and not load) or ( d(i) and load );
        q(i) <= Qtmp(i);
    end generate Generate_Registers;
end logic;