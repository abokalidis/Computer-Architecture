----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:01:57 05/05/2018 
-- Design Name: 
-- Module Name:    EX_MEM - Behavioral 
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

entity EX_MEM is
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
end EX_MEM;

architecture Behavioral of EX_MEM is

COMPONENT reg_32bit is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT reg_4bit is
    Port ( Din : in  STD_LOGIC_VECTOR (3 downto 0);
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;

COMPONENT reg_5bit is
    Port ( Din : in  STD_LOGIC_VECTOR (4 downto 0);
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (4 downto 0));
end COMPONENT;

COMPONENT reg_1bit is
    Port ( Din : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC);
end COMPONENT;

begin

ALU_OUT_reg : reg_32bit 
    Port map( Din=> ALU,
              CLOCK => CLOCK,
				  WE=>PIPELINE2_EN, 
              Dout=> ALU_OUT);
RF_B_reg : reg_32bit 
    Port map( Din=> RF_B,
              CLOCK => CLOCK,
				  WE=>PIPELINE2_EN, 
              Dout=> RF_B_OUT);
-------------------------------
-------------------------------
RF_WE_reg : reg_1bit 
    Port map( Din=> RF_WE,
              CLOCK => CLOCK,
				  WE=>PIPELINE2_EN, 
              Dout=> RF_WE_OUT);
RF_WDATA_reg : reg_1bit 
    Port map( Din=> RF_WDATA,
              CLOCK => CLOCK,
				  WE=>PIPELINE2_EN, 
              Dout=> RF_WDATA_OUT);
MEM_WR_reg : reg_1bit 
    Port map( Din=> MEM_WR,
              CLOCK => CLOCK,
				  WE=>PIPELINE2_EN, 
              Dout=> MEM_WR_OUT);
---------------------------------
---------------------------------
RS_reg : reg_5bit
       Port map(Din=>rs ,
                CLOCK=>CLOCK ,
                WE=>PIPELINE2_EN , 
                Dout=>rs_out );
RT_reg : reg_5bit
       Port map(Din=>rt ,
                CLOCK=>CLOCK ,
                WE=>PIPELINE2_EN , 
                Dout=>rt_out );
RD_reg : reg_5bit
       Port map(Din=>rd ,
                CLOCK=>CLOCK ,
                WE=>PIPELINE2_EN , 
                Dout=>rd_out );
				  

end Behavioral;

