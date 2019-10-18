LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bits_add_sub IS

generic (    
  bus_width       : integer := 3    --set default bus width to three
);

PORT( sw10 : IN std_logic;   --add/sub switch
		SW : std_logic_vector( bus_width*2-1 downto 0 ); -- data_input ( data_B and data_A )
		LEDR	: out std_logic_vector( bus_width downto 0 ); -- sum
		LEDR10 : out std_logic);  --carry_out
END bits_add_sub;

ARCHITECTURE implement OF bits_add_sub IS

-- these signals connect the port
		signal add_sub : std_logic;
		signal data_A  : std_logic_vector( bus_width-1 downto 0 );
		signal data_B  : std_logic_vector( bus_width-1 downto 0 );
		signal sum     : std_logic_vector( bus_width-1 downto 0 );
		signal carry_out	: std_logic;
		
-- these signals build connections internally
      signal carry : std_logic_vector( bus_width downto 0);
	   signal data_B2 : std_logic_vector( bus_width-1 downto 0);
BEGIN

PROCESS(sw,sw10)
BEGIN

   add_sub <= sw10;
	data_A <= sw( bus_width-1 downto 0);
	data_B <= sw( bus_width*2-1 downto bus_width);

   IF (add_sub = '1') then
     data_B2 <= not data_B;
	ELSE                         -- !!! for combination logic , data_B2 should be given a value at each condition, 	
	  data_B2 <=  data_B;        --     otherwith it will be a register.
   END IF;
	

	carry(0) <= add_sub;

	for I in 0 to 2 loop       
		sum(I) <= data_A(I) xor data_B2(I) xor carry(I);
		carry(I+1) <= (data_A(I) and data_B2(I)) or (data_A(I) and carry(I)) or (data_B2(I) and carry(I)) ;						 
	end loop;

	carry_out <= carry(bus_width);
	
	LEDR10 <= carry_out;
	LEDR( bus_width-1 downto 0) <= sum;
END PROCESS;	

END implement;
