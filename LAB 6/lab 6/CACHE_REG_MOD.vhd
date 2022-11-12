----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:39:36 05/21/2018 
-- Design Name: 
-- Module Name:    CACHE_REG_MOD - Behavioral 
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

entity CACHE_REG_MOD is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           --CLOCK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end CACHE_REG_MOD;

architecture Behavioral of CACHE_REG_MOD is
signal temp : std_logic_vector (31 downto 0) :="00000000000000000000000000000000";
begin
--
--Process
--Begin 
-- 
--Wait until( CLOCK'EVENT and CLOCK = '1' );     
--If (WE = '1') then  temp<=Din;     
--else temp<="00000000000000000000000000000000";     
--End if;   
--
--End process ;
--Dout<=temp;

Dout<= temp when WE='0' else Din;

end Behavioral;

