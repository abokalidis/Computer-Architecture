----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:39:33 03/03/2018 
-- Design Name: 
-- Module Name:    REGISTER_FILE - Behavioral 
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
library work;
use work.register_array_type.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REGISTER_FILE is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end REGISTER_FILE;

architecture Structural of REGISTER_FILE is

Component DECODER_5to32 is
    Port ( Input : in  STD_LOGIC_VECTOR (4 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component COMPARE_MODULE is
    Port ( ADR : in  STD_LOGIC_VECTOR (4 downto 0);
           AWR : in  STD_LOGIC_VECTOR (4 downto 0);
			  WE : in STD_LOGIC;
           RES : out  STD_LOGIC);
end Component;

Component REGISTERS is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component MUX32 is
    Port ( X : in register_array;
           Y : out  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC_VECTOR (4 downto 0));
end component;

Component MUX2 is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
           Y : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal out_dec : std_logic_vector (31 downto 0);
signal out_CM1,out_CM2 : std_logic;
signal sig_we,reg_out : std_logic_vector (31 downto 0);
signal we : std_logic_vector (31 downto 0);
signal mux_out,mux_out2 : std_logic_vector (31 downto 0);
signal sig_in_mux32 : register_array;
signal zeros : std_logic_vector (31 downto 0);

begin

DEC:  DECODER_5to32
       Port map( Input=>Awr, 
                 Output=>out_dec);
CM1: 	COMPARE_MODULE	
       Port map( ADR=>Ard1,
                 AWR=>Awr,
					  WE=>WrEn,
                 RES=>out_CM1);	
CM2: 	COMPARE_MODULE	
       Port map( ADR=>Ard2,
                 AWR=>Awr,
					  WE=>WrEn,
                 RES=>out_CM2);					  
REG0: REGISTERS
        Port map(Din=>zeros, 
                 WE=>'1', 
                 CLOCK=>Clk, 
					  Dout=>sig_in_mux32(0));
GEN_REGS :
        for i in 1 to 31 generate
		  we(i) <= WrEn AND out_dec(i);
		  Regs : REGISTERS 
		          Port Map (CLOCK=>Clk,
								  Din=>Din,
								  WE=>we(i),
								  Dout=>sig_in_mux32(i));
	    end generate;
		 
MUX32_1 : MUX32
           Port map(X=>sig_in_mux32,
                    Y=>mux_out, 
                    C=>Ard1); 
MUX32_2 : MUX32
           Port map(X=>sig_in_mux32,
                    Y=>mux_out2, 
                    C=>Ard2); 	
MUX2_1 : MUX2
			  Port map(X=>mux_out,
			           Y=>Din,
						  C=>out_CM1,
						  O=>Dout1);
MUX2_2 : MUX2
			  Port map(X=>mux_out2,
			           Y=>Din,
						  C=>out_CM2,
						  O=>Dout2);
						  
zeros<="00000000000000000000000000000000";				  

end Structural;

