library IEEE;
use IEEE.std_logic_1164.all;

entity Johnson1L1 is
  port (
    cond1 : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
  );
end Johnson1L1;

architecture logic of Johnson1L1 is
component Register01
  port (
    d     : in  std_logic;
    load  : in  std_logic;
    clock : in  std_logic;
    reset : in  std_logic;
    q     : out std_logic
  );
end component;

signal result : std_logic;
signal stop1  : std_logic;
signal one    : std_logic;

begin
one <= '1';
stop1 <= (result and not cond1) or not result ;

jc1 : Register01
  port map(
  d     => stop1,
  load  => one,
  clock => clock,
  reset => reset,
  q     => result
  );

q <= result;

end logic;