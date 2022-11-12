----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:12:18 04/21/2018 
-- Design Name: 
-- Module Name:    after_alu_reg - Behavioral 
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

entity AFTER_ALU_REG is
    Port ( DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           CLCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end AFTER_ALU_REG;

architecture Behavioral of AFTER_ALU_REG is
signal temp : std_logic_vector (31 downto 0) :="00000000000000000000000000000000";
begin

Process
Begin 
 
Wait until( CLCK'EVENT and CLCK = '1' );     
If (WE = '1') then  temp<=DataIn;     
else temp<=temp;     
End if;   

End process ;
DataOut<=temp;
end Behavioral;

