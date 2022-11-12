----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:48:37 03/23/2018 
-- Design Name: 
-- Module Name:    PROCESSOR - Behavioral 
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

entity PROCESSOR is
    Port ( RESET : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC);
end PROCESSOR;

architecture Behavioral of PROCESSOR is

Component CONTROL_UNIT is
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
           RF_B_sel : out  STD_LOGIC_VECTOR(1 downto 0);
           RF_wr_data_sel : out  STD_LOGIC;
			  RF_wren : out  STD_LOGIC;
           ALU_A_sel : out  STD_LOGIC_VECTOR(1 downto 0);
           ALU_B_sel : out  STD_LOGIC_VECTOR(2 downto 0);
           ALU_func : out  STD_LOGIC_VECTOR(3 downto 0);
           MEM_dout_sel : out  STD_LOGIC;
           DATA_din_sel : out  STD_LOGIC;
           DATA_wen : out  STD_LOGIC);
end Component;

Component DATAPATH is
    Port ( PC_SEL : in  STD_LOGIC;
           PC_LDEN : in  STD_LOGIC;
			  PC_RESET : in  STD_LOGIC;
			  CLOCK : in  STD_LOGIC;
			  RF_WR_EN : in STD_LOGIC;
			  RF_B_SEL : in  STD_LOGIC_VECTOR(1 downto 0);
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
			  AAR1 : in STD_LOGIC;
			  AAR2 : in  STD_LOGIC;
			  POL_EN1 : in  STD_LOGIC;
			  POL_EN2 : in  STD_LOGIC;
			  POL_MUX_EN : in  STD_LOGIC;
			  ZERO : out  STD_LOGIC;
			  OPCODE : out STD_LOGIC_VECTOR(5 downto 0);
			  FUNC : out STD_LOGIC_VECTOR(5 downto 0);
			  INSTR : out STD_LOGIC_VECTOR(31 downto 0));
end Component;

signal zero_sig,mcen,cen,rcsig,pc_sel_sig,pc_lden_sig,pc_reset_sig,rf_wr_data_sel_sig,rf_wren_sig,mem_dout,data_din,data_wen,alu_reg1_out,alu_reg2_out,p1en,p2en, pmen : std_logic;
signal opcode_sig,func_sig : STD_LOGIC_VECTOR(5 downto 0);
signal alu_func_sig : STD_LOGIC_VECTOR(3 downto 0);
signal alu_a,rf_b_sel_sig : STD_LOGIC_VECTOR(1 downto 0);
signal alu_b : STD_LOGIC_VECTOR(2 downto 0);
signal instr : STD_LOGIC_VECTOR(31 downto 0);

begin

CONTROL : CONTROL_UNIT
          Port Map(Reset=>RESET,
                   CLK=>CLOCK,
			          Zero=>zero_sig,
			          Opcode=>opcode_sig,
						 Instr => instr,
			          Func=>func_sig,
						 AAR1_EN	=> alu_reg1_out,
						 AAR2_EN => alu_reg2_out,
			          POL_1 => p1en,
			          POL_2 => p2en,
			          POL_MUX => pmen,
                   PC_sel=>pc_sel_sig,
                   PC_lden=>pc_lden_sig,
			          PC_reset=>pc_reset_sig,
                   RF_B_sel=>rf_b_sel_sig,
                   RF_wr_data_sel=>rf_wr_data_sel_sig,
			          RF_wren=>rf_wren_sig,
                   ALU_A_sel=>alu_a,
                   ALU_B_sel=>alu_b,
                   ALU_func=>alu_func_sig,
                   MEM_dout_sel=>mem_dout,
                   DATA_din_sel=>data_din,
                   DATA_wen=>data_wen,
						 RC => rcsig,
			          RFLD_SEL => mcen,
			          CNT_EN =>cen );
						 
DATA_PATH : DATAPATH
           Port map(PC_SEL=>pc_sel_sig,
                    PC_LDEN=>pc_lden_sig,
			           PC_RESET=>pc_reset_sig,
			           CLOCK=>CLOCK,
			           RF_WR_EN=>rf_wren_sig,
			           RF_B_SEL=>rf_b_sel_sig,
			           RF_WDATA_SEL=>rf_wr_data_sel_sig,
			           ALU_AIN_SEL=>alu_a,
			           ALU_BIN_SEL=>alu_b,
			           ALU_FUNC=>alu_func_sig,
			           MEM_DOUT_SEL=>mem_dout,
			           DATA_DIN_SEL=>data_din,
			           DATA_WE_EN=>data_wen,
						  MUX_C_EN => mcen,
			           Counter_En =>cen,
			           RC =>rcsig,
						  AAR1 => alu_reg1_out,
						  AAR2 => alu_reg2_out,
			           POL_EN1 => p1en,
			           POL_EN2 => p2en,
			           POL_MUX_EN => pmen,
			           ZERO=>zero_sig,
			           OPCODE=>opcode_sig,
			           FUNC=>func_sig,
						  INSTR=>instr);

end Behavioral;

