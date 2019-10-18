LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bit_adder IS

PORT( add_sub : IN std_logic;
		data_A  : in std_logic_vector( 2 downto 0 );
		data_B  : in std_logic_vector( 2 downto 0 );
		sum     : out std_logic_vector( 2 downto 0 );
		carry_out	: out std_logic);
END bit_adder;

ARCHITECTURE implement OF "bit_adder" IS

     signal carry : STD_LOGIC_VECTOR(3 downto 0);
	  signal data_B2 : STD_LOGIC_VECTOR(3 downto 0);
BEGIN

PROCESS
BEGIN

   IF add_sub = '1' then
      data_B2 <= not data_B;
	ELSE 
	   data_B2 <= data_B;
   END IF;	
	

	carry(0) <= add_sub;


	for I in 0 to 2 loop
		sum(I) <= data_A(I) xor data_B2(I) xor carry(I);
		carry(I+1) <= (data_A(I) and data_B2(I)) or (data_A(I) and carry(I)) or (data_B2(I) and carry(I)) ;						 
	end loop;
	
	carry_out <= carry(3);
	
END PROCESS;

END implement;
