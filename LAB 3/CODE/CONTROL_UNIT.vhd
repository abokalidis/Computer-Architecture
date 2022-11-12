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
    Port ( Reset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Zero : in  STD_LOGIC;
			  Instr: in STD_LOGIC_VECTOR(31 downto 0);
			  Opcode : in STD_LOGIC_VECTOR(5 downto 0);
			  Func : in STD_LOGIC_VECTOR(5 downto 0);
           PC_sel : out  STD_LOGIC;
           PC_lden : out  STD_LOGIC;
			  PC_reset : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           RF_wr_data_sel : out  STD_LOGIC;
			  RF_wren : out  STD_LOGIC;
           ALU_A_sel : out  STD_LOGIC;
           ALU_B_sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR(3 downto 0);
           MEM_dout_sel : out  STD_LOGIC;
           DATA_din_sel : out  STD_LOGIC;
           DATA_wen : out  STD_LOGIC);
end CONTROL_UNIT;

architecture Behavioral of CONTROL_UNIT is


type state_type is(state_reset,START,R_type,R_type2,I_type,I_type2,Branch_B,Branch,BEQ,BNE,LB_1,LB_2,SB,LW_1,LW_2,SW,Final,nop,Li_Lui);
signal next_state,current_state : state_type;

begin
-------------------------------------------------------------					
fsm: process(next_state, Reset, CLK, Zero, Opcode, Func, Instr,current_state)
begin 
	case current_state is
	
	when START => PC_sel <= '0';
                 PC_lden <='0';
					  PC_reset<='0';
                 RF_B_sel <='0';
                 RF_wr_data_sel <='0';
					  RF_wren<='0';
                 ALU_A_sel <='0';
                 ALU_B_sel <='0';
                 ALU_func <="0000";
                 MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  if(Instr="10000000000000000000000000110000") then --Nop
								next_state	<= nop;
					  elsif(Instr(31 downto 26)="100000") then -- ALU
								next_state	<=	R_type;
			               ALU_func <=Func(3 downto 0);
					  
					  elsif(Instr(31 downto 26)="111000") then -- li
								next_state	<=	Li_Lui;
					  elsif(Instr(31 downto 26)="111001") then -- lui
								next_state	<= Li_Lui;
								
			        elsif(Instr(31 downto 26)="110000") then -- addi
								next_state	<= I_type;
								ALU_func<=Opcode(3 downto 0);
					  elsif(Instr(31 downto 26)="110010") then -- nandi
								next_state	<= I_type;
								ALU_func<=Opcode(3 downto 0);
					  elsif(Instr(31 downto 26)="110011") then -- ori
								next_state	<= I_type;
								ALU_func<=Opcode(3 downto 0);
			        
					  elsif(Instr(31 downto 26)="111111") then -- b
								next_state	<=	Branch_b;
			        elsif(Instr(31 downto 26)="000000") then -- beq
								next_state	<= Branch;
			        elsif(Instr(31 downto 26)="000001") then -- bneq
								next_state	<= Branch;
			        
					  elsif(Instr(31 downto 26)="000111") then -- sb
								next_state	<= SB;
			        elsif(Instr(31 downto 26)="011111") then -- sw
								next_state	<= SW;
			        elsif(Instr(31 downto 26)="000011") then -- lb
								next_state	<=	LB_1;
					  elsif(Instr(31 downto 26)="001111") then -- lw
								next_state	<= LW_1;
					  end if;
			
	when R_type=> RF_B_sel <='0';
	              ALU_A_sel <='0';
                 ALU_B_sel <='0';
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  next_state<=R_type2;
	
	when R_type2=>RF_B_sel <='0';
	              ALU_A_sel <='0';
                 ALU_B_sel <='0';
					  RF_wr_data_sel <='0';
					  RF_wren<='1';
					  PC_sel <= '0';
					  PC_lden <='1';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  next_state<=Final;
                 					  
	when Branch_B=>PC_sel <= '1';
					   PC_lden <='1';
						RF_B_sel <='0';
	               ALU_A_sel <='0';
                  ALU_B_sel <='0';
					   RF_wr_data_sel <='0';
					   RF_wren<='0';
					   ALU_func <="0000";
						next_state<=Final;
						
	when Branch=> RF_B_sel <='1';
	              ALU_A_sel <='0';
                 ALU_B_sel <='0';
					  RF_wren<='0';
					  ALU_func<="0001";
					  PC_sel <= '1';
                 PC_lden <='0';
                 RF_wr_data_sel <='0';
                 MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  if(Opcode="000000") then next_state<=BEQ;
					  elsif(Opcode="000001") then next_state<=BNE;
					  else next_state<=nop;
					  end if;
					  
	when BEQ=>    PC_sel <= '1';
                 PC_lden <='0';
					  RF_wren<='0';
					  RF_B_sel <='1';
                 RF_wr_data_sel <='0';
					  ALU_A_sel <='0';
                 ALU_B_sel <='0';
                 ALU_func <="0001";
                 MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  if(Zero='1') then next_state<=Branch_B;
					  else next_state<=nop;
					  end if;
					  
	when BNE=>    PC_sel <= '1';
                 PC_lden <='0';
					  RF_wren<='0';
					  RF_B_sel <='1';
                 RF_wr_data_sel <='0';
					  ALU_A_sel <='0';
                 ALU_B_sel <='0';
                 ALU_func <="0001";
                 MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  if(Zero='0') then next_state<=Branch_B;
					  else next_state<=nop;
					  end if;
					  
	when SW=>     ALU_A_sel <='0';
                 ALU_B_sel <='1';
	              RF_B_sel <='1';
					  ALU_func <="0000";
                 DATA_din_sel <='0';
                 DATA_wen <='1';
					  PC_sel <= '0';
                 RF_wr_data_sel <='0';
					  PC_lden <='1';
					  RF_wren<='0';                 
                 MEM_dout_sel <='0';
					  next_state<=Final;
					  
	when SB=>     DATA_din_sel <='1';
                 DATA_wen <='1';
                 PC_sel <= '0';
                 PC_lden <='1';
                 RF_B_sel <='1';
                 RF_wr_data_sel <='0';
					  RF_wren<='0';
                 ALU_A_sel <='0';
                 ALU_B_sel <='1';
                 ALU_func <="0000";
					  MEM_dout_sel <='0';
					  next_state<=Final;
					  
   when LW_1=>	  MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <='1';
                 RF_wr_data_sel <='1';
					  RF_wren<='0';
                 ALU_A_sel <='0';
                 ALU_B_sel <='1';
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  next_state<=LW_2;
	
	when LW_2=>	  MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='1';
                 RF_B_sel <='1';
                 RF_wr_data_sel <='1';
					  RF_wren<='1';
                 ALU_A_sel <='0';
                 ALU_B_sel <='1';
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  next_state<=Final;
					  
					  
	when LB_1=>   MEM_dout_sel <='1';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <='1';
                 RF_wr_data_sel <='1';
					  RF_wren<='0';
                 ALU_A_sel <='0';
                 ALU_B_sel <='1';
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  next_state<=LB_2;
				
	when LB_2=>   MEM_dout_sel <='1';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='1';
                 RF_B_sel <='1';
                 RF_wr_data_sel <='1';
					  RF_wren<='1';
                 ALU_A_sel <='0';
                 ALU_B_sel <='1';
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  next_state<=Final;
					  
	when Li_Lui=>     MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='1';
                 RF_B_sel <='1';
                 RF_wr_data_sel <='0';
					  RF_wren<='1';
                 ALU_A_sel <='1';
                 ALU_B_sel <='1';
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  next_state<=Final;
					  
	when I_type=> RF_B_sel <='1';
	              ALU_B_sel <='1';
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  ALU_A_sel <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  next_state<=I_type2;
	
	when I_type2=>RF_B_sel <='1';
	              ALU_B_sel <='1';
					  RF_wr_data_sel <='0';
					  RF_wren<='1';
					  PC_sel <= '0';
					  PC_lden <='1';
					  ALU_A_sel <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  next_state<=Final;
					  
	when Final=>  PC_sel <= '0';
                 PC_lden <='0';
					  PC_reset<='0';
                 RF_B_sel <='0';
                 RF_wr_data_sel <='0';
					  RF_wren<='0';
                 ALU_A_sel <='0';
                 ALU_B_sel <='0';
                 ALU_func <="0000";
                 MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  next_state<=START;
					 
	when state_reset=> PC_sel <= '0';
                      PC_lden <='0';
							 PC_reset<='1';
                      RF_B_sel <='0';
                      RF_wr_data_sel <='0';
					       RF_wren<='0';
                      ALU_A_sel <='0';
                      ALU_B_sel <='0';
                      ALU_func <="0000";
                      MEM_dout_sel <='0';
                      DATA_din_sel <='0';
                      DATA_wen <='0';
							 next_state<=START;
							 
	when nop=>         PC_sel <= '0';
                      PC_lden <='1';
							 PC_reset<='0';
                      RF_B_sel <='0';
                      RF_wr_data_sel <='0';
					       RF_wren<='0';
                      ALU_A_sel <='0';
                      ALU_B_sel <='0';
                      ALU_func <="0000";
                      MEM_dout_sel <='0';
                      DATA_din_sel <='0';
                      DATA_wen <='0';
							 next_state<=Final;
					 
end case;
end process fsm;

fsm_sync: process(Reset, CLK) 
begin
   if (Reset='1') then current_state <= state_reset;                      	
   elsif (Reset='0' and rising_edge(CLK)) then current_state <= next_state;
   end if;
end process fsm_sync;
					 
end Behavioral;

