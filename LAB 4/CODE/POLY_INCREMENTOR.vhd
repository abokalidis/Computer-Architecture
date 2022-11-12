----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:02:51 04/22/2018 
-- Design Name: 
-- Module Name:    POLY_INCREMENTOR - Behavioral 
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

entity POLY_INCREMENTOR is
    Port ( F : in  STD_LOGIC_VECTOR (31 downto 0);
           G : out  STD_LOGIC_VECTOR (31 downto 0));
end POLY_INCREMENTOR;

architecture Behavioral of POLY_INCREMENTOR is
begin

G<= F + "00000000000000000000000000000100";

end Behavioral;

