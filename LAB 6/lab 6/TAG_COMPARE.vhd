----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:23:33 05/17/2018 
-- Design Name: 
-- Module Name:    TAG_COMPARE - Behavioral 
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

entity TAG_COMPARE is
    Port ( cache_tag : in  STD_LOGIC_VECTOR (2 downto 0);
           instr_tag : in  STD_LOGIC_VECTOR (2 downto 0);
           comp_out : out  STD_LOGIC);
end TAG_COMPARE;

architecture Behavioral of TAG_COMPARE is

begin
	process(cache_tag,instr_tag)
		begin
			comp_out<='0';
			if cache_tag=instr_tag then
				comp_out<='1';
			else
				comp_out<='0';
			end if;
		end process;

end Behavioral;
