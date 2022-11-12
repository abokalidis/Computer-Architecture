----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:04:42 03/13/2018 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
			  ADDR_SEL : in  STD_LOGIC_VECTOR (1 downto 0);
			  PC_EPC : in  STD_LOGIC;
			  EPC_4 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : out  STD_LOGIC_VECTOR (31 downto 0);
			  EPC_IN : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

Component REG_PC is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           We : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component INCREMENTOR is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component IF_MUX_S is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component IF_MUX_B is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC_VECTOR (31 downto 0);
           D : in  STD_LOGIC_VECTOR (31 downto 0);
           SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

signal pc_4,pc_out,out1,out2,epc : std_logic_vector (31 downto 0);
begin

PC_REG : REG_PC
     Port map( Din=>pc_4,
               We=>PC_LdEn,
               Rst=>Reset,
               Clock=>Clk,
               Dout=>pc_out);
				
Increment : INCREMENTOR
             Port map( A=>out2,
                       B=>pc_4);
							  
Small_Mux : IF_MUX_S
 Port map( A=>pc_out,
           B=>epc, 
           C=>PC_EPC, 
           Z=>out1 );

Big_Mux : IF_MUX_B
    Port map( A=>out1, 
              B=>"00000000000000000000001100000000", 
              C=>"00000000000000000000001000000000",
              D=>"00000000000000000000000100000000",
              SEL=>ADDR_SEL, 
              Z=>out2);
			  
PC<=out2;	
EPC_IN<=out1;
epc<=EPC_4 + "00000000000000000000000000000100";		 
end Behavioral;

