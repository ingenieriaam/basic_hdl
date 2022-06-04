library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use work.random_stim_pkg.all;
  use work.report_pkg.all;
  use work.gldn_mdl_pkg.all;

entity tb_add_sub is
end entity tb_add_sub;

architecture tb of tb_add_sub is

  constant wt : natural := 8;

  component add_sub is
    generic (
      w : natural:= wt
    );
    port (
      a  : in    std_logic_vector(w - 1 downto 0);
      b  : in    std_logic_vector(w - 1 downto 0);
      m  : in    std_logic;
      r  : out   std_logic_vector(w - 1 downto 0);
      co : out   std_logic
    );
  end component;

  signal a  : std_logic_vector(wt - 1 downto 0);
  signal b  : std_logic_vector(wt - 1 downto 0);
  signal m  : std_logic;
  signal r  : std_logic_vector(wt - 1 downto 0);
  signal co : std_logic;

  signal       result     : std_logic_vector(wt - 1 downto 0);
  shared variable     errors     : integer := 0;

begin

  dut : component add_sub
    port map (
      a  => a,
      b  => b,
      m  => m,
      r  => r,
      co => co
    );

  stimuli : process is
  begin

    report_begin;
    for j in 0 to 15 loop
      a <= '0'&random_vector(Wt-1);
      b <= '0'&random_vector(Wt-1);
      m <= '0';
      result <= std_logic_vector(unsigned(a) + unsigned(b));
      report  LF & "Valor esperado de a+b = " & report_signal(a,"dec") & "+" & report_signal(b,"dec") & " = " & report_signal(result,"dec");
      if report_error(result, r, "r", "dec") then
        errors := errors + 1;
      end if;
      wait for 10 ns;
    end loop;
    report_pass_fail(errors);

    report_end;
    wait;

  end process stimuli;

end architecture tb;
