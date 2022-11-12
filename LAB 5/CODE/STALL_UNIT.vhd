----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:29:20 05/05/2018 
-- Design Name: 
-- Module Name:    STALL_UNIT - Behavioral 
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

entity STALL_UNIT is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           DEC_EX_OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           DEC_EX_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           IMEM_out_rs : in  STD_LOGIC_VECTOR (4 downto 0);
           IMEM_out_rt : in  STD_LOGIC_VECTOR (4 downto 0);
           PC_LdEn : out  STD_LOGIC;
           IMEM_en : out  STD_LOGIC);
end STALL_UNIT;

architecture Behavioral of STALL_UNIT is

type state is (A,B);
signal current_state,next_state: state;

begin

fsm_sync: process(Rst,Clk) 
begin
   if (Rst='1') then 
		current_state <= A;
   elsif (Rst='0' and rising_edge(CLK)) then 
		current_state <= next_state;
   end if;
end process fsm_sync;
					 
process(current_state,DEC_EX_OpCode,IMEM_out_rs,IMEM_out_rt,DEC_EX_rd)
	begin
		case current_state is
		when A =>  -- bubble 2
			PC_LdEn <= '0';
			IMEM_en <= '0';
			next_state <= B;
		when B =>
			if ( DEC_EX_OpCode = "001111" AND (IMEM_out_rs = DEC_EX_rd OR IMEM_out_rt =DEC_EX_rd)) then -- bubble 1
				PC_LdEn <= '0';
				IMEM_en <= '1';
				next_state <= A;
			else
				PC_LdEn <= '1';
				IMEM_en <= '1';
				next_state <= B;
			end if;
			
		end case;
	end process;


end Behavioral;

