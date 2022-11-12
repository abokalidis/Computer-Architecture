----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:38:57 03/11/2018 
-- Design Name: 
-- Module Name:    REG_PC - Behavioral 
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

entity REG_PC is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           We : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end REG_PC;

architecture Behavioral of REG_PC is
signal temp : std_logic_vector (31 downto 0) :="00000000000000000000000000000000";
signal lden : std_logic;

begin

Process(Clock,Rst)
Begin 
 
--Wait until( CLOCK'EVENT and CLOCK = '1' );     
--If (WE = '1') then  temp<=Din;     
--elsif (Rst='1') then temp<="00000000000000000000000000000000";
--else temp<=temp;     
--End if;   
lden <= We;

if Rst = '1' then
	temp<="00000000000000000000000000000000";
elsif rising_edge(Clock) then
	if (WE = '1') then  temp<=Din; 
	else 
		temp<=temp;
	end if;
end if;
end process ;

Dout<=temp; 

end Behavioral;

