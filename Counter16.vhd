Library IEEE;
use IEEE.std_logic_1164.all;

entity Counter16 is
    port (
        clock : in  std_logic;
        load  : in  std_logic;
        d     : in  std_logic_vector(15 downto 0);
        inc   : in  std_logic;
        inc2  : in  std_logic;
        clear : in  std_logic;
        reset : in  std_logic;
        q     : out std_logic_vector(15 downto 0)
    );
end Counter16;

architecture logic of Counter16 is
    component RCAdder16
        port (
            x     : in  std_logic_vector(15 downto 0);
            y     : in  std_logic_vector(15 downto 0);
            cin   : in  std_logic;
            s     : out std_logic_vector(15 downto 0);
            c     : out std_logic
        );
    end component;

    component Register16
        port (
            d     : in  std_logic_vector(15 downto 0);
            load  : in  std_logic;
            clock : in  std_logic;
            reset : in  std_logic;
            q     : out std_logic_vector(15 downto 0)
        );
    end component;

    signal data           : std_logic_vector(15 downto 0);
    signal zero           : std_logic;
    signal load_in        : std_logic;
    signal add_result     : std_logic_vector(15 downto 0);
    signal data_in        : std_logic_vector(15 downto 0);
    signal result         : std_logic_vector(15 downto 0);
    signal carry          : std_logic;

begin 
    reg : register16 port map (data_in, load_in, clock, reset, result);

    q <= result;

    data_in <= d           when load = '1'               else
                add_result when inc  = '1' or inc2 = '1' else
                "0000000000000000";

    load_in <= '1' when load = '1' or inc = '1' or clear = '1' or inc2 = '1' else
               '0';

    adder : RCAdder16 port map (result, data, zero, add_result, carry);

    data <= "0000000000000001" when inc = '1' else "0000000000000010";
    
    zero <= '0';
    
end logic;