--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:20:59 03/23/2018
-- Design Name:   
-- Module Name:   /home/ibalampanis/Desktop/lab_organwsh_2018/lab 3/test_PROCESSOR.vhd
-- Project Name:  organwsh_3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PROCESSOR
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
 
ENTITY test_PROCESSOR IS
END test_PROCESSOR;
 
ARCHITECTURE behavior OF test_PROCESSOR IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROCESSOR
    PORT(
         RESET : IN  std_logic;
         CLOCK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RESET : std_logic := '0';
   signal CLOCK : std_logic := '0';

   -- Clock period definitions
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROCESSOR PORT MAP (
          RESET => RESET,
          CLOCK => CLOCK
        );

   -- Clock process definitions
   CLOCK_process :process
   begin
		CLOCK <= '1';
		wait for CLOCK_period/2;
		CLOCK <= '0';
		wait for CLOCK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RESET<='1';
      wait for 100 ns;
      RESET<='0';		

      wait for CLOCK_period*100;

      -- insert stimulus here

			-- run for time specific 1.14 us

      wait;
   end process;

END;
