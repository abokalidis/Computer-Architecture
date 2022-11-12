--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:31:43 05/06/2018
-- Design Name:   
-- Module Name:   /home/ibalampanis/Desktop/lab 5/test_DATAPATH.vhd
-- Project Name:  organwsh_5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY test_DATAPATH IS
END test_DATAPATH;
 
ARCHITECTURE behavior OF test_DATAPATH IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
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
   uut: DATAPATH PORT MAP (
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

      wait;
   end process;

END;
