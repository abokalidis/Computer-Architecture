----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:30:04 05/17/2018 
-- Design Name: 
-- Module Name:    OUTPUT_MUX - Behavioral 
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

entity OUTPUT_MUX is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC_VECTOR (31 downto 0);
           D : in  STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in  STD_LOGIC_VECTOR (1 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end OUTPUT_MUX;

architecture Behavioral of OUTPUT_MUX is

begin
	process(A,B,C,D,mux_sel)
		begin
			if mux_sel="00" then
				mux_out<=A;
			elsif mux_sel="01" then
				mux_out<=B;
			elsif mux_sel="10" then
				mux_out<=C;
			else
				mux_out<=D;
			end if;
	end process;
end Behavioral;

