library IEEE;
use IEEE.std_logic_1164.all;

entity RCAdder16 is
    port (
        x     : in  std_logic_vector(15 downto 0);
        y     : in  std_logic_vector(15 downto 0);
        cin   : in  std_logic;
        s     : out std_logic_vector(15 downto 0);
        c     : out std_logic
    );
end RCAdder16;

architecture rtl of RCAdder16 is
    component FullAdder
        port (
            x     : in  std_logic;
            y     : in  std_logic;
            cin   : in  std_logic;
            s     : out std_logic;
            c     : out std_logic
        );
    end component;

    signal carry : std_logic_vector(16 downto 0);

begin
    carry(0) <= cin;
    adder_generate: for i in 0 to 15 generate
        adderi : FullAdder port map (x(i), y(i), carry(i), s(i), carry(i+1));
    end generate adder_generate;
    c <= carry(16);
end rtl;