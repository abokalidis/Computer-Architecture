----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:31:46 05/05/2018 
-- Design Name: 
-- Module Name:    FORWARD_UNIT - Behavioral 
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

entity FORWARD_UNIT is
    Port ( OpCode    : in STD_LOGIC_VECTOR (5 downto 0);
			  PC_LdEn   : in  STD_LOGIC;
			  DEC_EX_rs : in  STD_LOGIC_VECTOR (4 downto 0);
			  DEC_EX_rt : in  STD_LOGIC_VECTOR (4 downto 0);
			  EX_MEM_rd : in  STD_LOGIC_VECTOR (4 downto 0);
			  MEM_WB_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           EX_MEM_en : in  STD_LOGIC;
           MEM_WB_en : in  STD_LOGIC;
           FW_A      : out  STD_LOGIC_VECTOR (1 downto 0);
           FW_B      : out  STD_LOGIC_VECTOR (1 downto 0)
			  );
end FORWARD_UNIT;

architecture Behavioral of FORWARD_UNIT is


begin

process(DEC_EX_rs,DEC_EX_rt,EX_MEM_en,MEM_WB_en)
begin
--------------------------------- one cycle forward ------------------------------------------------------------------
if(EX_MEM_en = '1' and (DEC_EX_rs = EX_MEM_rd OR DEC_EX_rt = EX_MEM_rd) and PC_LdEn = '1' and OpCode /= "111000") then
	if(DEC_EX_rs = EX_MEM_rd) then
		FW_A <= "10";
	else
		FW_A <= "00";
	end if;
	if(DEC_EX_rt = EX_MEM_rd) then
		FW_B <= "10";
	else
		FW_B <= "00";
	end if;
	
--------------------------------- two cycle forward --------------------------------------------------------------------
elsif(MEM_WB_en = '1' and (DEC_EX_rs = MEM_WB_rd OR DEC_EX_rt = MEM_WB_rd) and PC_LdEn = '1' and OpCode /= "111000") then
	if(DEC_EX_rs = MEM_WB_rd) then
		FW_A <= "01";
	else 
		FW_A <= "00";
	end if;
	if(DEC_EX_rt = MEM_WB_rd) then
		FW_B <= "01";
	else 
		FW_B <= "00";
	end if;
else
	FW_A <= "00";
	FW_B <= "00";
end if;

end process;
--------------------------------------------------------------------------------------------------------------------------
end Behavioral;

