library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is
    port (
        d   : in  std_logic;
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic;
        qb  : out std_logic
    );
end DFF;

architecture logic of DFF is
begin 
    dff : process (clk)
    begin
        if clk'event and clk = '1' then
            if( rst = '1' ) then
                q <= '0';
            else  
                q  <= d;
                qb <= not d;
            end if;
        end if;
    end process DFF;
end logic;