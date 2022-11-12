----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:06:08 03/04/2018 
-- Design Name: 
-- Module Name:    COMPARE_MODULE - Behavioral 
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

entity COMPARE_MODULE is
    Port ( ADR : in  STD_LOGIC_VECTOR (4 downto 0);
           AWR : in  STD_LOGIC_VECTOR (4 downto 0);
			  WE : in STD_LOGIC;
           RES : out  STD_LOGIC);
end COMPARE_MODULE;

architecture Behavioral of COMPARE_MODULE is

begin

RES<= '0' when AWR="00000" else
      '1' when ADR=AWR and WE='1' else
	   '0';

end Behavioral;

