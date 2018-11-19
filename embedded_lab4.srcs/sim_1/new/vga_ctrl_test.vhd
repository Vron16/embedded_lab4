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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl_test is
end vga_ctrl_test;

architecture Behavioral of vga_ctrl_test is

component clock_div is
        port(
            clk  : in std_logic;        -- 125 Mhz clock
            div : out std_logic        -- output 2Hz clock    
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

signal div, clk : std_logic := '0';

begin

process begin
        clk <= '0';
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
    end process;

u1 : clock_div
    port map (
        clk => clk,
        div => div
    );
    
    u4 : vga_ctrl
    port map (
        clk => clk,
        en => div
    );

end Behavioral;
