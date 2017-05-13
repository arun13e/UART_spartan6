

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity trans is
port(
data_s: in  std_logic_vector (1 to 8);
w_r   : in  std_logic; 
clk   : in  std_logic;
wr_ready : out std_logic;
data_o: out std_logic
                          );
end trans;



architecture trans_ar of trans is
begin

 process(clk,w_r) is
  variable I: integer range 0 to 9 :=0;
   begin
	if rising_edge(clk)  then
	
	if w_r = '0' then
	 
	 data_o<='1';
	 I:=0;
	 wr_ready <= '1';
	 end if;
	 
	if w_r = '1' then
   
	if I=0 then
	
	data_o <='0';   
	I:=1;
	
	else if I=9 then
	
	data_o<='1';
	
	else 
	
	data_o<=data_s(I);
	I:=I+1;
	
	end if;
	end if;
	end if;
	end if;
	end process;
end architecture trans_ar;