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
      a <= random_vector(Wt);
      b <= random_vector(Wt);
      m <= '0';
      result <= std_logic_vector(unsigned(a) + unsigned(b));
      report  LF & "Valor esperado de a+b = " & report_signal(a,"dec") & "+" & report_signal(b,"dec") & " = " & report_signal(result,"dec");
      if report_error(result, r, "r", "dec") then
        errors := errors + 1;
      end if;
      wait for 10 ns;
    end loop;
    report_pass_fail(errors);

    -- EDIT Adapt initialization as needed
--    a <= (others => '0');
--    b <= (others => '0');
--    m <= '0';
--    wait for 10 ns;
--    a <= std_logic_vector(to_unsigned(2, wt));
--    b <= std_logic_vector(to_unsigned(2, wt));
--    wait for 10 ns;
--    a <= std_logic_vector(to_unsigned(253, wt));
--    b <= std_logic_vector(to_unsigned(4, wt));
--    wait for 10 ns;
--    a <= std_logic_vector(to_unsigned(14, wt));
--    b <= std_logic_vector(to_unsigned(76, wt));
--    wait for 10 ns;
--    a <= std_logic_vector(to_unsigned(9, wt));
--    b <= std_logic_vector(to_unsigned(255, wt));
--    wait for 10 ns;
--    m <= '1';
--    a <= std_logic_vector(to_unsigned(250, wt));
--    b <= std_logic_vector(to_unsigned(250, wt));
--    wait for 10 ns;
--    a <= std_logic_vector(to_unsigned(3, wt));
--    b <= std_logic_vector(to_unsigned(13, wt));
--    wait for 10 ns;
--    a <= std_logic_vector(to_unsigned(12, wt));
--    b <= std_logic_vector(to_unsigned(1, wt));
--    wait for 10 ns;
--    a <= std_logic_vector(to_unsigned(1, wt));
--    b <= std_logic_vector(to_unsigned(3, wt));
--    wait for 10 ns; */
    report_end;
    wait;

  end process stimuli;

end architecture tb;
