--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:57:00 04/24/2018
-- Design Name:   
-- Module Name:   /home/ibalampanis/Desktop/lab_organwsh_2018/lab 4/test_counter.vhd
-- Project Name:  organwsh_4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Counter
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
 
ENTITY test_counter IS
END test_counter;
 
ARCHITECTURE behavior OF test_counter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Counter
    PORT(
         CLK : IN  std_logic;
         EN : IN  std_logic;
         RC : OUT  std_logic;
         Output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal EN : std_logic := '0';

 	--Outputs
   signal RC : std_logic;
   signal Output : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Counter PORT MAP (
          CLK => CLK,
          EN => EN,
          RC => RC,
          Output => Output
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '1';
		wait for CLK_period/2;
		CLK <= '0';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		
		EN<='0';
		wait for 50 ns;
		EN<='1';

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
