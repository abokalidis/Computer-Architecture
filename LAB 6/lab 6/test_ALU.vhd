--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:08:43 03/03/2018
-- Design Name:   
-- Module Name:   C:/Users/Tasos/Dropbox/Organwsh Ypologistwn/ORGANWSH/ORGANWSH_1/test_ALU.vhd
-- Project Name:  ORGANWSH_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_ALU IS
END test_ALU;
 
ARCHITECTURE behavior OF test_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Outt : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Outt : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Outt => Outt,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Clock process definitions
   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      A  <= "11111111111111111111111111111111";
		B  <=	"11111111111111111111111111111111";
		Op <= "0000";
      wait for 50 ns;
--		A  <= "11111111111111111111111111111110";
--		B  <=	"10000000000000000000000000000001";
--		Op <= "0000";
--		wait for 50 ns;
--		A  <= "00000000000000000000000000000001";
--		B  <=	"00000000000000000000000000000010";
--		Op <= "0000";
--      wait for 50 ns;
--		A  <= "11111111111111111111111111111111";
--		B  <=	"11111111111111111111111111111111";
--      Op <= "0000";
--		wait for 50 ns;--ADD
--		
--		A  <= "00000000000000000000000000000011";
--		B  <=	"00000000000000000000000000000001";
--		Op <= "0001";
--      wait for 50 ns;
--		A  <= "00000000000000000000000000000001";
--		B  <=	"00000000000000000000000000000011";
--		Op <= "0001";
--		wait for 50 ns;--SUB  
--		
--		A  <= "11000000000000010000000000000000";
--		B  <=	"01000000000000010000000000000000";
--		Op <= "0010";
--		wait for 50 ns;
--		A  <= "11000000000000010000000000000000";
--		B  <=	"01000000000000010000000000000000";
--		Op <= "0011";
--		wait for 50 ns;
--		A  <= "11000000000000010000000000000000";
--		B  <=	"01000000000000010000000000000000";
--		Op <= "0100";
--		wait for 50 ns;--LOGIC
--		
--		A  <= "11000000000000010000001111100000";
--		B  <=	"00000000000000000000000000000000";
--		Op <= "1000";
--		wait for 50 ns;
--		A  <= "11000000000000010000000001000001";
--		B  <=	"00000000000000000000000000000000";
--      Op <= "1001";
--		wait for 50 ns;
--		A  <= "11000000000000010000000000100000";
--		B  <=	"00000000000000000000000000000000";
--		Op <= "1010";
--		wait for 50 ns;
--		A  <= "11000011000000010000000000000001";
--		B  <=	"00000000000000000000000000000000";
--		Op <= "1100";
--		wait for 50 ns;
--		A  <= "11000000000000010011000000000000";
--		B  <=	"00000000000000000000000000000000";
--		Op <= "1101";
--		wait for 50 ns;--SHIFTS
		
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
