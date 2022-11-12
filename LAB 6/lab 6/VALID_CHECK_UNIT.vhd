----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:26:32 05/17/2018 
-- Design Name: 
-- Module Name:    VALID_CHECK_UNIT - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VALID_CHECK_UNIT is
    Port ( valid_bit : in  STD_LOGIC;
           comp_out : in  STD_LOGIC;
           valid_check_out : out  STD_LOGIC);
end VALID_CHECK_UNIT;

architecture Behavioral of VALID_CHECK_UNIT is

begin
	process(valid_bit,comp_out)
		begin
			if (valid_bit = '1' and comp_out = '1') then
				valid_check_out <= '1';
			else
				valid_check_out <= '0';
			end if;
		end process;


end Behavioral;
