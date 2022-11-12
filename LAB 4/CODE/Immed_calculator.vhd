----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:07:12 03/12/2018 
-- Design Name: 
-- Module Name:    Immed_calculator - Behavioral 
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

entity Immed_calculator is
    Port ( Immed_in : in  STD_LOGIC_VECTOR (15 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Immed_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Immed_calculator;

architecture Behavioral of Immed_calculator is
signal tempout : STD_LOGIC_VECTOR (31 downto 0);

begin

process(Immed_in,OpCode)
begin
	if(OpCode="110010" OR OpCode="110011") then
		tempout(31 downto 16) <= (others => '0');
		tempout(15 downto 0) <= Immed_in; --zero fill
	elsif(OpCode="111001") then
		tempout(31 downto 16) <= Immed_in;
		tempout(15 downto 0) <= (others => '0'); --shift left 16 and zero fill
	elsif(OpCode="111000" OR OpCode="110000" OR OpCode="000011" OR OpCode="000111" OR OpCode="001111" OR OpCode="011111" OR OpCode="110001" OR OpCode="011100" OR OpCode="011110") then
		tempout(31 downto 16) <= (others => Immed_in(15));
		tempout(15 downto 0) <= Immed_in; --sign extend
	elsif(OpCode="000000" OR OpCode="000001" OR OpCode="111111") then 
		tempout(31 downto 18) <= (others => Immed_in(15));--sign extend
		tempout(17 downto 2) <= Immed_in; 
		tempout(1 downto 0) <= "00"; -- shift left 2
	end if;
end process;
	
Immed_out <= tempout; -- Immed 32 bits

end Behavioral;

