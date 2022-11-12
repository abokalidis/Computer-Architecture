----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:43:29 05/17/2018 
-- Design Name: 
-- Module Name:    TOP_CACHE - Behavioral 
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

entity TOP_CACHE is
    Port ( Data_addr : in  STD_LOGIC_VECTOR (10 downto 0);
	        Cache_Reg_En : out  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Cache_data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end TOP_CACHE;

architecture Behavioral of TOP_CACHE is

component CACHE_MEM is
	port ( clk : in std_logic;
			 addr : in std_logic_vector(4 downto 0);
			 dout : out std_logic_vector(131 downto 0));
end component;

component INSTR_FETCH is
    Port ( Instr : in  STD_LOGIC_VECTOR (10 downto 0);
           Set_index : out  STD_LOGIC_VECTOR (4 downto 0);
           Word_offset : out  STD_LOGIC_VECTOR (1 downto 0);
           Tag : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component TAG_COMPARE is
    Port ( cache_tag : in  STD_LOGIC_VECTOR (2 downto 0);
           instr_tag : in  STD_LOGIC_VECTOR (2 downto 0);
           comp_out : out  STD_LOGIC);
end component;

component VALID_CHECK_UNIT is
    Port ( valid_bit : in  STD_LOGIC;
           comp_out : in  STD_LOGIC;
           valid_check_out : out  STD_LOGIC);
end component;

component OUTPUT_MUX is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC_VECTOR (31 downto 0);
           D : in  STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in  STD_LOGIC_VECTOR (1 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal set_indx_sig :STD_LOGIC_VECTOR (4 downto 0);
signal word_offset_sig : STD_LOGIC_VECTOR (1 downto 0);
signal tag_sig : STD_LOGIC_VECTOR (2 downto 0);
signal data_out_sig : STD_LOGIC_VECTOR (131 downto 0);
signal comp_out_sig, valid_check_out_sig : STD_LOGIC;
signal mux_out_sig : STD_LOGIC_VECTOR(31 downto 0);

begin

fetch : INSTR_FETCH
			Port map( 
				Instr => Data_addr,
				Set_index => set_indx_sig,
				Word_offset => word_offset_sig, 
				Tag => tag_sig
				);

cache : CACHE_MEM 
			port map (
				clk => CLK,
				addr => set_indx_sig,
				dout => data_out_sig
				);

compare_tag : TAG_COMPARE 
      Port map ( 
        cache_tag => data_out_sig(130 downto 128),
        instr_tag => tag_sig,
        comp_out =>  comp_out_sig
        );	

valid_check : VALID_CHECK_UNIT 
      Port map ( 
        valid_bit => data_out_sig(131),
        comp_out => comp_out_sig,
        valid_check_out => Cache_Reg_En
        );	

mux_output : OUTPUT_MUX 
      Port map ( 
        A => data_out_sig(31 downto 0),
        B => data_out_sig(63 downto 32),
        C => data_out_sig(95 downto 64),
        D => data_out_sig(127 downto 96),
        mux_sel => word_offset_sig,
        mux_out => mux_out_sig
        );

Cache_data_out <= mux_out_sig;


end Behavioral;

