----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:13:31 03/03/2018 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Outt : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
			  Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal op_add,op_sub,log_nand,log_or,log_not,op_sra,op_srl,op_sll,rotateR,rotateL : std_logic_vector(31 downto 0);
signal add_ovf,add_z,add_cout,sub_ovf,sub_z,sub_cout : std_logic;

Component ADD is     
Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
       B : in  STD_LOGIC_VECTOR (31 downto 0);
       Ot : out  STD_LOGIC_VECTOR (31 downto 0);
       OVF : out  STD_LOGIC;
		 Z : out  STD_LOGIC;
       COUT : out  STD_LOGIC); 
end component;

Component SUB is     
Port ( C : in  STD_LOGIC_VECTOR (31 downto 0);
       D : in  STD_LOGIC_VECTOR (31 downto 0);
       Output : out  STD_LOGIC_VECTOR (31 downto 0);
       ovf : out  STD_LOGIC;
		 zer : out  STD_LOGIC;
       cot : out  STD_LOGIC); 
end component;

begin

ADDER : ADD
        Port map(A=>A,
		           B=>B,
					  Ot=>op_add,
					  OVF=>add_ovf,
					  Z=>add_z,
					  COUT=>add_cout);
SUBER : SUB
        Port map(C=>A,
		           D=>B,
					  Output=>op_sub,
					  ovf=>sub_ovf,
					  zer=>sub_z,
					  cot=>sub_cout);

ALU_FSM : process(Op,add_ovf,add_z,add_cout,sub_ovf,sub_z,sub_cout,op_add,op_sub)
begin
case Op is

when "0000" =>  Outt<=op_add;   --ADD
                Zero<=add_z;
                Ovf<=add_ovf;
                Cout<=add_cout;
when "0001" =>  Outt<=op_sub;   --SUB
                Zero<=sub_z;
                Ovf<=sub_ovf;
                Cout<=sub_cout;
when "0010" => Outt<=A NAND B;  --NAND
               Zero<='0';
               Ovf<='0';
               Cout<='0';
when "0011" => Outt<=A OR B;   --OR
               Zero<='0';
               Ovf<='0';
               Cout<='0';
when "0100" => Outt<=NOT A;   --NOT A
               Zero<='0';
               Ovf<='0';
               Cout<='0';
when "1000" => Outt(31)<=A(31);   --SRA
               Outt(30 downto 1)<=A(31 downto 2);
					Outt(0)<=A(1);
					Zero<='0';
               Ovf<='0';
               Cout<='0';
when "1010" => Outt(31)<='0';    --SLR
               Outt(30 downto 1)<=A(31 downto 2);
					Outt(0)<=A(1);
					Zero<='0';
               Ovf<='0';
               Cout<='0';
when "1001" => Outt(31)<=A(30);   --SLL
               Outt(30 downto 1)<=A(29 downto 0);
					Outt(0)<='0';
					Zero<='0';
               Ovf<='0';
               Cout<='0';
when "1100" => Outt(31)<=A(30);   --ROTATE RIGHT
               Outt(30 downto 1)<=A(29 downto 0);
					Outt(0)<=A(31);
					Zero<='0';
               Ovf<='0';
               Cout<='0';
when "1101" => Outt(31)<=A(0);   --ROTATE LEFT
               Outt(30 downto 1)<=A(31 downto 2);
					Outt(0)<=A(1);
               Zero<='0';
               Ovf<='0';
               Cout<='0';
when "1111" => Outt(31 downto 24) <= A(31 downto 24) + B(7 downto 0); --MMX_ADDI
					Outt(23 downto 16) <= A(23 downto 16) + B(7 downto 0);
					Outt(15 downto 8)  <= A(15 downto 8)  + B(7 downto 0);
					Outt(7 downto 0)   <= A(7 downto 0)   + B(7 downto 0);
					Zero<='0';
               Ovf<='0';
               Cout<='0';
when "1110" => Outt<=A(15 downto 0)*B(15 downto 0); -- mul
               Zero<='0';
               Ovf<='0';
               Cout<='0';
when others => Outt<="00000000000000000000000000000000";
               Zero<='0';
               Ovf<='0';
               Cout<='0';
end case;
end process;

end Behavioral;

