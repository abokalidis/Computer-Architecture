----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:46:48 04/22/2018 
-- Design Name: 
-- Module Name:    POLYBOX - Behavioral 
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

entity POLYBOX is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
	        Clock : in  STD_LOGIC;
			  Enable1 : in  STD_LOGIC;
			  Enable2 : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (31 downto 0));
end POLYBOX;

architecture Behavioral of POLYBOX is

signal sig,sig1,sig2 : std_logic_vector (31 downto 0);

Component POLY_REG is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           Clk : in  STD_LOGIC;
           En : in  STD_LOGIC;
           B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component POLY_INCREMENTOR is
    Port ( F : in  STD_LOGIC_VECTOR (31 downto 0);
           G : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component MUX_S_L is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

begin

Pol_reg : POLY_REG
     Port map(A=>sig1,
	           Clk=>Clock,
				  En=>Enable1,
				  B=>sig2);
Pol_incr : POLY_INCREMENTOR
      Port map(F=>sig2,
		         G=>sig);
PMUX : MUX_S_L
      Port map(A=>X,
		         B=>sig,
					C=>Enable2,
					Z=>sig1);
					
Y<=sig2;			
				
end Behavioral;

