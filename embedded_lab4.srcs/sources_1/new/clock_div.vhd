--filename: clock_div.vhd
--description: lab1 to divide 125 MHz clock down to 2Hz
--
------------------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity clock_div is
    port(

        clk  : in std_logic;        -- 125 Mhz clock
        div : out std_logic        -- output 25MHz clock

    );
end clock_div;

architecture behavior of clock_div is

    signal counter : std_logic_vector(26 downto 0) := (others => '0');
    signal div_sig : std_logic := '0';

begin
div <= div_sig;
    process(clk)
    begin
    -- takes as input a 125 MHz clock signal and divides it down to 25 MHz. Utilize a looping testbench to drive 125 million clock cycles on the input of the module and verify that the output produces two full clock cycles
    if (rising_edge(clk)) then
        if (unsigned(counter) < 4) then
            div_sig <= '0';
            counter <= std_logic_vector(unsigned(counter) + 1);
        else
            counter <= ((others => '0'));
            div_sig <= '1';
        end if;
    end if;
           
    end process;
    
end behavior;