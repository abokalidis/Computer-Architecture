----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:31:57 03/03/2018 
-- Design Name: 
-- Module Name:    LOGIC_SHIFTS - Behavioral 
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

entity LOGIC_SHIFTS is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end LOGIC_SHIFTS;

architecture Behavioral of LOGIC_SHIFTS is

begin
Output(31) <= A(31) when (Op = "1000") else 
				  '0'   when (Op = "1001") else 
				  A(30) when (Op = "1010") else 
				  A(30) when (Op = "1100") else 
				  A(0)  when (Op = "1101");		
Output(30 downto 1) <= A(31 downto 2) when (Op = "1000") else 
						     A(31 downto 2) when (Op = "1001") else 
							  A(29 downto 0) when (Op = "1010") else  
							  A(29 downto 0) when (Op = "1100") else 
							  A(31 downto 2) when (Op = "1101");		
Output(0) <= A(1)  when (Op = "1000") else 
			    A(1)  when (Op = "1001") else 
			    '0'   when (Op = "1010") else  
			    A(31) when (Op = "1100") else 
			    A(1)  when (Op = "1101");		 

end Behavioral;

