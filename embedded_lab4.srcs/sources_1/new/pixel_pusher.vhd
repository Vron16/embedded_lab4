----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pixel_pusher is
    Port ( 
    clk : in  std_logic;
    en : in std_logic;
    hcount : in std_logic_vector (9 downto 0);
    pixel : in std_logic_vector (7 downto 0);
    vid : in std_logic;
    vs : in std_logic;
    R : out std_logic_vector (4 downto 0);
    B : out std_logic_vector (4 downto 0);
    G : out std_logic_vector (5 downto 0);
    addr : out std_logic_vector (17 downto 0)
  );
end pixel_pusher;

architecture Behavioral of pixel_pusher is

signal addr_sig : std_logic_vector (17 downto 0) := (others => '0');

begin

addr <= addr_sig;

process(clk)
begin
    if(rising_edge(clk)) then
        if vs = '0' then
            addr_sig <= (others => '0');
        end if;
        if en = '1' and vid = '1' and unsigned(hcount) < 480 then
            addr_sig <= std_logic_vector(unsigned(addr_sig) + 1);
            R <= pixel(7 downto 5) & "00";
            G <= pixel(4 downto 2) & "000";
            B <= pixel(1 downto 0) & "000";
        else
            R <= (others => '0');
            G <= (others => '0');
            B <= (others => '0');
        end if; 
    end if;
end process;


end Behavioral;
