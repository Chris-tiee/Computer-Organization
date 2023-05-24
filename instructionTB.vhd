-- Code your testbench here

library IEEE;
use IEEE.std_logic_1164.all;

entity instr_tb is 
end instr_tb;

architecture testbench of instr_tb is
component instr_decoder
 	port (
      instruction : in std_logic_vector (31 downto 0);
      BranchCond : in std_logic; 
      Jump : out std_logic;
      Lui : out std_logic;
      PCSrc : out std_logic;
      RegWrite : out std_logic;
      ALUSrc1 : out std_logic;
      ALUSrc2 : out std_logic;
      ALUOp : out std_logic_vector (3 downto 0);
      MemWrite : out std_logic ;
      MemRead : out std_logic ;
      MemToReg : out std_logic
    );
end component;

	signal instructionTB : std_logic_vector (31 downto 0):= (others=>'0');
    signal BranchCondTB : std_logic:='0' ; 
    signal JumpTB : std_logic:='0' ;
    signal LuiTB : std_logic:='0' ;
   	signal PCSrcTB : std_logic:='0' ;
    signal RegWriteTB : std_logic:='0' ;
    signal ALUSrc1TB : std_logic:='0' ;
    signal ALUSrc2TB : std_logic:='0' ;
    signal ALUOpTB : std_logic_vector (3 downto 0):="0000";
    signal MemWriteTB : std_logic:='0' ;
    signal MemReadTB : std_logic:='0' ;
    signal MemToRegTB : std_logic:='0';
    
begin
UUT: instr_decoder port map (instructionTB,BranchCondTB,JumpTB,LuiTB,PCSrcTB,RegWriteTB,ALUSrc1TB,ALUSrc2TB,ALUOpTB);

inst: process
	begin
    --LUI
    BranchCondTB<='0';
    instructionTB<="00000000000000000000000000110111";
    wait for 10 ns;
    --AUIPC
    BranchCondTB<='0';
    instructionTB<="00000000000000000000000000010111";
    wait for 10 ns;
    --JALR
    BranchCondTB<='0';
    instructionTB<="00101001100000010000000001100111";
    wait for 10 ns;
    --a taken branch
    BranchCondTB<='1';
    instructionTB<="01100011001011000000000001100011";
    wait for 10 ns;
    -- a non-taken branch
    BranchCondTB<='0';
    instructionTB<="00000000000000000001000001100011";
    wait for 10 ns;
    -- a load
    BranchCondTB<='0';
    instructionTB<="10110011101110010000000000000011";
    wait for 10 ns;
    -- a store
    BranchCondTB<='0';
    instructionTB<="10110011101110010000000000100011";
    wait for 10 ns;
    --an immediate instruction
    BranchCondTB<='0';
    instructionTB<="10110011101110010010000000010011";
    wait for 10 ns;
    --an R-Type instruction
    BranchCondTB<='0';
    instructionTB<="10110011101110010000000000110011";
    wait for 10 ns;
    wait;
end process;
end testbench;