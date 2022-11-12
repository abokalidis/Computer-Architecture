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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
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

Component ADDER_IF is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
           Y : in  STD_LOGIC_VECTOR (31 downto 0);
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component general_MUX_2_1 is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
           Y : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           E : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component RAM is
    Port ( inst_addr : in  STD_LOGIC_VECTOR (10 downto 0);
           inst_dout : out  STD_LOGIC_VECTOR (31 downto 0);
           data_we : in  STD_LOGIC;
           data_addr : in  STD_LOGIC_VECTOR (10 downto 0);
           data_din : in  STD_LOGIC_VECTOR (31 downto 0);
           data_dout : out  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC);
end component;

signal pc_4,add_out,mux_out,pc_out,zero : std_logic_vector (31 downto 0);
begin

ADDER : ADDER_IF
        Port map( X=>PC_Immed,
                  Y=>pc_4,
                  Z=>add_out);

MUX : general_MUX_2_1
      Port map( X=>pc_4,
                Y=>add_out,
                C=>PC_Sel,
                E=>mux_out);	

PC : REG_PC
     Port map( Din=>mux_out,
            We=>PC_LdEn,
            Rst=>Reset,
            Clock=>Clk,
            Dout=>pc_out);
				
Increment : INCREMENTOR
             Port map( A=>pc_out,
                    B=>pc_4);
     				 
Ram_mod : RAM
          Port map( inst_addr=>pc_out(12 downto 2),
                    inst_dout=>Instr,
                    data_we=>'0',
                    data_addr=>"00000000000",
                    data_din=>"00000000000000000000000000000000", 
                    data_dout=>zero, 
                    clk=>Clk);

zero<="00000000000000000000000000000000";
end Behavioral;

