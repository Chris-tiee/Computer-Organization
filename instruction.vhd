-- Code your design here

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instr_decoder is
    port (
      instruction : in std_logic_vector (31 downto 0);
      BranchCond : in std_logic ; 
      Jump : out std_logic:='0' ;
      Lui : out std_logic:='0' ;
      PCSrc : out std_logic:='0' ;
      RegWrite : out std_logic:='0' ;
      ALUSrc1 : out std_logic:='0' ;
      ALUSrc2 : out std_logic:='0' ;
      ALUOp : out std_logic_vector (3 downto 0):="0000";
      MemWrite : out std_logic:='0' ;
      MemRead : out std_logic:='0' ;
      MemToReg : out std_logic:='0'
    ) ;
end instr_decoder ;

architecture behavioral of instr_decoder is 
	begin
    process(instruction,BranchCond)
    begin
    	Jump<='0';
        Lui<='0';
        PCSrc<='0';
        RegWrite<='0';
        ALUSrc1<='0';
        ALUSrc2<='1';
        ALUOp<="0000";
        MemWrite<='0';
        MemRead<='0';
        MemToReg<='0';
    	case instruction(6 downto 0) is 
        	when "0110111" =>
            	Lui<='1';
                RegWrite<='1';
                ALUSrc1<='1';
                ALUSrc2<='1';
                ALUOp<="0001";
                
         	when "0010111" =>
            	RegWrite<='1';
                ALUSrc1<='1';
                ALUSrc2<='1';
           	when "1101111" =>
            	Jump<='1';
                PCSrc<='1';
                RegWrite<='1';
                ALUSrc1<='1';
                ALUSrc2<='1';
           	when "1100111" =>
            	Jump <='1';
                PCSrc<='1';
                RegWrite<='1';
                ALUSrc1<='1';
                ALUSrc2<='1';
           	when "1100011" =>
            	if BranchCond='1' then
                	PCSrc<='1';
                    ALUSrc1<='1';
                    ALUSrc2 <='1';
                    ALUOp <="1000";
               	end if;
            when "0000011" =>
            	RegWrite <='1';
                ALUSrc2<='1';
            	MemRead <='1';
                MemToReg<='1';
          	when "0100011" =>
            	ALUSrc2<='1';
                MemWrite<='1';
            when "0010011" =>
            	RegWrite <='1';
                ALUSrc2 <='1';
            	if instruction (14 downto 12)="010" or instruction (13 downto 11)="011" then
                	ALUOp <="0010";
                elsif instruction (14 downto 12)="100" then
                	ALUOp <="0100";
                 elsif instruction (14 downto 12)="110" then
                	ALUOp <="0110";
                 elsif instruction (14 downto 12)="111" then
                	ALUOp <="0111";
                 elsif instruction (14 downto 12)="001" then
                	ALUOp <="0001";
                 elsif instruction (14 downto 12)="101" and instruction (31 downto 25)="0000000" then
                	ALUOp <="0101";
                 elsif instruction (14 downto 12)="101" and instruction (31 downto 25)="0100000" then
                	ALUOp <="1101";
                 end if;
           	when "0110011" =>
            	RegWrite <='1';
                ALUSrc2 <='0';
                if instruction (14 downto 12)="000" and instruction (31 downto 25)="0100000" then
                	ALUOp <="1000";
                elsif instruction (14 downto 12)="001" then
                	ALUOp <="0001";
                elsif instruction (14 downto 12)="010" or instruction(13 downto 11)="011" then
                	ALUOp <="0010";
                elsif instruction (14 downto 12)="100" then
                	ALUOp <="0100";
                elsif instruction (14 downto 12)="101" and instruction (31 downto 25)="0000000"  then
                	ALUOp <="0101";
                elsif instruction (14 downto 12)="101" and instruction (31 downto 25)="0100000"  then
                	ALUOp <="1101";  
                elsif instruction (14 downto 12)="110" then
					ALUOp <="0110";
               	elsif instruction (14 downto 12)="111" then
					ALUOp <="0111";
                end if;
                when others =>
                	Jump<='0';
               
      	end case;
   	end process;

end behavioral;
                
               
                
            	
                
                
              
                
               	
            	