library IEEE;
use IEEE.std_logic_1164.all;

entity Johnson2L0 is
  port (
    cond0 : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic_vector(1 downto 0)
  );
end Johnson2L0;

architecture logic of Johnson2L0 is
component Register01
  port (
    d     : in  std_logic;
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
  );
end component;

signal result : std_logic_vector(1 downto 0);
signal stop1  : std_logic;
signal one    : std_logic;

begin
one <= '1';

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

q <= result;

stop1 <= not result(1) and ( result(0) or cond0);

end logic;