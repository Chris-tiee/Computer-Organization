-- Code your design here

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regfile is
    port (
        clk : in std_logic ;
        rst_n : in std_logic ;
        RegWrite : in std_logic ;
        rs1 : in std_logic_vector (4 downto 0);
        rs2 : in std_logic_vector (4 downto 0);
        rd : in std_logic_vector (4 downto 0);
        datain : in std_logic_vector (31 downto 0);
        regA : out std_logic_vector (31 downto 0):= (others=>'0');
        regB : out std_logic_vector (31 downto 0):= (others=>'0')
    );
end regfile ;

architecture behavioral of regfile is 
	type register_file is array (0 to 31) of std_logic_vector (31 downto 0);
    begin
    process(clk, rst_n, datain, RegWrite) is
    	variable RegiFile : register_file:= (others => (others => '0'));
    	begin
    	if (rst_n = '0' ) then 
     		RegiFile := (others => (others => '0')); 
            regA <= (others =>'0');
            regB <= (others =>'0');
        elsif rising_edge(clk) and RegWrite='1' and rd /= "00000" then
          	RegiFile (to_integer(unsigned(rd))) := datain;
        elsif falling_edge(clk) then
        	regA <= RegiFile(to_integer(unsigned(rs1)));
            regB <= RegiFile(to_integer(unsigned(rs2)));
    	end if;
    end process;
    
end behavioral;
