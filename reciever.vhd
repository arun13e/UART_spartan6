
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity clk_gen is

port (

signal reset_who1 :in std_logic;
signal ioclk  : in  std_logic ;
signal uartin1: in  std_logic ;
signal transc : out std_logic ;
signal readcom: out std_logic ;


signal receout: out std_logic_vector(0 to 7)
);
end clk_gen;

architecture Behavioral of clk_gen is
signal dcm_con : std_logic ;


begin

process (ioclk) is
variable counter : integer :=0;
begin
if rising_edge(ioclk) then
if counter = 0 then
dcm_con <='1';
else 
if counter = 63 then
dcm_con <='0';
end if;

end if;
counter :=counter +1;

if counter =125 then
counter :=0;
end if;


end if;
end process;
	
	process (dcm_con)                                                           -- counter
	variable counter1 :integer range 0 to 5:=0;
	begin
	if rising_edge(dcm_con) then
	if counter1 =0 then
	transc <='1';
	else 
	if counter1 =3 then
	transc <='0' ;
	end if;
	end if;
	counter1 :=counter1+1;
	if counter1 = 5 then
	counter1:=0;
	end if;
	end if;
	end process;
	
	process (dcm_con,reset_who1) is 
	variable final:integer range 0 to 60:=0;
	variable var  :std_logic_vector (0 to 7) :="00000000";
	begin
	
	if reset_who1 = '1' then                                                   --reset whole clkgen
	final :=0;
	end if;
	
	if rising_edge(dcm_con) then
	if uartin1<='0' and final<1 then
	final:=final+1;
	else if final > 0 then
	final:=final + 1;
	end if;
	end if;

	case final is
        when 7   => var(0) := uartin1;
        when 12  => var(1) := uartin1;
        when 17  => var(2) := uartin1;
        when 22  => var(3) := uartin1;
		  when 27  => var(4) := uartin1;
		  when 32  => var(5) := uartin1;
		  when 37  => var(6) := uartin1;
		  when 42  => var(7) := uartin1;
        when others => null ;
		 
    end case;
	 receout <= var;
	 if final > 47 then
	 readcom<='1';
	 final:=0;
	 else 
	 readcom<='0';
	 end if;
	 end if;
	 end process;
end Behavioral;

