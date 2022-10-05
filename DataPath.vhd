library IEEE;
use IEEE.std_logic_1164.all;

entity DataPath is
    port (
        DataIn     : in  std_logic_vector(7 downto 0);
        IRout      : out std_logic_vector(7 downto 0);

        Address    : out std_logic_vector(15 downto 0);
        DataOut    : out std_logic_vector(7 downto 0);

        CarryF     : out std_logic;
        ZeroF      : out std_logic;

        modeALU    : in  std_logic_vector(3 downto 0);
        selMuxDOut : in std_logic_vector(1 downto 0);
        loadRegA   : in  std_logic;
        loadRegB   : in  std_logic;
        loadRegC   : in  std_logic;
        loadFC     : in  std_logic;
        loadFZ     : in  std_logic;

        selMuxAddr : in  std_logic;
        loadIR     : in  std_logic;
        loadhIX    : in  std_logic;
        loadlIX    : in  std_logic;
        loadhMB    : in  std_logic;
        loadlMB    : in  std_logic;

        selMuxDIn  : in  std_logic;
        loadIP     : in  std_logic;
        incIP      : in  std_logic;
        inc2IP     : in  std_logic;
        clearIP    : in  std_logic;

        clock      : in  std_logic;
        reset      : in  std_logic
    );
end DataPath;

architecture logic of DataPath is
    component Register01
        port (
            d     : in  std_logic;
            load  : in  std_logic;
            clock : in std_logic;
            reset : in  std_logic;
            q     : out std_logic
        );
    end component;

    component Register08
        port (
            d     : in  std_logic_vector(7 downto 0);
            load  : in  std_logic;
            clock : in  std_logic;
            reset : in  std_logic;
            q     : out std_logic_vector(7 downto 0)
        );
    end component; 

    component Register16in2
        port (
            dH    : in  std_logic_vector(7 downto 0);
            dL    : in  std_logic_vector(7 downto 0);
            loadh : in  std_logic;
            loadl : in  std_logic;
            clock : in  std_logic;
            reset : in  std_logic;
            q     : out std_logic_vector(15 downto 0)
        );
    end component;
    
    component ALU16
        port (
            a    : in  std_logic_vector(7 downto 0);
            b    : in  std_logic_vector(7 downto 0);
            cin  : in  std_logic;
            mode : in  std_logic_vector(3 downto 0);
            fout : out std_logic_vector(7 downto 0);
            cout : out std_logic;
            zout : out std_logic
        );
    end component;

    component Counter16
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
    end component;

    component Mux2x08
        port (
            a   : in  std_logic_vector(7 downto 0);
            b   : in  std_logic_vector(7 downto 0);
            sel : in  std_logic;
            q   : out std_logic_vector(7 downto 0)
        );
    end component;

    component Mux2x16
        port (
            a   : in  std_logic_vector(15 downto 0); 
            b   : in  std_logic_vector(15 downto 0);
            sel : in  std_logic;
            q   : out std_logic_vector(15 downto 0)
        );
    end component;

    component Mux4x08
        port (
            a   : in  std_logic_vector(7 downto 0);
            b   : in  std_logic_vector(7 downto 0);
            c   : in  std_logic_vector(7 downto 0);
            d   : in  std_logic_vector(7 downto 0);
            sel : in  std_logic_vector(1 downto 0);
            q   : out std_logic_vector(7 downto 0)
        );
    end component;

    signal qRegA      : std_logic_vector(7 downto 0);
    signal qRegB      : std_logic_vector(7 downto 0);
    signal qRegC      : std_logic_vector(7 downto 0);
    signal qMB        : std_logic_vector(15 downto 0);
    signal qIX        : std_logic_vector(15 downto 0);
    signal qIP        : std_logic_vector(15 downto 0);
    signal foutALU    : std_logic_vector(7 downto 0);
    signal coutALU    : std_logic;
    signal zoutALU    : std_logic;
    signal DataInTmp  : std_logic_vector(7 downto 0);

    signal zero       : std_logic;
    signal zero_vec   : std_logic_vector(7 downto 0);

begin
    zero <= '0';
    zero_vec <= "00000000";

    FC      : Register01 port map (coutALU, loadFC, clock, reset, CarryF);
    FZ      : Register01 port map (zoutALU, loadFZ, clock, reset, ZeroF);
    RegA    : Register08 port map (DataInTmp, loadRegA, clock, reset, qRegA);
    RegB    : Register08 port map (DataInTmp, loadRegB, clock, reset, qRegB);
    RegC    : Register08 port map (DataInTmp, loadRegC, clock, reset, qRegC);
    IR      : Register08 port map (DataIn, loadIR, clock, reset, IRout);
    IX      : Register16in2 port map (DataIn, DataIn, loadhIX, loadlIX, clock, reset, qIX);
    MB      : Register16in2 port map (DataIn, DataIn, loadhMB, loadlMB, clock, reset, qMB);
    MuxDIn  : Mux2x08 port map (foutALU, DataIn, selMuxDIn, DataInTmp);
    MuxAddr : Mux2x16 port map (qIP, qIX, selMuxAddr, Address);
    MuxDOut : Mux4x08 port map (qRegA, qRegB, qRegC, zero_vec, selMuxDOut, DataOut);
    IP      : Counter16 port map (clock, loadIP, qMB, incIP, inc2IP, clearIP, reset, qIP);
    ALU     : ALU16 port map (qRegA, qRegB, zero, modeALU, foutALU, coutALU, zoutALU);

end logic;