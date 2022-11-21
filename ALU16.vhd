-- mode
-- 
-- "0000" : A + B -- "0100" : ^A    -- "1000" : ^B
-- "0001" : A - B -- "0101" : A + 1 -- "1001" : B + 1
-- "0010" : A & B -- "0110" : A - 1 -- "1010" : B - 1
-- "0011" : A | B

library IEEE;
use IEEE.std_logic_1164.all;

entity ALU16 is
    port (
        a    : in  std_logic_vector(7 downto 0);
        b    : in  std_logic_vector(7 downto 0);
        cin  : in  std_logic;
        mode : in  std_logic_vector(3 downto 0);
        fout : out std_logic_vector(7 downto 0);
        cout : out std_logic;
        zout : out std_logic
    );
end ALU16;

architecture logic of ALU16 is
    component RCAdder08
        port (
            x   : in  std_logic_vector(7 downto 0);
            y   : in  std_logic_vector(7 downto 0);
            cin : in  std_logic;
            s   : out std_logic_vector(7 downto 0);
            c   : out std_logic
        );
    end component;

    signal result       : std_logic_vector(7 downto 0);
    signal result_adder : std_logic_vector(7 downto 0);
    signal result_logic : std_logic_vector(7 downto 0);
    signal complement_b : std_logic_vector(7 downto 0);
    signal in_A         : std_logic_vector(7 downto 0);
    signal in_B         : std_logic_vector(7 downto 0);
    signal cout_tmp     : std_logic;
    signal cout_tmp2    : std_logic;
    signal cin_tmp      : std_logic;

begin

    cin_tmp <= cin;

    complement : RCAdder08 port map ("not"(b), "00000001", cin_tmp, complement_b, cout_tmp2);

    in_A <= b when mode = "1001" or mode = "1010" else a;
    in_B <= b            when mode = "0000" else
            complement_b when mode = "0001" else
            "00000001"   when mode = "0101" or mode = "1001" else
            "11111111"   when mode = "0110" or mode = "1010" else
            "00000000";
    
    adder : RCAdder08 port map (in_A, in_B, cin_tmp, result_adder, cout_tmp);

    zout <= '1' when result = "00000000" else '0';
    
    cout <= cout_tmp;

    result_logic <= (not a) when mode = "0100" else
                    (not b) when mode = "1000" else
                    "00000000";
    
    result <= result_adder when mode = "0000" or mode = "0001" or mode = "0101" or mode = "0110" or mode = "1001" or mode = "1010" else
              (a and b)    when mode = "0010" else
              (a or  b)    when mode = "0011" else
              result_logic;
    
    fout <= result;

end logic;
    