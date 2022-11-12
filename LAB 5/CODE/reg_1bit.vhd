----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:01:15 05/05/2018 
-- Design Name: 
-- Module Name:    reg_1bit - Behavioral 
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

entity reg_1bit is
    Port ( Din : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC);
end reg_1bit;

architecture Behavioral of reg_1bit is
signal temp : std_logic :='0';
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
