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
    Port ( RESET : in  STD_LOGIC;
			  CLOCK : in  STD_LOGIC);
end DATAPATH;

architecture Behavioral of Datapath is

Component ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  OVF_out : out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_Wr_En : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_Wr_Data_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
			  AWRIN : in  STD_LOGIC_VECTOR (4 downto 0); 
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component IFSTAGE is
    Port ( PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
			  ADDR_SEL : in  STD_LOGIC_VECTOR (1 downto 0);
			  PC_EPC : in  STD_LOGIC;
			  EPC_4 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : out  STD_LOGIC_VECTOR (31 downto 0);
			  EPC_IN : out  STD_LOGIC_VECTOR (31 downto 0));
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

Component CONTROL_UNIT is
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
end Component;

-----------------------------------------------------------------------------------------------------
Component MUX_32x1 is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC_VECTOR (31 downto 0);
			  D : in  STD_LOGIC_VECTOR (31 downto 0);
			  SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component IF_DEC is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component DEC_EX is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
	        A_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
			  B_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           IMMED : in  STD_LOGIC_VECTOR (31 downto 0);
			  IMMED_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
			  OPCODE_IN : in  STD_LOGIC_VECTOR (5 downto 0);
			  OPCODE_OUT : out  STD_LOGIC_VECTOR (5 downto 0);
           rs : in  STD_LOGIC_VECTOR (4 downto 0);
			  rs_out : out  STD_LOGIC_VECTOR (4 downto 0);
           rt : in  STD_LOGIC_VECTOR (4 downto 0);
			  rt_out : out  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
			  rd_out : out  STD_LOGIC_VECTOR (4 downto 0);
			  FUNC : in  STD_LOGIC_VECTOR (3 downto 0);
			  FUNC_OUT : out  STD_LOGIC_VECTOR (3 downto 0);
           RF_WE : in  STD_LOGIC;
			  RF_WE_OUT : out  STD_LOGIC;
           RF_WDATA : in  STD_LOGIC;
			  RF_WDATA_OUT : out  STD_LOGIC;
           ALU_BIN : in  STD_LOGIC;
			  ALU_BIN_OUT : out  STD_LOGIC;
           MEM_WR : in  STD_LOGIC;
			  MEM_WR_OUT : out  STD_LOGIC;
			  CLOCK : in  STD_LOGIC;
			  PIPELINE_EN : in  STD_LOGIC);                  
end Component;

Component general_MUX_2_1 is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
           Y : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           E : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component EX_MEM is
    Port ( ALU : in  STD_LOGIC_VECTOR (31 downto 0);
	        ALU_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_WE : in  STD_LOGIC;
			  RF_WE_OUT : out  STD_LOGIC;
           RF_WDATA : in  STD_LOGIC;
			  RF_WDATA_OUT : out  STD_LOGIC;
           MEM_WR : in  STD_LOGIC;
			  MEM_WR_OUT : out  STD_LOGIC;
			  rs : in  STD_LOGIC_VECTOR (4 downto 0);
			  rs_out : out  STD_LOGIC_VECTOR (4 downto 0);
           rt : in  STD_LOGIC_VECTOR (4 downto 0);
			  rt_out : out  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
			  rd_out : out  STD_LOGIC_VECTOR (4 downto 0);
			  CLOCK : in  STD_LOGIC;
			  PIPELINE2_EN : in  STD_LOGIC) ;                
end Component;

Component MEM_WB is
    Port ( MEM_DATA : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DATA_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B_DATA : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B_DATA_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
			  RF_WE : in  STD_LOGIC;
			  RF_WE_OUT : out  STD_LOGIC;
           RF_WDATA : in  STD_LOGIC;
			  RF_WDATA_OUT : out  STD_LOGIC;
			  rs : in  STD_LOGIC_VECTOR (4 downto 0);
			  rs_out : out  STD_LOGIC_VECTOR (4 downto 0);
           rt : in  STD_LOGIC_VECTOR (4 downto 0);
			  rt_out : out  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
			  rd_out : out  STD_LOGIC_VECTOR (4 downto 0);
           CLOCK : in  STD_LOGIC);
end Component;

Component PRE_EPC_MUX is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component EPC_REG is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component EXCEPTION_UNIT is
    Port ( Ovf : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
			  OPCODE_EXCEPTION : in  STD_LOGIC_VECTOR (5 downto 0);
           Illegal_OpCode : in  STD_LOGIC;
           DecEx_wren : out  STD_LOGIC;
           ExMem_wren : out  STD_LOGIC;
           IF_Stage_mux_sel : out  STD_LOGIC_VECTOR(1 downto 0);
			  Pre_epc_sel : out  STD_LOGIC;
			  EPC_EN : out  STD_LOGIC;
           Cause_reg_value : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component TOP_CACHE is
    Port ( Data_addr : in  STD_LOGIC_VECTOR (10 downto 0);
	        Cache_Reg_En : out  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Cache_data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component CACHE_REG_MOD is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           --CLOCK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

-----------------------------------------------------------------------------------------------------

signal pc_out,immed_sig,instr_sig,rf_a_out,rf_b_out,alu_out_sig,alu_a_in,data_din_sig,
       data_dout_sig,mem_out_sig,if_dec_out,rf_a,rf_b,alu_b,
       immed_sig_out,alu_b_in,alu_data,alu_result,pr_epc_in_sig, 
		 pr_epc_out_sig,epc_out,cause_out,cause_in,cache_out,cache_out1 : std_logic_vector (31 downto 0);

signal alu_mem : std_logic_vector (10 downto 0);
signal alu_bin_s,rfbsel,rfwren2,rfwren3,rfwrdatasel,rfwrdatasel2,rfwren,datawen,
       datawen2,datawen3,rfwrdatasel3,OVF,RF_WR_EN,RF_WDATA_SEL,
       RF_B_SEL,IF_DEC_EN,IMEM_ENABLE,alubsel,decex_en,exmem_en,
		 sig_PC_EPC_SEL,sig_Illegal_instr_check,sig_Pre_epc_sel,sig_EPC_EN,Cache_Reg_En_sig: std_logic;
signal PCL : std_logic;
signal ALU_FUNC,alufunc : std_logic_vector (3 downto 0);
signal rs_out1,rs_out2,rt_out1,rt_out2,rd_out1,rd_out2,
       rt_out3,rs_out3,rd_out3 : std_logic_vector (4 downto 0);
signal fwa,fwb,ifstage_addr : std_logic_vector (1 downto 0);
signal opcode_sig : std_logic_vector (5 downto 0);


begin

RAM_mod : RAM
          Port Map(inst_addr => pc_out(12 downto 2),
                   inst_dout => instr_sig,
                   data_we => datawen3,
                   data_addr => alu_mem,
                   data_din =>data_din_sig,
                   data_dout =>data_dout_sig,
                   clk => CLOCK);

IFSTAGE_mod : IFSTAGE
              Port Map(PC_LdEn =>'1',
                       Reset => RESET,
                       Clk => CLOCK,
							  EPC_4 => epc_out,
							  ADDR_SEL => ifstage_addr,
			              PC_EPC => sig_PC_EPC_SEL,
							  EPC_IN =>pr_epc_in_sig,
                       PC => pc_out);
							  
PRE_EPC : PRE_EPC_MUX 
    Port map( A=>pr_epc_in_sig, 
              C=>sig_Pre_epc_sel,
              Z=>pr_epc_out_sig );
				  
EXCEPTION : EXCEPTION_UNIT 
    Port map( Ovf => OVF,
              ALU_out => alu_out_sig,
				  OPCODE_EXCEPTION => opcode_sig,
              Illegal_OpCode => sig_Illegal_instr_check,
              DecEx_wren => decex_en,
              ExMem_wren => exmem_en,
              IF_Stage_mux_sel => ifstage_addr,
				  Pre_epc_sel => sig_Pre_epc_sel,
				  EPC_EN => sig_EPC_EN,
              Cause_reg_value =>cause_in);
				  
EPC : EPC_REG
      Port map( Din => pr_epc_out_sig,
                CLOCK => CLOCK,
                WE => sig_EPC_EN,
                Dout => epc_out);

CAUSE_REG : EPC_REG
      Port map( Din => cause_in,
                CLOCK => CLOCK,
                WE => '1',
                Dout => cause_out);

CACHE : TOP_CACHE 
    Port map( Data_addr=>alu_out_sig(12 downto 2),
              Cache_Reg_En =>	Cache_Reg_En_sig, 
              CLK=>CLOCK,
              Cache_data_out=>cache_out);

CACHE_REG : CACHE_REG_MOD
      Port map( Din => cache_out,
                --CLOCK => CLOCK,
                WE => Cache_Reg_En_sig,
                Dout => cache_out1);

DECSTAGE_mod : DECSTAGE
               Port Map(Instr => instr_sig,
                        RF_Wr_En => RF_WR_EN,
                        ALU_out => alu_result,
                        MEM_out => cache_out1,
                        RF_Wr_Data_sel => RF_WDATA_SEL,
                        RF_B_sel => rfbsel,
                        Clk => CLOCK,
								AWRIN=>rd_out3,
                        Immed => immed_sig,
                        RF_A => rf_a_out,
                        RF_B => rf_b_out);
								
ALUSTAGE_mod : ALUSTAGE
               Port Map(RF_A => alu_a_in,
                        RF_B => alu_b_in, 
                        ALU_func => ALU_FUNC,
								OVF_out => OVF,
                        ALU_out => alu_out_sig);

IMMED_RF_B_MUX : general_MUX_2_1
    Port map( X =>rf_b,
              Y =>immed_sig_out,
              C =>alu_bin_s,
              E =>alu_b);
								
ALU_AIN_MUX : MUX_32x1
        Port Map(A=>rf_a,
                 B=>alu_result, 
                 C=>alu_data, 
					  D=> "00000000000000000000000000000000",
					  SEL=> "00",
                 Z=> alu_a_in);

ALU_BIN_MUX : MUX_32x1
        Port Map(A=>alu_b,
                 B=>alu_result, 
                 C=>alu_data, 
					  D=> "00000000000000000000000000000000",
					  SEL=> "00",
                 Z=> alu_b_in);
					  

MEM_WB_REG : MEM_WB 
Port map ( MEM_DATA=>data_dout_sig,
           MEM_DATA_OUT=>mem_out_sig,
           RF_B_DATA=>alu_data,
           RF_B_DATA_OUT=>alu_result,
			  RF_WE=>rfwren3,
			  RF_WE_OUT=> RF_WR_EN,
           RF_WDATA=>rfwrdatasel3,
			  RF_WDATA_OUT=>RF_WDATA_SEL,
			  rs=>rs_out2, 
			  rs_out=>rs_out3,
           rt=>rt_out2, 
			  rt_out=>rt_out3,
           rd=>rd_out2, 
			  rd_out=>rd_out3,
           CLOCK=>CLOCK
			  );

EX_MEM_REG : EX_MEM 
    Port map ( ALU=>alu_out_sig,
	            ALU_OUT=>alu_data,
               RF_B=>rf_b,
			      RF_B_OUT=>data_din_sig,
               RF_WE=>rfwren2,
			      RF_WE_OUT=>rfwren3,
               RF_WDATA=>rfwrdatasel2,
			      RF_WDATA_OUT=>rfwrdatasel3,
               MEM_WR=>datawen2,
			      MEM_WR_OUT=>datawen3,
					rs=>rs_out1,
			      rs_out=>rs_out2, 
               rt=>rt_out1,
			      rt_out=>rt_out2,
               rd=>rd_out1, 
			      rd_out=>rd_out2, 
			      CLOCK=>CLOCK,
					PIPELINE2_EN=>exmem_en) ; 					 

DEC_EX_REG : DEC_EX
      Port map( A=> rf_a_out,
	             A_OUT => rf_a,
                B => rf_b_out,
			       B_OUT =>rf_b,
                IMMED => immed_sig,
			       IMMED_OUT => immed_sig_out,
					 OPCODE_IN => instr_sig(31 downto 26),
			       OPCODE_OUT => opcode_sig,
                rs => instr_sig(25 downto 21),
			       rs_out => rs_out1,
                rt => instr_sig(15 downto 11),
			       rt_out => rt_out1,
                rd => instr_sig(20 downto 16),
			       rd_out => rd_out1,
					 FUNC=>alufunc,
					 FUNC_OUT=>ALU_FUNC,
                RF_WE=>rfwren,
			       RF_WE_OUT=>rfwren2,
                RF_WDATA=>rfwrdatasel,
			       RF_WDATA_OUT=>rfwrdatasel2,
                ALU_BIN=>alubsel,
			       ALU_BIN_OUT => alu_bin_s,
                MEM_WR=>datawen,
			       MEM_WR_OUT=>datawen2,
			       CLOCK => CLOCK,
					 PIPELINE_EN =>decex_en);		

CONTROL : CONTROL_UNIT 
    Port map( Instr=>instr_sig,
			     Opcode=>instr_sig(31 downto 26),
			     Func=>instr_sig(5 downto 0),
              RF_B_sel=>rfbsel ,
              RF_wr_data_sel=>rfwrdatasel ,
			     RF_wren=>rfwren ,
				  ALU_BIN_sel=>alubsel,
              ALU_func=>alufunc ,
              DATA_wen=>datawen,
              PC_EPC_SEL=>sig_PC_EPC_SEL,
			     Illegal_instr_check=>sig_Illegal_instr_check);			  
					  
---------------------------------------------------------------					  
alu_mem <= alu_data(12 downto 2) + "10000000000";

end Behavioral;

