----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:12:20 03/03/2018 
-- Design Name: 
-- Module Name:    ADD - Behavioral 
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

entity ADD is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Ot : out  STD_LOGIC_VECTOR (31 downto 0);
           OVF : out  STD_LOGIC;
			  Z : out  STD_LOGIC;
           COUT : out  STD_LOGIC);
end ADD;

architecture Behavioral of ADD is
signal output,x,y : std_logic_vector (32 downto 0);

begin
Ot<=A+B;

x(31 downto 0)<=A;
x(32)<='0';
y(31 downto 0)<=B;
y(32)<='0';
output<=x+y;

cout_pr : process(output)
begin
if(output(32)='1') then COUT<='1';
else COUT<='0';
end if;
end process cout_pr;

ovf_pr : process(x,y,output)
begin
if(x(31)=y(31) and y(31)/=output(31)) then OVF<='1';
else OVF<='0';
end if;
end process ovf_pr; 

z_pr : process(output)
begin
if(output(31 downto 0)="00000000000000000000000000000000") then z<='1';
else z<='0';
end if;
end process z_pr;

end Behavioral;

