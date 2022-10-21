library IEEE;
use IEEE.std_logic_1164.all;

entity Johnson3L0 is
  port (
    cond0 : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic_vector(2 downto 0)
  );
end Johnson3L0;

architecture logic of Johnson3L0 is
component Register01
  port (
    d     : in  std_logic;
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
      );
end component;

signal result : std_logic_vector(2 downto 0);
signal stop1  : std_logic;
signal one    : std_logic;

begin

one <= '1';
stop1 <= ( result(0) or cond0 ) and not result(2) ;

jc1 : Register01
  port map(
  d     => stop1,
  load  => one,
  clock => clock,
  reset => reset,
  q     => result(0)
  );

jc2 : Register01
  port map(
  d     => result(0),
  load  => one,
  clock => clock,
  reset => reset,
  q     => result(1)
  );

jc3 : Register01
  port map(
  d     => result(1),
  load  => one,
  clock => clock,
  reset => reset,
  q     => result(2)
  );
q <= result;

end logic;