----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:59:38 05/05/2018 
-- Design Name: 
-- Module Name:    DEC_EX - Behavioral 
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

entity DEC_EX is
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
			  CLOCK : in  STD_LOGIC);                  
end DEC_EX;

architecture Behavioral of DEC_EX is

COMPONENT reg_1bit is
    Port ( Din : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC);
end COMPONENT;

COMPONENT reg_32bit is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT reg_5bit is
    Port ( Din : in  STD_LOGIC_VECTOR (4 downto 0);
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (4 downto 0));
end COMPONENT;

COMPONENT reg_4bit is
    Port ( Din : in  STD_LOGIC_VECTOR (3 downto 0);
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;

COMPONENT reg_6bit is
    Port ( Din : in  STD_LOGIC_VECTOR (5 downto 0);
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (5 downto 0));
end COMPONENT;

begin

RF_A_reg : reg_32bit
       Port map(Din=>A ,
                CLOCK=>CLOCK ,
                WE=>'1' , 
                Dout=>A_OUT );
RF_B_reg : reg_32bit
       Port map(Din=>B ,
                CLOCK=>CLOCK ,
                WE=>'1' , 
                Dout=>B_OUT );
IMMED_reg : reg_32bit
       Port map(Din=>IMMED ,
                CLOCK=>CLOCK ,
                WE=>'1' , 
                Dout=>IMMED_OUT );
------------------------------------
------------------------------------					 
RS_reg : reg_5bit
       Port map(Din=>rs ,
                CLOCK=>CLOCK ,
                WE=>'1' , 
                Dout=>rs_out );
RT_reg : reg_5bit
       Port map(Din=>rt ,
                CLOCK=>CLOCK ,
                WE=>'1' , 
                Dout=>rt_out );
RD_reg : reg_5bit
       Port map(Din=>rd ,
                CLOCK=>CLOCK ,
                WE=>'1' , 
                Dout=>rd_out );
ALU_FUNC_reg : reg_4bit
       Port map(Din=>FUNC ,
                CLOCK=>CLOCK ,
                WE=>'1' , 
                Dout=>FUNC_OUT );
OPCODE_REG : reg_6bit
      Port map(Din=>OPCODE_IN,
		         CLOCK=>CLOCK,
					WE=>'1',
					Dout=>OPCODE_OUT);
-----------------------------------
-----------------------------------					 
RF_WE_reg : reg_1bit
       Port map(Din=>RF_WE ,
                CLOCK=>CLOCK ,
                WE=>'1' , 
                Dout=>RF_WE_OUT );
RF_WDATA_reg : reg_1bit
       Port map(Din=>RF_WDATA ,
                CLOCK=>CLOCK ,
                WE=>'1' , 
                Dout=>RF_WDATA_OUT );
ALU_BIN_reg : reg_1bit
       Port map(Din=>ALU_BIN ,
                CLOCK=>CLOCK ,
                WE=>'1' , 
                Dout=>ALU_BIN_OUT );
MEM_WR_reg : reg_1bit
       Port map(Din=>MEM_WR ,
                CLOCK=>CLOCK ,
                WE=>'1' , 
                Dout=>MEM_WR_OUT );
					



end Behavioral;

