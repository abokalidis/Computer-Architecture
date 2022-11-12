----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:29:34 03/23/2018 
-- Design Name: 
-- Module Name:    CONTROL_REGISTER - Behavioral 
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

entity CONTROL_REGISTER is
       Port ( Din : in  STD_LOGIC_VECTOR (5 downto 0);
              WE : in  STD_LOGIC;
              CLOCK : in  STD_LOGIC;
              Dout : out  STD_LOGIC_VECTOR (5 downto 0));
end CONTROL_REGISTER;

architecture Behavioral of CONTROL_REGISTER is

signal temp : std_logic_vector (5 downto 0) :="000000";

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

