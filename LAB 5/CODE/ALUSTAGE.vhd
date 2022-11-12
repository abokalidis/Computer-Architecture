----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:49:08 03/11/2018 
-- Design Name: 
-- Module Name:    ALUSTAGE - Behavioral 
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

entity ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  Z_out : out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end ALUSTAGE;

architecture Behavioral of ALUSTAGE is

Component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Outt : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
			  Ovf : out  STD_LOGIC);
end component;
 
signal co : std_logic_vector (1 downto 0); 
begin

ALU_mod : ALU 
          Port map(A=>RF_A,
                   B=>RF_B,
                   Op=>ALU_func,
                   Outt=>ALU_out,
                   Zero=>Z_out,
                   Cout=>co(0),
			          Ovf=>co(1));
end Behavioral;
