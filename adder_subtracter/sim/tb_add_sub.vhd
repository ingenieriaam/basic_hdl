library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity tb_add_sub is
end tb_add_sub;

architecture tb of tb_add_sub is
    constant Wt : natural:= 8;

    component add_sub
    generic(w:natural:=Wt);
        port (a  : in std_logic_vector (w-1 downto 0);
              b  : in std_logic_vector (w-1 downto 0);
              m  : in std_logic;
              r  : out std_logic_vector (w-1 downto 0);
              co : out std_logic);
    end component;

    

    signal a  : std_logic_vector (Wt-1 downto 0);
    signal b  : std_logic_vector (Wt-1 downto 0);
    signal m  : std_logic;
    signal r  : std_logic_vector (Wt-1 downto 0);
    signal co : std_logic;

begin

    dut : add_sub
    port map (a  => a,
              b  => b,
              m  => m,
              r  => r,
              co => co);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        a <= (others => '0');
        b <= (others => '0');
        m <= '0';
        wait for 10 ns;
        a <= std_logic_vector(to_unsigned(2,Wt));
        b <= std_logic_vector(to_unsigned(2,Wt));
        wait for 10 ns;
        a <= std_logic_vector(to_unsigned(253,Wt));
        b <= std_logic_vector(to_unsigned(4,Wt));
        wait for 10 ns;
        a <= std_logic_vector(to_unsigned(14,Wt));
        b <= std_logic_vector(to_unsigned(76,Wt));
        wait for 10 ns;
        a <= std_logic_vector(to_unsigned(9,Wt));
        b <= std_logic_vector(to_unsigned(255,Wt));
        wait for 10 ns;
        m <= '1';
        a <= std_logic_vector(to_unsigned(250,Wt));
        b <= std_logic_vector(to_unsigned(250,Wt));
        wait for 10 ns;
        a <= std_logic_vector(to_unsigned(3,Wt));
        b <= std_logic_vector(to_unsigned(13,Wt));
        wait for 10 ns;
        a <= std_logic_vector(to_unsigned(12,Wt));
        b <= std_logic_vector(to_unsigned(1,Wt));
        wait for 10 ns;
        a <= std_logic_vector(to_unsigned(1,Wt));
        b <= std_logic_vector(to_unsigned(3,Wt));
        wait for 10 ns;
        wait;
    end process;

end tb;