----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2018 09:00:44 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
  Port ( 
    clk : in  std_logic;
    en : in std_logic;
    hcount : out std_logic_vector (9 downto 0);
    vcount : out std_logic_vector (9 downto 0);
    vid : out std_logic;
    hs : out std_logic;
    vs : out std_logic
  );
end vga_ctrl;

architecture Behavioral of vga_ctrl is

signal hcount_sig : std_logic_vector (9 downto 0) := (others => '0');
signal vcount_sig : std_logic_vector (9 downto 0) := (others => '0');

begin

hcount <= hcount_sig;
vcount <= vcount_sig;

process (clk)
begin
    if (rising_edge(clk)) then
        if (en = '1') then
            if (unsigned(hcount_sig) <= 639 and unsigned(vcount_sig) <= 479) then
                vid <= '1';
                hs <= '1';
                vs <= '1';
            else
                vid <= '0';
                if (unsigned(hcount_sig) >= 656 and unsigned(hcount_sig) <= 751) then
                    hs <= '0';
                else if (unsigned(hcount_sig) < 800) then
                    hs <= '1';
                end if;
                if (unsigned(vcount_sig) >= 490 and unsigned(vcount_sig) <= 491) then
                    vs <= '0';
                else if (unsigned(vcount_sig) < 525) then
                    vs <= '1';
                end if;
            end if;
            hcount_sig <= std_logic_vector(unsigned(hcount_sig)+1);
            if (unsigned(hcount_sig) = 800) then
                hcount_sig <= (others => '0');
                if (unsigned(vcount_sig) < 525) then
                    vcount_sig <= std_logic_vector(unsigned(vcount_sig)+1);
                else
                    vcount_sig <= (others => '0');
                end if;
            end if;
       end if;
    end if;
 end if;
end if;
end process;             
end Behavioral;

