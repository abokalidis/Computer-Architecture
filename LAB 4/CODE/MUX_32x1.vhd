----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:02:41 03/21/2018 
-- Design Name: 
-- Module Name:    MUX_32x1 - Behavioral 
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

entity MUX_32x1 is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
			  C : in  STD_LOGIC_VECTOR (31 downto 0);
			  D : in  STD_LOGIC_VECTOR (31 downto 0);
           Se : in  STD_LOGIC_VECTOR (1 downto 0);
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX_32x1;

architecture Behavioral of MUX_32x1 is

begin
process (A,B,C,D,Se)
begin

if(Se="00") then Z<=A;
elsif(Se="01") then Z<=B;
elsif(Se="10") then Z<=C;
else Z<=D;
end if;
end process;

end Behavioral;

