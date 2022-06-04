library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
-- paquetes creados por Fernando Orge
use work.random_stim_pkg.all;
use work.report_pkg.all;

entity tb_add_sub_pkg is
end tb_add_sub_pkg;

architecture tb of tb_add_sub_pkg is
    constant Wt : natural:= 8;

    component add_sub
    generic(w:natural:=Wt);
        port (a  : in std_logic_vector (w-1 downto 0);
              b  : in std_logic_vector (w-1 downto 0);
              m  : in std_logic;
              r  : out std_logic_vector (w-1 downto 0);
              co : out std_logic);
    end component;   

    -- signals de prueba
    signal a  : std_logic_vector (Wt-1 downto 0);
    signal b  : std_logic_vector (Wt-1 downto 0);
    signal m  : std_logic;
    signal r  : std_logic_vector (Wt-1 downto 0);
    signal co : std_logic;

    -- variables necesarias
    shared variable     var_a      : std_logic_vector (Wt-1 downto 0);
    shared variable     var_b      : std_logic_vector (Wt-1 downto 0);
    shared variable     var_m      : std_logic;
    shared variable     errors     : integer := 0;

begin
    dut : add_sub
    port map (a  => a,
              b  => b,
              m  => m,
              r  => r,
              co => co);

    random : process
    begin
        report_begin;
        -- sumas
        for k in 0 to 15 loop
            var_b := random_vector(Wt);
            var_a := random_vector(Wt);
            var_m  := '0';
            b <= var_b;
            a <= var_a;
            m <= var_m;
            wait for 5 ns;
        end loop;
        --restas
        for k in 0 to 15 loop
            var_b := random_vector(Wt);
            var_a := random_vector(Wt);
            var_m  := '1';
            b <= var_b;
            a <= var_a;
            m <= var_m;
            wait for 5 ns;
        end loop;
        report_pass_fail(errors);
        report_end;
        wait;

    end process;

end tb;