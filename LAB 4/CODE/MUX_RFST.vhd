----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:20:01 04/24/2018 
-- Design Name: 
-- Module Name:    MUX_RFST - Behavioral 
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

entity MUX_RFST is
    Port ( A : in  STD_LOGIC_VECTOR (4 downto 0);
           B : in  STD_LOGIC_VECTOR (4 downto 0);
           C : in  STD_LOGIC_VECTOR (4 downto 0);
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           O : out  STD_LOGIC_VECTOR (4 downto 0));
end MUX_RFST;

architecture Behavioral of MUX_RFST is

begin
process (A,B,C,S)
begin

if(S="00") then O<=A;
elsif(S="01") then O<=B;
elsif(S="10") then O<=C;
else O<=(others => '0');
end if;
end process;


end Behavioral;

