library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity uart is 

port (
signal tx_uart       :in  std_logic ;
signal w_uart        :in  std_logic ;
signal reset_uart    :in  std_logic ;
signal clock_uart    :in  std_logic ;
signal dataw_uart    :in  std_logic_vector(1 to 8);
signal rx_uart       :out std_logic ;
signal wr_ready_uart :out std_logic ;
signal read_com_uart :out std_logic ;
signal datar_uart    :out std_logic_vector(0 to 7) 
);

end uart;

architecture uart_arch of uart is

component trans
port(
data_s   : in  std_logic_vector (1 to 8);
w_r      : in  std_logic; 
clk      : in  std_logic;
wr_ready : out std_logic;
data_o   : out std_logic
                          );
end component ;							  


component clk_gen 
port (

signal reset_who1 : in std_logic   ;
signal ioclk      : in  std_logic ;
signal uartin1    : in  std_logic ;
signal transc     : out std_logic ;
signal readcom    : out std_logic ;

signal receout    : out std_logic_vector(0 to 7)
);
end component ;

signal clk_wire       : std_logic;
begin

transmitter : trans port map (
        data_s   => dataw_uart ,
        w_r      => w_uart ,
        wr_ready => wr_ready_uart ,
        data_o   => rx_uart ,
        clk      => clk_wire
);



reciever   : clk_gen port map (
        ioclk      => clock_uart , 
        uartin1    => tx_uart   ,
        transc     => clk_wire ,
        readcom    => read_com_uart ,
        receout    => datar_uart  ,
		  reset_who1 => reset_uart
);


end uart_arch;