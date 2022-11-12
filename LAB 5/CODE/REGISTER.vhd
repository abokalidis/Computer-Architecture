----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:34:55 03/03/2018 
-- Design Name: 
-- Module Name:    REGISTER - Behavioral 
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

entity REGISTERS is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end REGISTERS;

architecture Behavioral of REGISTERS is
signal temp : std_logic_vector (31 downto 0) :="00000000000000000000000000000000";
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

