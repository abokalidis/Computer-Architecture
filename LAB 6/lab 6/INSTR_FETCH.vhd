----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:54:26 05/17/2018 
-- Design Name: 
-- Module Name:    INSTR_FETCH - Behavioral 
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

entity INSTR_FETCH is
    Port ( Instr : in  STD_LOGIC_VECTOR (10 downto 0);
           Set_index : out  STD_LOGIC_VECTOR (4 downto 0);
           Word_offset : out  STD_LOGIC_VECTOR (1 downto 0);
           Tag : out  STD_LOGIC_VECTOR (2 downto 0));
end INSTR_FETCH;

architecture Behavioral of INSTR_FETCH is

begin
	Set_index <= Instr(6 downto 2);
	Word_offset <=Instr(1 downto 0);
	Tag <= Instr(9 downto 7);

end Behavioral;

