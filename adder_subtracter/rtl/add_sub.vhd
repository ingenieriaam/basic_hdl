library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity add_sub is
  generic (
    w : natural := 8
  );
  port (
    a   : in    std_logic_vector(w - 1 downto 0);
    b   : in    std_logic_vector(w - 1 downto 0);
    m  : in    std_logic;
    r  : out   std_logic_vector(w - 1 downto 0);
    co : out   std_logic
  );
end entity add_sub;

architecture data_flow of add_sub is

  signal u_a : unsigned(w downto 0);
  signal u_b : unsigned(w downto 0);
  signal u_r : unsigned(w downto 0);

begin

  u_a <= '0' & unsigned(a);
  u_b <= '0' & unsigned(b);

  u_r <= (u_b + u_a) when m='0' else
         (u_b - u_a);

  r  <= std_logic_vector(u_r(w - 1 downto 0));
  co <= std_logic(u_r(w));

end architecture data_flow;
