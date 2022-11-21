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
        reset : in std_logic
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
    signal cs2 : std_logic;

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

    --

    JCextA : Johnson1L01 port map(cJCextA, cs1, clock, reset, qJCextA);
    JCextB : Johnson1L01 port map(cJCextB, cs2, clock, reset, qJCextB);
    JCextC : Johnson2L0  port map(cJCextC, clock, reset, qJCextC);
    JCextD : Johnson2L0  port map(cJCextD, clock, reset, qJCextD);
    JCextE : Johnson3L0  port map(cJCextE, clock, reset, qJCextE);

    --

    selMuxDOut <= "01" when qJCextD = "01" else
                  "01" when qJCextD = "11" else
                  "01" when qJCextD = "10" else
                  "10" when qJCextE = "111" else
                  "10" when qJCextE = "110" else
                  "10" when qJCextE = "100" else
                  "00";

    selMuxAddr <= '1' when qJCextB = '1' else
                  '1' when qJCextC = "01" else
                  '1' when qJCextC = "11" else
                  '1' when qJCextC = "10" else
                  '1' when qJCextD = "01" else
                  '1' when qJCextD = "11" else
                  '1' when qJCextD = "10" else
                  '1' when qJCextE = "111" else
                  '1' when qJCextE = "110" else
                  '1' when qJCextE = "100" else
                  '0';

    read <= '0' when qJCextA = '1' else
            '0' when qJCextB = '1' else
            '0' when qJCextE = "001" else
            '0' when qJCextE = "011" else
            '1';

    write <= '0' when qJCextC = "11" else
             '0' when qJCextD = "11" else
             '0' when qJCextE = "110" else
             '1';

    --

    JCintA : Johnson1L1 port map(cact, clock, reset, qJCintA);
    JCintB : Johnson2L0 port map(cJCintB, clock, reset, qJCintB);
    JCintC : Johnson2L0 port map(cJCintC, clock, reset, qJCintC);
    JCintD : Johnson1L0 port map(cJCintD, clock, reset, qJCintD);
    JCintE : Johnson2L0 port map(cJCintE, clock, reset, qJCintE);
    JCintF : Johnson3L0 port map(cJCintF, clock, reset, qJCintF);

    --

    cJCextA <= '1' when qJCintA = '0' else
               '1' when qJCintB = "10" and irout(7 downto 4) = "1101" else -- SETIXH, SETIXL, LDIA, LDIB
               '1' when qJCintB = "10" and irout(7 downto 4) = "0110" else -- JP
               '1' when qJCintB = "10" and irout(7 downto 4) = "0100" and CarryF = '1' else -- JPC (C = 1)
               '1' when qJCintB = "10" and irout(7 downto 4) = "0101" and ZeroF = '1' else -- JPZ (Z = 1)
               '1' when qJCintC = "11" and irout(7 downto 4) = "1110" else -- LDDA, LDDB
               '1' when qJCintD = '1' else
               '1' when qJCintE = "10" else
               '1' when qJCintF = "100" else
               '0';

    cJCextB <= '1' when qJCintB = "10" and irout(7 downto 4) = "1110" else -- LDDA, LDDB
               '0';

    cJCextC <= '1' when qJCintB = "10" and irout(7 downto 2) = "111100" else -- STDA
               '0';

    cJCextD <= '1' when qJCintB = "10" and irout(7 downto 2) = "111101" else -- STDB
               '0';

    cJCextE <= '1' when qJCintB = "10" and irout(7 downto 2) = "111110" else -- STDI
               '0';

    cs1 <= '1' when qJCintB = "11" else
           '1' when qJCintF = "110" and irout(7 downto 4) = "0110" else -- JP
           '1' when qJCintF = "110" and irout(7 downto 4) = "0100" and CarryF = '1' else -- JPC (C = 1)
           '1' when qJCintF = "110" and irout(7 downto 4) = "0101" and ZeroF = '1' else -- JPZ (Z = 1)
           '0';

    cs2 <= '1' when qJCintC = "10" and irout(7 downto 4) = "1110" else -- LDDA, LDDB
           '0';

    --

    cact <= '0';

    cJCintB <= '1' when qJCintA = '0'   else
               '1' when qJCintC = "11"  else
	           '1' when qJCintD = '1'   else
	           '1' when qJCintE = "10"  else
	           '1' when qJCintF = "100" else
	           '0';
    
    cJCintC <= '1' when qJCintB = "10" and irout(7 downto 4) = "1101" else -- SETIXH SETIXL LDIA LDIB
               '1' when qJCintB = "10" and irout(7 downto 4) = "1110" else -- LDDA, LDDB
               '0';

    cJCintD <= '1' when qJCintB = "10" and irout(7 downto 4) = "0000" else -- NOP
               '1' when qJCintB = "10" and irout(7 downto 6) = "10" else -- calc
               '1' when qJCintB = "10" and irout(7 downto 4) = "0100" and CarryF = '0' else -- JPC (C = 0)
               '1' when qJCintB = "10" and irout(7 downto 4) = "0101" and ZeroF = '0' else -- JPZ (Z = 0)
               '0';

    cJCintE <= '1' when qJCintB = "10" and irout(7 downto 3) = "11110" else -- STDA, STDB
               '0';
        
    cJCintF <= '1' when qJCintB = "10" and irout(7 downto 2) = "111110" else -- STDI
               '1' when qJCintB = "10" and irout(7 downto 4) = "0110" else -- JP
               '1' when qJCintB = "10" and irout(7 downto 4) = "0100" and CarryF = '1' else -- JPC (C = 1)
               '1' when qJCintB = "10" and irout(7 downto 4) = "0101" and ZeroF = '1' else -- JPZ (Z = 1)
               '0';

    --

    loadRegA <= '1' when qJCintC = "11" and irout = "11011000" else -- LDIA
                '1' when qJCintC = "11" and irout = "11100000" else -- LDDA
                '1' when qJCintD = '1' and irout(7 downto 4) = "1000" else -- calcA
                '0';

    loadRegB <= '1' when qJCintC = "11" and irout = "11011001" else -- LDIB
                '1' when qJCintC = "11" and irout = "11100001" else -- LDDB
                '1' when qJCintD = '1' and irout(7 downto 4) = "1001" else -- calcB
                '0';

    loadRegC <= '1' when qJCintF = "011" and irout(7 downto 3) = "11111" else -- STDI
                '0';

    loadFC <= '1' when qJCintD = '1' and irout(7 downto 6) = "10" else -- calc
              '0';

    loadFZ <= '1' when qJCintD = '1' and irout(7 downto 6) = "10" else -- calc
              '0';

    loadIR <= '1' when qJCintB = "11" else
              '0';

    loadhIX <= '1' when qJCintC = "11" and irout = "11010000" else -- SETIXH
               '0'; 

    loadlIX <= '1' when qJCintC = "11" and irout = "11010001" else -- SETIXL
               '0'; 

    loadhMB <= '1' when qJCintF = "011" and irout(7 downto 4) = "0110" else -- JP
               '1' when qJCintF = "011" and irout(7 downto 4) = "0100" and CarryF = '1' else -- JPC (C = 1)
               '1' when qJCintF = "011" and irout(7 downto 4) = "0101" and ZeroF = '1' else -- JPZ (Z = 1)
               '0';

    loadlMB <= '1' when qJCintF = "110" and irout(7 downto 4) = "0110" else -- JP
               '1' when qJCintF = "110" and irout(7 downto 4) = "0100" and CarryF = '1' else -- JPC (C = 1)
               '1' when qJCintF = "110" and irout(7 downto 4) = "0101" and ZeroF = '1' else -- JPZ (Z = 1)
               '0';
               
    loadIP <= '1' when qJCintF = "100" and irout(7 downto 4) = "0110" else -- JP
              '1' when qJCintF = "100" and irout(7 downto 4) = "0100" and CarryF = '1' else -- JPC (C = 1)
              '1' when qJCintF = "100" and irout(7 downto 4) = "0101" and ZeroF = '1' else -- JPZ (Z = 1)
              '0';
               
    selMuxDin <= '1' when qJCintC = "01" and irout(7 downto 3) = "11011" else -- LDIA, LDIB
                 '1' when qJCintC = "01" and irout(7 downto 4) = "1110" else -- LDDA, LDDB
                 '1' when qJCintC = "11" and irout(7 downto 3) = "11011" else -- LDIA, LDIB
                 '1' when qJCintC = "11" and irout(7 downto 4) = "1110" else -- LDDA, LDDB
                 '1' when qJCintF = "001" and irout(7 downto 3) = "11111" else -- STDI
                 '1' when qJCintF = "011" and irout(7 downto 3) = "11111" else -- STDI
                 '0';

    incIP <= '1' when qJCintB = "10" else
             '1' when qJCintC = "11" and irout(7 downto 4) = "1101" else -- SETIXH, SETIXL, LDIA, LDIB
             '1' when qJCintD = '1' and irout(7 downto 6) = "00" else -- NOP
             '1' when qJCintF = "011" else
             '0';

    inc2IP <= '1' when qJCintD = '1' and irout(7 downto 4) = "0110" else -- JP
              '1' when qJCintD = '1' and irout(7 downto 4) = "0100" and CarryF = '1' else -- JPC (C = 1)
              '1' when qJCintD = '1' and irout(7 downto 4) = "0101" and ZeroF = '1' else -- JPZ (Z = 1)
              '0';

    clearIP <= '1' when qJCintA = '0' else
               '0';

    modeALU <= irout(3 downto 0) when qJCintD = '1' and irout(7 downto 6) = "10" else -- ADDA ADDB INCA DECA 
             "0000";

end logic;