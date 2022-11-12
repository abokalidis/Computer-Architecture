----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:56:58 04/22/2018 
-- Design Name: 
-- Module Name:    POLY_REG - Behavioral 
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

entity POLY_REG is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           Clk : in  STD_LOGIC;
           En : in  STD_LOGIC;
           B : out  STD_LOGIC_VECTOR (31 downto 0));
end POLY_REG;

architecture Behavioral of POLY_REG is


signal temp : std_logic_vector (31 downto 0) :="00000000000000000000000000000000";
begin

Process
Begin 
 
Wait until( Clk'EVENT and Clk = '1' );     
If (En = '1') then  temp<=A;     
else temp<=temp;     
End if;   

End process ;
B<=temp;

end Behavioral;

