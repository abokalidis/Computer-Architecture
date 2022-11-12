----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:06:40 04/24/2018 
-- Design Name: 
-- Module Name:    Counter - Behavioral 
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
    Port ( CLK : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           RC : out  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (4 downto 0));
end Counter;

architecture Behavioral of Counter is
signal temp : STD_LOGIC_VECTOR(4 downto 0) := "00000";
begin
process--(CLK,EN,temp)

	begin
	Wait until( CLK'EVENT and CLK = '1' );     
	if (temp="11111") then RC<='1'; temp<="00000";
   elsif(EN='1') then temp<=temp + "00001"; RC<='0';
   else temp<=temp; RC<='0';
	end if;

Output<=temp;
end process;

end Behavioral;

