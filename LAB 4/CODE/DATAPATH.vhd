----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:22:06 03/21/2018 
-- Design Name: 
-- Module Name:    Datapath - Behavioral 
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

entity DATAPATH is
    Port ( PC_SEL : in  STD_LOGIC;
           PC_LDEN : in  STD_LOGIC;
			  PC_RESET : in  STD_LOGIC;
			  CLOCK : in  STD_LOGIC;
			  RF_WR_EN : in STD_LOGIC;
			  RF_B_SEL : in  STD_LOGIC_VECTOR (1 downto 0);
			  RF_WDATA_SEL : in  STD_LOGIC;
			  ALU_AIN_SEL : in  STD_LOGIC_VECTOR(1 downto 0);
			  ALU_BIN_SEL : in  STD_LOGIC_VECTOR(2 downto 0);
			  ALU_FUNC : in  STD_LOGIC_VECTOR(3 downto 0);
			  MEM_DOUT_SEL : in  STD_LOGIC;
			  DATA_DIN_SEL : in  STD_LOGIC;
			  DATA_WE_EN : in  STD_LOGIC;
			  MUX_C_EN : in  STD_LOGIC;
			  Counter_En : in  STD_LOGIC;
			  RC : out  STD_LOGIC;
			  AAR1 : in  STD_LOGIC;
			  AAR2 : in  STD_LOGIC;
			  POL_EN1 : in  STD_LOGIC;
			  POL_EN2 : in  STD_LOGIC;
			  POL_MUX_EN : in  STD_LOGIC;
			  ZERO : out  STD_LOGIC;
			  OPCODE : out STD_LOGIC_VECTOR(5 downto 0);
			  FUNC : out STD_LOGIC_VECTOR(5 downto 0);
			  INSTR : out STD_LOGIC_VECTOR(31 downto 0));
end DATAPATH;

architecture Behavioral of Datapath is

Component ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC_VECTOR(2 downto 0);
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  DDout : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_R2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Z_out : out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_Wr_En : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_Wr_Data_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  M_EN : in STD_LOGIC;
			  C_EN : in STD_LOGIC;
			  C_RC : out STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component RAM is
    Port ( inst_addr : in  STD_LOGIC_VECTOR (10 downto 0);
           inst_dout : out  STD_LOGIC_VECTOR (31 downto 0);
           data_we : in  STD_LOGIC;
           data_addr : in  STD_LOGIC_VECTOR (10 downto 0);
           data_din : in  STD_LOGIC_VECTOR (31 downto 0);
           data_dout : out  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC);
end Component;
-----------------------------------------------------------------------------------------------------
Component MUX_32x1 is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
			  C : in  STD_LOGIC_VECTOR (31 downto 0);
			  D : in  STD_LOGIC_VECTOR (31 downto 0);
           Se : in  STD_LOGIC_VECTOR (1 downto 0);
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component AFTER_ALU_REG is
    Port ( DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           CLCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component POLYBOX is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
	        Clock : in  STD_LOGIC;
			  Enable1 : in  STD_LOGIC;
			  Enable2 : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component POLY_MUX is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
           Y : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component MUX_S_L is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

-----------------------------------------------------------------------------------------------------

signal pc_out,immed_sig,instr_sig,rf_a_out,rf_b_out,alu_out_sig,alu_reg1_out,alu_reg2_out,alu_a_in,
LSbyte2,LSbyte3,data_din_sig,
data_dout_sig,mem_out_sig,poly_out,polymuxout : std_logic_vector (31 downto 0);

signal alu_out : std_logic_vector (10 downto 0);

begin

RAM_mod : RAM
          Port Map(inst_addr => pc_out(12 downto 2),
                   inst_dout => instr_sig,
                   data_we => DATA_WE_EN,
                   data_addr => alu_out,
                   data_din =>data_din_sig,
                   data_dout =>data_dout_sig,
                   clk => CLOCK);

IFSTAGE_mod : IFSTAGE
              Port Map(PC_Immed => immed_sig,
                       PC_sel => PC_SEL,
                       PC_LdEn => PC_LDEN,
                       Reset => PC_RESET,
                       Clk => CLOCK,
                       PC => pc_out);

DECSTAGE_mod : DECSTAGE
               Port Map(Instr => instr_sig,
                        RF_Wr_En => RF_WR_EN,
                        ALU_out => alu_reg1_out,
                        MEM_out => mem_out_sig,
                        RF_Wr_Data_sel => RF_WDATA_SEL,
                        RF_B_sel => RF_B_SEL,
                        Clk => CLOCK,
								M_EN => MUX_C_EN,
			               C_EN => Counter_En,
			               C_RC => RC,
                        Immed => immed_sig,
                        RF_A => rf_a_out,
                        RF_B => rf_b_out);
								
ALUSTAGE_mod : ALUSTAGE
               Port Map(RF_A => alu_a_in,
                        RF_B => rf_b_out,
                        Immed => immed_sig,
                        ALU_Bin_sel => ALU_BIN_SEL, 
                        ALU_func => ALU_FUNC,
								DDout=>data_dout_sig,
			               ALU_R2=>alu_reg2_out,
								Z_out => ZERO,
                        ALU_out => alu_out_sig);
								
POLY : POLYBOX
      Port map( X =>alu_reg1_out,
	             Clock =>CLOCK,
			       Enable1 => POL_EN1,
			       Enable2 => POL_EN2,
                Y =>poly_out);

Pol_Mux : POLY_MUX
      Port map(X =>alu_reg1_out,
               Y =>poly_out,
               C =>POL_MUX_EN,
               Z =>polymuxout);
								
ALU_AIN_MUX : MUX_32x1
        Port Map(A=>rf_a_out,
                 B=>"00000000000000000000000000000000", 
					  C=>alu_reg1_out,
					  D=>rf_b_out,
                 Se=> ALU_AIN_SEL,
                 Z=> alu_a_in);

AFTER_ALU_REG_1 : AFTER_ALU_REG
			 Port map ( DataIn => alu_out_sig,
							CLCK => CLOCK,
							WE => AAR1,
							DataOut => alu_reg1_out);
AFTER_ALU_REG_2 : AFTER_ALU_REG
			 Port map ( DataIn => alu_out_sig,
							CLCK => CLOCK,
							WE => AAR2,
							DataOut => alu_reg2_out);

STORE_MUX : MUX_S_L
        Port Map(A=>rf_b_out,
                 B=>LSbyte2,
                 C=> DATA_DIN_SEL, 
                 Z=>data_din_sig);
					  
LOAD_MUX : MUX_S_L
        Port Map(A=>data_dout_sig,
                 B=>LSbyte3,
                 C=> MEM_DOUT_SEL, 
                 Z=>mem_out_sig);
					  
alu_out <= polymuxout(12 downto 2) + "10000000000";
					  
LSbyte2(31 downto 8)<="000000000000000000000000";
LSbyte2(7 downto 0) <=rf_b_out(7 downto 0);

LSbyte3(31 downto 8)<="000000000000000000000000";
LSbyte3(7 downto 0)<=data_dout_sig(7 downto 0);

OPCODE<=instr_sig(31 downto 26);
FUNC<=instr_sig(5 downto 0);
INSTR<=instr_sig;
end Behavioral;

