----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2018 09:20:09 AM
-- Design Name: 
-- Module Name: sc0712_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sc0712_1 is
    Port ( 
                       
             GPIO2_I     :   out std_logic_vector(31 downto 0);
             GPIO2_O     :   in std_logic_vector(31 downto 0);
             SCLK        :   out std_logic;
             SDO         :   out std_logic;
             SDI         :   in std_logic;
             CS          :   out std_logic
             );
end sc0712_1;

architecture Behavioral of sc0712_1 is

signal GPI: std_logic_vector(31 downto 0);
signal GPO: std_logic_vector(31 downto 0);

begin

GPO <= GPIO2_O;
GPIO2_I <= GPI;

SCLK <= GPO(0);
SDO <=  GPO(1);
CS <= GPO(2);
GPI(0) <= SDI;

--unused

GPI(31 downto 1) <= x"0000000"&"000";

end Behavioral;
