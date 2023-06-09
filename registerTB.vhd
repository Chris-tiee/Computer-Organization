-- Code your testbench here

library IEEE;
use IEEE.std_logic_1164.all;

entity regFileTB is
end regFileTB;

architecture testbench of regFileTB is
component regfile
 	port (
        clk : in std_logic ;
        rst_n : in std_logic ;
        RegWrite : in std_logic ;
        rs1 : in std_logic_vector (4 downto 0);
        rs2 : in std_logic_vector (4 downto 0);
        rd : in std_logic_vector (4 downto 0);
        datain : in std_logic_vector (31 downto 0);
        regA : out std_logic_vector (31 downto 0);
        regB : out std_logic_vector (31 downto 0)
    );
end component;

	signal tb_clk: std_logic:='0';
    signal tb_rst: std_logic:='0';
    signal tb_RegWrite: std_logic:= '0';
    signal tb_rs1: std_logic_vector(4 downto 0):="00000";
    signal tb_rs2: std_logic_vector (4 downto 0):="00000";
    signal tb_rd: std_logic_vector (4 downto 0):="00000";
    signal tb_datain: std_logic_vector (31 downto 0):= X"00000000";
    signal tb_regA: std_logic_vector (31 downto 0):= X"00000000";
    signal tb_regB: std_logic_vector (31 downto 0):= X"00000000";

begin
	UUT: regfile port map (tb_clk,tb_rst,tb_RegWrite,tb_rs1, tb_rs2, tb_rd, tb_datain,tb_regA,tb_regB);
    
    clock: process
    begin
    	for i in 1 to 30 loop
          tb_clk <= '0';
          wait for 5 ns ;
          tb_clk <='1';
          wait for 5 ns ;
        end loop ;
	  wait ;
    end process ;
    
    read: process
    begin
        tb_regWrite<='1';
        tb_rd<="00101";
        tb_datain<= X"12345678";
       	wait for 50 ns;
        tb_rs1<="00101";
        tb_rs2<="00111";
        tb_rd<="00111";
        tb_datain<= X"14345878";
        wait for 20 ns;
        tb_rs1<="01000";
        tb_rs2<="00111";
        tb_rd<="01000";
        tb_datain<= X"14346878";
        wait for 50 ns;
        tb_rd<="00000";
        tb_rs2<="00000";
        
        wait;
   	end process;
    
tb_rst<='1' after 1 ns, '0' after 15 ns, '1' after 16 ns;
    
end testbench;

        
        