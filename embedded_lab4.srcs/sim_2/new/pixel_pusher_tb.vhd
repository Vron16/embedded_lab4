----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2018 12:37:53 PM
-- Design Name: 
-- Module Name: vga_ctrl_test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pixel_pusher_tb is
end pixel_pusher_tb;

architecture Behavioral of pixel_pusher_tb is

    component clock_div is
        port(
            clk  : in std_logic;        -- 125 Mhz clock
            div : out std_logic        -- output 2Hz clock    
        );
    end component;
   
    component pixel_pusher is
            port ( 
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

    signal div, clk : std_logic := '0';
    signal vs, vid : std_logic := '1';
    signal hcount : std_logic_vector (9 downto 0) := (others => '0');
    signal pixel : std_logic_vector (7 downto 0) := "10101011";
    signal R, B : std_logic_vector (4 downto 0) := (others => '0');
    signal G : std_logic_vector (5 downto 0) := (others => '0');
    signal addr : std_logic_vector (17 downto 0) := (others => '0');

begin

    clock_divider : process 
    begin
        clk <= '0';
        wait for 4 ns;
        clk <= '1';
        if (unsigned(hcount) < 799) then
            hcount <= std_logic_vector(unsigned(hcount)+1);
        else
            hcount <= (others => '0');
        end if;
        wait for 4 ns;
    end process clock_divider;
    u1 : clock_div
        port map (
            clk => clk,
            div => div
        );
    u4 : pixel_pusher
        port map (
            clk => clk,
            en => div,
            hcount => hcount,
            pixel => pixel,
            vs => vs,
            vid => vid,
            R => R,
            B => B,
            G => G,
            addr => addr
        );

end Behavioral;
