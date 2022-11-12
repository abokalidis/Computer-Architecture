----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:27:56 05/17/2018 
-- Design Name: 
-- Module Name:    EXCEPTION_UNIT - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EXCEPTION_UNIT is
    Port ( Ovf : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           Illegal_OpCode : in  STD_LOGIC;
			  OPCODE_EXCEPTION : in  STD_LOGIC_VECTOR (5 downto 0);
           DecEx_wren : out  STD_LOGIC;
           ExMem_wren : out  STD_LOGIC;
           IF_Stage_mux_sel : out  STD_LOGIC_VECTOR(1 downto 0);
			  Pre_epc_sel : out  STD_LOGIC;
			  EPC_EN : out  STD_LOGIC;
           Cause_reg_value : out  STD_LOGIC_VECTOR (31 downto 0));
end EXCEPTION_UNIT;

architecture Behavioral of EXCEPTION_UNIT is

begin

process(Ovf,ALU_out,Illegal_OpCode,OPCODE_EXCEPTION)

begin

if(Ovf = '1') then -- ovf check
	DecEx_wren <= '1';
   ExMem_wren <= '0';
   IF_Stage_mux_sel <= "01";
   Cause_reg_value <= "00010001000000000000000000000000";
	Pre_epc_sel <= '1';
	EPC_EN <='1';
elsif(unsigned(ALU_out) > 2047 and OPCODE_EXCEPTION = "001111") then -- illegal memory address check
	DecEx_wren <= '1';
   ExMem_wren <= '0';
   IF_Stage_mux_sel <= "10";
   Cause_reg_value <= "00000000000100010001000000000000";
	Pre_epc_sel <= '1';
	EPC_EN <='1';
elsif(Illegal_OpCode = '1') then -- illegal instruction
	DecEx_wren <= '0';
   ExMem_wren <= '1';
   IF_Stage_mux_sel <= "11";
   Cause_reg_value <= "00000000000000000000000100010001";
	Pre_epc_sel <= '0';
	EPC_EN <='1';
else
	DecEx_wren <= '1';
   ExMem_wren <= '1';
   IF_Stage_mux_sel <= "00"; 
   Cause_reg_value <= "00000000000000000000000000000000";
	Pre_epc_sel <= '0';
	EPC_EN <='0';
end if;
	

end process;



end Behavioral;

