----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:24:45 04/30/2018 
-- Design Name: 
-- Module Name:    REG_128bit - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_128bit is
    Port ( Din : in  STD_LOGIC_VECTOR (127 downto 0);
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (127 downto 0));
end REG_128bit;

architecture Behavioral of REG_128bit is
signal temp : std_logic_vector (127 downto 0) :="00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
begin

Process
Begin 
 
Wait until( CLOCK'EVENT and CLOCK = '1' );     
If (WE = '1') then  temp<=Din;     
else temp<=temp;     
End if;   

End process ;
Dout<=temp;
end Behavioral;

