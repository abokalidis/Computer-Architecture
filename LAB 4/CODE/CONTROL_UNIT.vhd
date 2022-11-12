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
			  RC : in  STD_LOGIC;
			  RFLD_SEL : out  STD_LOGIC;
			  CNT_EN : out  STD_LOGIC;
			  AAR1_EN : out  STD_LOGIC;
			  AAR2_EN : out  STD_LOGIC;
			  POL_1 : out  STD_LOGIC;
			  POL_2 : out  STD_LOGIC;
			  POL_MUX : out  STD_LOGIC;
           PC_sel : out  STD_LOGIC;
           PC_lden : out  STD_LOGIC;
			  PC_reset : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC_VECTOR (1 downto 0);
           RF_wr_data_sel : out  STD_LOGIC;
			  RF_wren : out  STD_LOGIC;
           ALU_A_sel : out  STD_LOGIC_VECTOR(1 downto 0);
           ALU_B_sel : out  STD_LOGIC_VECTOR(2 downto 0);
           ALU_func : out  STD_LOGIC_VECTOR(3 downto 0);
           MEM_dout_sel : out  STD_LOGIC;
           DATA_din_sel : out  STD_LOGIC;
           DATA_wen : out  STD_LOGIC);
end CONTROL_UNIT;

architecture Behavioral of CONTROL_UNIT is


type state_type is(state_reset,START,R_type,R_type2,R_type3,I_type,I_type2,Branch_B,Branch,BEQ,BNE,LB_1,LB_2,SB,LW_1,LW_2,SW,SW2,SW3,
Final,nop,Li_Lui,Li_Lui2,mmx1,mmx2,mmx3,poly1,poly2,poly3,poly4,poly5,poly6,
poly7,poly8,poly9,poly10,poly11,poly12,poly13,poly14,rfld1,rfld2,rfld3,rfld4,rfld5,rfld6,rfld7,rfst1,rfst2,rfst3,rfst4,rfst5,rfst6);
signal next_state,current_state : state_type;

begin
-------------------------------------------------------------					
fsm: process(next_state, Reset, CLK, Zero, Opcode, Func, Instr,current_state)
begin 
	case current_state is
	
	when START => PC_sel <= '0';
                 PC_lden <='0';
					  PC_reset<='0';
                 RF_B_sel <="00";
                 RF_wr_data_sel <='0';
					  RF_wren<='0';
					  CNT_EN<='0';
                 ALU_A_sel <="00";
                 ALU_B_sel <="001";
                 ALU_func <="0000";
                 MEM_dout_sel <='0';
                 DATA_din_sel <='0';
					  RFLD_SEL <='0';
                 DATA_wen <='0';
					  if(Instr="10000000000000000000000000110000") then --Nop
								next_state	<= nop;
					  elsif(Instr(31 downto 26)="100000") then -- ALU
								if(Instr(5 downto 0)="010000") then -- poly2
					         next_state <= poly1;
								else next_state <=	R_type;
			               ALU_func <=Func(3 downto 0);
								end if;
					  
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
					  elsif(Instr(31 downto 26)="110001") then -- MMX_addi_byte
								next_state	<= mmx1;
					  elsif(Instr(31 downto 26)="011100") then -- rfld
								next_state	<= rfld1;
					  elsif(Instr(31 downto 26)="011110") then -- rfst
								next_state	<= rfst1;
					  end if;
					  
	when rfld1=>  MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='1';
					  RF_wren<='0';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='0';
					  POL_MUX<='0';
					  RFLD_SEL <='0';
					  next_state<=rfld2;
	
	when rfld2=>  MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='1';
					  RF_wren<='0';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='1';
					  POL_MUX<='0';
					  RFLD_SEL <='0';
					  next_state<=rfld3;
	
	when rfld3=>  MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='1';
					  RF_wren<='0';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='0';
					  POL_1 <='1';
					  POL_2 <='0';
					  POL_MUX <='0';
					  RFLD_SEL <='0';
					  CNT_EN<='0';
					  next_state<=rfld4;
					  
	when rfld4=>  MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='1';
					  RF_wren<='1';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='0';
					  POL_1 <='1';
					  POL_2 <='1';
					  POL_MUX <='1';
					  RFLD_SEL <='1';
					  CNT_EN<='0';
					  next_state<=rfld5;
	
	when rfld5=>  MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='1';
					  RF_wren<='1';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='0';
					  POL_1 <='1';
					  POL_2 <='1';
					  POL_MUX <='1';
			        RFLD_SEL<='1';
			        CNT_EN<='1';
					  if(RC='1') then next_state<=rfld7;
					  else next_state<=rfld6;
					  end if;
	when rfld6=>  MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='1';
					  RF_wren<='1';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='0';
					  POL_1 <='1';
					  POL_2 <='1';
					  POL_MUX <='1';
			        RFLD_SEL<='1';
			        CNT_EN<='1';
					  if(RC='1') then next_state<=rfld7;
					  else next_state<=rfld5;
					  end if;
	
	when rfld7=>  MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='1';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='1';
					  RF_wren<='1';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='0';
					  POL_1 <='0';
					  POL_2 <='0';
					  POL_MUX <='0';
			        RFLD_SEL<='1';
			        CNT_EN<='0';
					  next_state<=final;
				
	when rfst1=>  ALU_A_sel <="00";
                 ALU_B_sel <="010";
	              RF_B_sel <="01";
					  ALU_func <="0000";
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  PC_sel <= '0';
                 RF_wr_data_sel <='0';
					  PC_lden <='0';
					  RF_wren<='0';
					  AAR1_EN <='0';
					  POL_1 <='0';
					  POL_2 <='0';
					  POL_MUX <='0';
					  RFLD_SEL<='0';
                 MEM_dout_sel <='0';
					  next_state<=rfst2;
  
  when rfst2=>   ALU_A_sel <="00";
                 ALU_B_sel <="010";
	              RF_B_sel <="01";
					  ALU_func <="0000";
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  PC_sel <= '0';
                 RF_wr_data_sel <='0';
					  PC_lden <='0';
					  RF_wren<='0';
					  AAR1_EN <='1';
					  POL_1 <='0';
					  POL_2 <='0';
					  POL_MUX <='0';
					  RFLD_SEL<='0';
                 MEM_dout_sel <='0';
					  next_state<=rfst3;
	
  when rfst3=>   ALU_A_sel <="00";
                 ALU_B_sel <="010";
	              RF_B_sel <="01";
					  ALU_func <="0000";
                 DATA_din_sel <='0';
                 DATA_wen <='1';
					  PC_sel <= '0';
                 RF_wr_data_sel <='0';
					  PC_lden <='0';
					  RF_wren<='0';
					  AAR1_EN <='0';
					  POL_1 <='1';
					  POL_2 <='0';
					  POL_MUX <='0';
					  CNT_EN<='1';
					  RFLD_SEL<='0';
                 MEM_dout_sel <='0';
					  next_state<=rfst4;
					  
	when rfst4=>  ALU_A_sel <="00";
                 ALU_B_sel <="010";
	              RF_B_sel <="10";
					  ALU_func <="0000";
                 DATA_din_sel <='0';
                 DATA_wen <='1';
					  PC_sel <= '0';
                 RF_wr_data_sel <='0';
					  PC_lden <='0';
					  RF_wren<='0';
					  AAR1_EN <='0';
					  POL_1 <='1';
					  POL_2 <='1';
					  POL_MUX <='1';
					  RFLD_SEL<='0';
                 MEM_dout_sel <='0';
					  CNT_EN<='1';
					  if(RC='1') then next_state<=rfst6;
					  else next_state<=rfst5;
					  end if;
					  
	when rfst5=>  ALU_A_sel <="00";
                 ALU_B_sel <="010";
	              RF_B_sel <="10";
					  ALU_func <="0000";
                 DATA_din_sel <='0';
                 DATA_wen <='1';
					  PC_sel <= '0';
                 RF_wr_data_sel <='0';
					  PC_lden <='0';
					  RF_wren<='0';
					  AAR1_EN <='0';
					  POL_1 <='1';
					  POL_2 <='1';
					  POL_MUX <='1';
					  RFLD_SEL<='0';
                 MEM_dout_sel <='0';
					  CNT_EN<='1';
					  if(RC='1') then next_state<=rfst6;
					  else next_state<=rfst4;
					  end if;
					  
	when rfst6=>  MEM_dout_sel <='0';
	              DATA_wen <='1';
	              PC_sel <= '0';
                 PC_lden <='1';
                 RF_B_sel <="10";
                 RF_wr_data_sel <='1';
					  RF_wren<='0';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='0';
					  POL_1 <='0';
					  POL_2 <='0';
					  POL_MUX <='0';
			        RFLD_SEL<='0';
			        CNT_EN<='0';
					  next_state<=final;
				
	
  when R_type=> RF_B_sel <="00";
	              ALU_A_sel <="00";
                 ALU_B_sel <="001";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='0';
					  RFLD_SEL<='0';
					  next_state<=R_type2;
	
	when R_type2=>RF_B_sel <="00";
	              ALU_A_sel <="00";
                 ALU_B_sel <="001";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='1';
					  RFLD_SEL<='0';
					  next_state<=R_type3;
	
	when R_type3=>RF_B_sel <="00";
	              ALU_A_sel <="00";
                 ALU_B_sel <="001";
					  RF_wr_data_sel <='0';
					  RF_wren<='1';
					  RFLD_SEL<='0';
					  PC_sel <= '0';
					  PC_lden <='1';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='0';
					  next_state<=Final;
					  
	when poly1=>  RF_B_sel <="00";
	              ALU_A_sel <="00";
                 ALU_B_sel <="000";
					  ALU_func <="0000";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='0';
					  AAR2_EN <='0';
					  POL_1 <='0';
					  POL_2 <='0';
					  POL_MUX <='0';
					  RFLD_SEL<='0';
					  next_state<=poly2;
	
	when poly2=>  RF_B_sel <="00";
	              ALU_A_sel <="00";
                 ALU_B_sel <="000";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='1';
					  AAR2_EN <='1';
					  POL_1 <='0';
					  POL_2 <='0';
					  RFLD_SEL<='0';
					  POL_MUX <='0';
					  next_state<=poly3;
					  
	when poly3=>  RF_B_sel <="00";
	              ALU_A_sel <="00";
                 ALU_B_sel <="000";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  RFLD_SEL<='0';
					  AAR1_EN <='0';
					  AAR2_EN <='0';
					  POL_1 <='1';
					  POL_2 <='0';
					  POL_MUX <='0';
					  next_state<=poly4;
					  
	when poly4=>  RF_B_sel <="00";
	              ALU_A_sel <="11";
                 ALU_B_sel <="001";
					  ALU_func <="1110";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='0';
					  AAR2_EN <='0';
					  RFLD_SEL<='0';
					  POL_1 <='0';
					  POL_2 <='0';
					  POL_MUX <='0';
					  next_state<=poly5;
					  
	when poly5=>  RF_B_sel <="00";
	              ALU_A_sel <="11";
                 ALU_B_sel <="001";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='1';
					  AAR2_EN <='0';
					  POL_1 <='1';
					  POL_2 <='1';
					  RFLD_SEL<='0';
					  POL_MUX <='0';
					  next_state<=poly6;
					  
	when poly6=>  RF_B_sel <="00";
	              ALU_A_sel <="10";
                 ALU_B_sel <="011";
					  ALU_func <="1110";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='1';
					  AAR2_EN <='0';
					  POL_1 <='0';
					  RFLD_SEL<='0';
					  POL_2 <='0';
					  POL_MUX <='1';
					  next_state<=poly7;
					  
	when poly7=>  RF_B_sel <="00";
	              ALU_A_sel <="10";
                 ALU_B_sel <="011";
					  ALU_func <="1110";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  RFLD_SEL<='0';
					  AAR1_EN <='0';
					  AAR2_EN <='0';
					  POL_1 <='0';
					  POL_2 <='0';
					  POL_MUX <='1';
					  next_state<=poly8;
					  
	when poly8=>  RF_B_sel <="00";
	              ALU_A_sel <="11";
                 ALU_B_sel <="011";
					  ALU_func <="1110";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  RFLD_SEL<='0';
					  AAR1_EN <='0';
					  AAR2_EN <='0';
					  POL_1 <='1';
					  POL_2 <='1';
					  POL_MUX <='1';
					  next_state<=poly9;
					  
	when poly9=>  RF_B_sel <="00";
	              ALU_A_sel <="11";
                 ALU_B_sel <="011";
					  ALU_func <="1110";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='0';
					  AAR2_EN <='1';
					  RFLD_SEL<='0';
					  POL_1 <='0';
					  POL_2 <='0';
					  POL_MUX <='1';
					  next_state<=poly10;
					  
	when poly10=>  RF_B_sel <="00";
	              ALU_A_sel <="10";
                 ALU_B_sel <="011";
					  ALU_func <="0000";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='0';
					  AAR2_EN <='0';
					  POL_1 <='0';
					  RFLD_SEL<='0';
					  POL_2 <='0';
					  POL_MUX <='1';
					  next_state<=poly11;
					  
	when poly11=>  RF_B_sel <="00";
	              ALU_A_sel <="10";
                 ALU_B_sel <="011";
					  ALU_func <="0000";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  RFLD_SEL<='0';
					  AAR1_EN <='1';
					  AAR2_EN <='0';
					  POL_1 <='0';
					  POL_2 <='0';
					  POL_MUX <='1';
					  next_state<=poly12;
					  
	when poly12=>  RF_B_sel <="00";
	              ALU_A_sel <="10";
                 ALU_B_sel <="100";
					  ALU_func <="0000";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='0';
					  AAR2_EN <='0';
					  POL_1 <='0';
					  POL_2 <='0';
					  RFLD_SEL<='0';
					  POL_MUX <='1';
					  next_state<=poly13;
					  
	when poly13=>  RF_B_sel <="00";
	              ALU_A_sel <="10";
                 ALU_B_sel <="100";
					  ALU_func <="0000";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='1';
					  AAR2_EN <='0';
					  POL_1 <='0';
					  POL_2 <='0';
					  POL_MUX <='1';
					  RFLD_SEL<='0';
					  next_state<=poly14;
					  
	when poly14=>  RF_B_sel <="00";
	              ALU_A_sel <="10";
                 ALU_B_sel <="100";
					  ALU_func <="0000";
					  RF_wr_data_sel <='0';
					  RF_wren<='1';
					  PC_sel <= '0';
					  PC_lden <='1';
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='0';
					  AAR2_EN <='0';
					  RFLD_SEL<='0';
					  POL_1 <='0';
					  POL_2 <='0';
					  POL_MUX <='1';
					  next_state<=Final;
                 					  
	when Branch_B=>PC_sel <= '1';
					   PC_lden <='1';
						RF_B_sel <="00";
	               ALU_A_sel <="00";
                  ALU_B_sel <="000";
					   RF_wr_data_sel <='0';
					   RF_wren<='0';
					   ALU_func <="0000";
						AAR1_EN <='1';
						next_state<=Final;
						
	when Branch=> RF_B_sel <="01";
	              ALU_A_sel <="00";
                 ALU_B_sel <="001";
					  RF_wren<='0';
					  ALU_func<="0001";
					  PC_sel <= '1';
                 PC_lden <='0';
                 RF_wr_data_sel <='0';
                 MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='1';
					  if(Opcode="000000") then next_state<=BEQ;
					  elsif(Opcode="000001") then next_state<=BNE;
					  else next_state<=nop;
					  end if;
					  
	when BEQ=>    PC_sel <= '1';
                 PC_lden <='0';
					  RF_wren<='0';
					  RF_B_sel <="01";
                 RF_wr_data_sel <='0';
					  ALU_A_sel <="00";
                 ALU_B_sel <="001";
                 ALU_func <="0001";
                 MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='1';
					  if(Zero='1') then next_state<=Branch_B;
					  else next_state<=nop;
					  end if;
					  
	when BNE=>    PC_sel <= '1';
                 PC_lden <='0';
					  RF_wren<='0';
					  RF_B_sel <="01";
                 RF_wr_data_sel <='0';
					  ALU_A_sel <="00";
                 ALU_B_sel <="001";
                 ALU_func <="0001";
                 MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='1';
					  if(Zero='0') then next_state<=Branch_B;
					  else next_state<=nop;
					  end if;
					  
	when SW=>     ALU_A_sel <="00";
                 ALU_B_sel <="010";
	              RF_B_sel <="01";
					  ALU_func <="0000";
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  PC_sel <= '0';
                 RF_wr_data_sel <='0';
					  PC_lden <='0';
					  RF_wren<='0';
					  AAR1_EN <='0';
					  POL_MUX <='0';
					  RFLD_SEL<='0';
                 MEM_dout_sel <='0';
					  next_state<=SW2;
	
	when SW2=>     ALU_A_sel <="00";
                 ALU_B_sel <="010";
	              RF_B_sel <="01";
					  ALU_func <="0000";
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  PC_sel <= '0';
                 RF_wr_data_sel <='0';
					  PC_lden <='0';
					  RF_wren<='0';
					  RFLD_SEL<='0';
					  AAR1_EN <='1';
					  POL_MUX <='0';
                 MEM_dout_sel <='0';
					  next_state<=SW3;
					  
	when SW3=>     ALU_A_sel <="00";
                 ALU_B_sel <="010";
	              RF_B_sel <="01";
					  ALU_func <="0000";
                 DATA_din_sel <='0';
                 DATA_wen <='1';
					  PC_sel <= '0';
                 RF_wr_data_sel <='0';
					  PC_lden <='1';
					  RF_wren<='0';
					  AAR1_EN <='0';
					  RFLD_SEL<='0';
					  POL_MUX <='0';
                 MEM_dout_sel <='0';
					  next_state<=Final;
					  
	when SB=>     DATA_din_sel <='1';
                 DATA_wen <='1';
                 PC_sel <= '0';
                 PC_lden <='1';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='0';
					  RF_wren<='0';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
					  MEM_dout_sel <='0';
					  AAR1_EN <='1';
					  next_state<=Final;
					  
   when LW_1=>	  MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='1';
					  RF_wren<='0';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='0';
					  POL_MUX<='0';
					  next_state<=LW_2;
	
	when LW_2=>	  MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='1';
					  RF_wren<='0';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='1';
					  POL_MUX<='0';
					  next_state<=Final;
					  
					  
	when LB_1=>   MEM_dout_sel <='1';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='1';
					  RF_wren<='0';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='1';
					  next_state<=LB_2;
				
	when LB_2=>   MEM_dout_sel <='1';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='1';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='1';
					  RF_wren<='1';
                 ALU_A_sel <="00";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='1';
					  next_state<=Final;
					  
	when Li_Lui=> MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='0';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='0';
					  RF_wren<='0';
                 ALU_A_sel <="01";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
					  RFLD_SEL<='0';
                 DATA_din_sel <='0';
					  AAR1_EN <='1';
					  next_state<=Li_Lui2;
					  
	when Li_Lui2=> MEM_dout_sel <='0';
	              DATA_wen <='0';
	              PC_sel <= '0';
                 PC_lden <='1';
                 RF_B_sel <="01";
                 RF_wr_data_sel <='0';
					  RF_wren<='1';
					  RFLD_SEL<='0';
                 ALU_A_sel <="01";
                 ALU_B_sel <="010";
                 ALU_func <="0000";
                 DATA_din_sel <='0';
					  AAR1_EN <='0';
					  next_state<=Final;
					  
	when I_type=> RF_B_sel <="01";
	              ALU_B_sel <="010";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  ALU_A_sel <="00";
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  RFLD_SEL<='0';
					  AAR1_EN <='1';
					  next_state<=I_type2;
	
	when I_type2=>RF_B_sel <="01";
	              ALU_B_sel <="010";
					  RF_wr_data_sel <='0';
					  RF_wren<='1';
					  PC_sel <= '0';
					  PC_lden <='1';
					  ALU_A_sel <="00";
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  AAR1_EN <='1';
					  RFLD_SEL<='0';
					  next_state<=Final;
					  
	when mmx1=>   RF_B_sel <="01";
	              ALU_B_sel <="010";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  ALU_A_sel <="00";
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  RFLD_SEL<='0';                 
					  ALU_func <="1111";
					  AAR1_EN <='0';
					  next_state<=mmx2;
					  
	when mmx2=>   RF_B_sel <="01";
	              ALU_B_sel <="010";
					  RF_wr_data_sel <='0';
					  RF_wren<='0';
					  PC_sel <= '0';
					  PC_lden <='0';
					  ALU_A_sel <="00";
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  ALU_func <="1111";
					  AAR1_EN <='1';
					  RFLD_SEL<='0';
					  next_state<=mmx3;
					  
	when mmx3=>   RF_B_sel <="01";
	              ALU_B_sel <="010";
					  RF_wr_data_sel <='0';
					  RF_wren<='1';
					  PC_sel <= '0';
					  PC_lden <='1';
					  ALU_A_sel <="00";
					  MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  ALU_func <="1111";
					  AAR1_EN <='0';
					  RFLD_SEL<='0';
					  next_state<=Final;
					  
	when Final=>  PC_sel <= '0';
                 PC_lden <='0';
					  PC_reset<='0';
                 RF_B_sel <="00";
                 RF_wr_data_sel <='0';
					  RF_wren<='0';
                 ALU_A_sel <="00";
                 ALU_B_sel <="000";
                 ALU_func <="0000";
                 MEM_dout_sel <='0';
                 DATA_din_sel <='0';
                 DATA_wen <='0';
					  POL_MUX <='0';
					  AAR1_EN <='0';
					  RFLD_SEL<='0';
					  CNT_EN<='0';
					  next_state<=START;
					 
	when state_reset=> PC_sel <= '0';
                      PC_lden <='0';
							 PC_reset<='1';
                      RF_B_sel <="00";
							 RFLD_SEL<='0';
                      RF_wr_data_sel <='0';
					       RF_wren<='0';
                      ALU_A_sel <="00";
                      ALU_B_sel <="000";
                      ALU_func <="0000";
                      MEM_dout_sel <='0';
                      DATA_din_sel <='0';
                      DATA_wen <='0';
							 AAR1_EN <='1';
							 next_state<=START;
							 
	when nop=>         PC_sel <= '0';
                      PC_lden <='1';
							 PC_reset<='0';
                      RF_B_sel <="00";
                      RF_wr_data_sel <='0';
					       RF_wren<='0';
                      ALU_A_sel <="00";
                      ALU_B_sel <="000";
                      ALU_func <="0000";
							 RFLD_SEL<='0';
                      MEM_dout_sel <='0';
                      DATA_din_sel <='0';
                      DATA_wen <='0';
							 AAR1_EN <='1';
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

