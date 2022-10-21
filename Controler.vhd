library ieee;
use ieee.std_logic_1164.all;

entity Controler is
    port (
        selMuxDIn : out std_logic;

        loadhMB : out std_logic;
        loadlMB : out std_logic;
        loadhIX : out std_logic;
        loadlIX : out std_logic;

        loadIR : out std_logic;
        IRout  : in std_logic_vector(7 downto 0);

        loadIP  : out std_logic;
        incIP   : out std_logic;
        inc2IP  : out std_logic;
        clearIP : out std_logic;

        selMuxDOut : out std_logic_vector(1 downto 0);
        selMuxAddr : out std_logic;

        ZeroF  : in std_logic;
        CarryF : in std_logic;

        loadRegA : out std_logic;
        loadRegB : out std_logic;
        loadRegC : out std_logic;

        modeALU : out std_logic_vector(3 downto 0);
        loadFZ  : out std_logic;
        loadFC  : out std_logic;

        read  : out std_logic;
        write : out std_logic;

        clock : in std_logic;
        reset : in sed_logic;
    );
end Controler;

architecture logic of Controler is
    component Johnson1L0
        port (
            cond0 : in  std_logic;
            clock : in  std_logic;
            reset : in  std_logic;
            q     : out std_logic
        );
    end component;

    component Johnson1L1 
        port (
            cond1 : in  std_logic;
            clock : in  std_logic;
            reset : in  std_logic;
            q     : out std_logic
        );
    end component;

    component Johnson1L01 
        port (
            cond0 : in  std_logic;
            cond1 : in  std_logic;
            clock : in  std_logic;
            reset : in  std_logic;
            q     : out std_logic
        );
    end component;

    component Johnson2L0 
        port (
            cond0 : in  std_logic;
            clock : in  std_logic;
            reset : in  std_logic;
            q     : out std_logic_vector(1 downto 0)
        );
    end component;

    component Johnson3L0 
        port (
            cond0 : in  std_logic;
            clock : in  std_logic;
            reset : in  std_logic;
            q     : out std_logic_vector(2 downto 0)
        );
    end component;

    -- 

    signal qJCextA : std_logic;
    signal qJCextB : std_logic;
    signal qJCextC : std_logic_vector(1 downto 0);
    signal qJCextD : std_logic_vector(1 downto 0);
    signal qJCextE : std_logic_vector(2 downto 0);

    signal cJCextA : std_logic;
    signal cJCextB : std_logic;
    signal cJCextC : std_logic;
    signal cJCextD : std_logic;
    signal cJCextE : std_logic;

    signal cs1 : std_logic;
    signal cs1 : std_logic;

    --

    signal qJCintA : std_logic;
    signal qJCintB : std_logic_vector(1 downto 0);
    signal qJCintC : std_logic_vector(1 downto 0);
    signal qJCintD : std_logic;
    signal qJCintE : std_logic_vector(1 downto 0);
    signal qJCintF : std_logic_vector(2 downto 0);

    signal cact : std_logic;

    signal cJCintB : std_logic;
    signal cJCintC : std_logic;
    signal cJCintD : std_logic;
    signal cJCintE : std_logic;
    signal cJCintF : std_logic;

    --

    signal one : std_logic;

begin
    one <= '1';
end logic;