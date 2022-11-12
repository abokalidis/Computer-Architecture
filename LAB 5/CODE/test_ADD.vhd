--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:58:28 03/03/2018
-- Design Name:   
-- Module Name:   C:/Users/Tasos/Dropbox/Organwsh Ypologistwn/ORGANWSH/ORGANWSH_1/test_ADD.vhd
-- Project Name:  ORGANWSH_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ADD
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
 
ENTITY test_ADD IS
END test_ADD;
 
ARCHITECTURE behavior OF test_ADD IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ADD
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Ot : OUT  std_logic_vector(31 downto 0);
         OVF : OUT  std_logic;
         Z : OUT  std_logic;
         COUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Ot : std_logic_vector(31 downto 0);
   signal OVF : std_logic;
   signal Z : std_logic;
   signal COUT : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ADD PORT MAP (
          A => A,
          B => B,
          Ot => Ot,
          OVF => OVF,
          Z => Z,
          COUT => COUT
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
		A  <= "11111111111111111111111111111111";
		B  <=	"00000000000000000000000000000001";
      wait for 50 ns;
		A  <= "11111111111111111111111111111110";
		B  <=	"10000000000000000000000000000001";
		wait for 50 ns;
		A  <= "00000000000000000000000000000001";
		B  <=	"00000000000000000000000000000010";
      wait for 50 ns;
		A  <= "11111111111111111111111111111111";
		B  <=	"11111111111111111111111111111111";

      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
