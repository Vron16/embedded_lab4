----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top is
  Port ( 
  clk : in  std_logic;
  vga_hs : out std_logic;
  vga_vs : out std_logic;
  vga_r : out std_logic_vector (4 downto 0);
  vga_g : out std_logic_vector (5 downto 0);
  vga_b : out std_logic_vector (4 downto 0)
  );
end image_top;

architecture Behavioral of image_top is

    signal div, vid, vs : std_logic := '0';
    signal addr : std_logic_vector (17 downto 0);
    signal hcount : std_logic_vector (9 downto 0);
    signal douta : std_logic_vector (7 downto 0);

    component clock_div is
        port(
            clk  : in std_logic;        -- 125 Mhz clock
            div : out std_logic        -- output 2Hz clock    
        );
    end component; 
    
    component picture is
        PORT (
        clka : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
    end component;
    
    component pixel_pusher is
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
    end component;
    
    component vga_ctrl is
        Port ( 
        clk : in  std_logic;
        en : in std_logic;
        hcount : out std_logic_vector (9 downto 0);
        vcount : out std_logic_vector (9 downto 0);
        vid : out std_logic;
        hs : out std_logic;
        vs : out std_logic
      );
    end component;

begin

    u1 : clock_div
    port map (
        clk => clk,
        div => div
    );
    
    u2 : picture
    port map (
        clka => clk,
        addra => addr,
        douta => douta
    );
    
    u3 : pixel_pusher
    port map (
        clk => clk,
        en => div,
        hcount => hcount,
        pixel => douta,
        vid => vid,
        vs => vs,
        R => vga_r,
        G => vga_g,
        B => vga_b,
        addr => addr
    );
    
    vga_vs <= vs;
    
    u4 : vga_ctrl
    port map (
        clk => clk,
        en => div,
        hcount => hcount,
        vid => vid,
        vs => vs,
        hs => vga_hs
    );

end Behavioral;
