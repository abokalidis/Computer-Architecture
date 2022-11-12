----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:42:18 03/23/2018 
-- Design Name: 
-- Module Name:    CONTROL_UNIT - Behavioral 
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

entity CONTROL_UNIT is
    Port ( Instr: in STD_LOGIC_VECTOR(31 downto 0);
			  Opcode : in STD_LOGIC_VECTOR(5 downto 0);
			  Func : in STD_LOGIC_VECTOR(5 downto 0);
           RF_B_sel : out  STD_LOGIC;
           RF_wr_data_sel : out  STD_LOGIC;
			  RF_wren : out  STD_LOGIC;
			  ALU_BIN_sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR(3 downto 0);
           DATA_wen : out  STD_LOGIC;
			  PC_EPC_SEL : out  STD_LOGIC;
			  Illegal_instr_check : out STD_LOGIC);
end CONTROL_UNIT;

architecture Behavioral of CONTROL_UNIT is

signal sig_RF_B_sel : STD_LOGIC := '0';
signal sig_RF_wr_data_sel : STD_LOGIC := '0';
signal sig_RF_wren : STD_LOGIC := '0';
signal sig_DATA_wen : STD_LOGIC := '0';
signal sig_ALU_func : STD_LOGIC_vector (3 downto 0) := "0000";	
signal sig_ALU_BIN_sel : STD_LOGIC := '0';
signal sig_illegal,sig_PC_EPC_SEL : STD_LOGIC;

begin
					
process(OpCode,Func)
begin 
		if(OpCode = "111000") then -- li
			sig_DATA_wen <='0';
			sig_RF_B_sel <='1';
			sig_RF_wr_data_sel <='0';
		   sig_RF_wren<='1';
			sig_ALU_BIN_sel<='1';
         sig_ALU_func <="0000";
			sig_illegal <= '0';
			sig_PC_EPC_SEL <='0';
		elsif(OpCode = "001111") then -- lw
			sig_DATA_wen <='0';
	      sig_RF_B_sel <='1';
         sig_RF_wr_data_sel <='1';
			sig_RF_wren<='1';
			sig_ALU_BIN_sel<='1';
         sig_ALU_func <="0000";
			sig_illegal <= '0';
			sig_PC_EPC_SEL <='0';
		elsif(OpCode = "100000" and Func = "110000")  then -- add
			sig_RF_B_sel <='0';
			sig_RF_wr_data_sel <='0';
			sig_RF_wren<='1';
			sig_DATA_wen <='0';
			sig_ALU_BIN_sel<='0';
			sig_ALU_func <="0000";
			sig_illegal <= '0';
			sig_PC_EPC_SEL <='0';
		elsif(Opcode = "101010") then -- jump_epc
			sig_PC_EPC_SEL <='1';
		else
			sig_RF_B_sel <='0';
			sig_RF_wr_data_sel <='0';
			sig_RF_wren<='0';
			sig_DATA_wen <='0';
			sig_ALU_BIN_sel<='0';
			sig_ALU_func <="0000";
			sig_illegal <= '1';
			sig_PC_EPC_SEL <='0';
		end if;
		
end process;

ALU_BIN_sel <= sig_ALU_BIN_sel;
RF_B_sel <= sig_RF_B_sel; 
RF_wr_data_sel <= sig_RF_wr_data_sel;
RF_wren <= sig_RF_wren; 
ALU_func <= sig_ALU_func; 
DATA_wen <= sig_DATA_wen;
Illegal_instr_check <= sig_illegal;
PC_EPC_SEL <= sig_PC_EPC_SEL;					 
end Behavioral;