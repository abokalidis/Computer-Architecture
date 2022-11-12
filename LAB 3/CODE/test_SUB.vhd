--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:04:08 03/03/2018
-- Design Name:   
-- Module Name:   C:/Users/Tasos/Dropbox/Organwsh Ypologistwn/ORGANWSH/ORGANWSH_1/test_SUB.vhd
-- Project Name:  ORGANWSH_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SUB
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
 
ENTITY test_SUB IS
END test_SUB;
 
ARCHITECTURE behavior OF test_SUB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SUB
    PORT(
         C : IN  std_logic_vector(31 downto 0);
         D : IN  std_logic_vector(31 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         ovf : OUT  std_logic;
         zer : OUT  std_logic;
         cot : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal C : std_logic_vector(31 downto 0) := (others => '0');
   signal D : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal ovf : std_logic;
   signal zer : std_logic;
   signal cot : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SUB PORT MAP (
          C => C,
          D => D,
          Output => Output,
          ovf => ovf,
          zer => zer,
          cot => cot
        );

   -- Clock process definitions
   --<clock>_process :process
   --begin
		--<clock> <= '0';
		--wait for <clock>_period/2;
		--<clock> <= '1';
		--wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		C  <= "00000000000000000000000000000011";
		D  <=	"00000000000000000000000000000001";
      wait for 50 ns;
		C  <= "00000000000000000000000000000001";
		D  <=	"00000000000000000000000000000011";
		
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
