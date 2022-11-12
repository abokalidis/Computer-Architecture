----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:00:30 03/12/2018 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_Wr_En : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_Wr_Data_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  M_EN : in STD_LOGIC;
			  C_EN : in STD_LOGIC;
			  C_RC : out STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component REGISTER_FILE is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);			  
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end component;

component mux_instr is
    Port ( X : in  STD_LOGIC_VECTOR (4 downto 0);
           Y : in  STD_LOGIC_VECTOR (4 downto 0);
           C : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

component MUX_S_L is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Immed_calculator is
    Port ( Immed_in : in  STD_LOGIC_VECTOR (15 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Immed_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component Counter is
    Port ( CLK : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           RC : out  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (4 downto 0));
end Component;

component MUX_RFST is
    Port ( A : in  STD_LOGIC_VECTOR (4 downto 0);
           B : in  STD_LOGIC_VECTOR (4 downto 0);
           C : in  STD_LOGIC_VECTOR (4 downto 0);
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           O : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

signal mux_out,mout,cout : STD_LOGIC_VECTOR (4 downto 0);
signal mux_out2 : STD_LOGIC_VECTOR (31 downto 0);
signal op : STD_LOGIC_VECTOR (5 downto 0);

begin

RF_DEC : REGISTER_FILE
		Port map( Ard1 => Instr(25 downto 21) ,
                Ard2 => mux_out,
                Awr => mout,
                Dout1 => RF_A ,
                Dout2 => RF_B,
                Din => mux_out2,
                WrEn => RF_Wr_En,
                Clk => Clk);

MUX1 : MUX_RFST
      Port map(A=>Instr(15 downto 11),
               B=>Instr(20 downto 16),
					C=>cout,
               S=>RF_B_sel,
               O=>mux_out);

MUX2 : MUX_S_L
      Port map(A=>ALU_out,
               B=>MEM_out,
               C=>RF_Wr_Data_sel,
               Z=>mux_out2);

Immed_mod : Immed_calculator
        	Port map(Immed_in=>Instr(15 downto 0),
                  Opcode=>Instr(31 downto 26),
                  Immed_out=>Immed);

RFLD_mux : 	mux_instr
         Port map(X=>Instr(20 downto 16),
                  Y=>cout,
                  C=>M_EN,
                  Z=>mout);
Count : Counter
        Port map(CLK=>Clk,
                 EN=>C_EN,
                 RC=>C_RC,
                 Output=>cout);					  
end Behavioral;

