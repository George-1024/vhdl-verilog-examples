LIBRARY ieee;

USE ieee.std_logic_1164.ALL;



ENTITY display IS
PORT (
		SW : IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
		HEX0 : out	STD_LOGIC_VECTOR(6 DOWNTO 0));
END display;

ARCHITECTURE implement OF display IS

BEGIN
	PROCESS (SW)
		BEGIN
			CASE SW IS				
				WHEN "0000"=> HEX0 <= "1000000"; -- 0
				WHEN "0001"=> HEX0 <= "1111001"; -- 1
				WHEN "0010"=> HEX0 <= "0100100"; -- 2
				WHEN "0011"=> HEX0 <= "0110000"; -- 3
				WHEN "0100"=> HEX0 <= "0011001"; -- 4
				WHEN "0101"=> HEX0 <= "0010010"; -- 5
				WHEN "0110"=> HEX0 <= "0000010"; -- 6
				WHEN "0111"=> HEX0 <= "1111000"; -- 7
				WHEN "1000"=> HEX0 <= "0000000"; -- 8
				WHEN "1001"=> HEX0 <= "0010000"; -- 9
				WHEN "1010"=> HEX0 <= "0001000"; -- A
				WHEN others => HEX0 <= "1111111"; 
		END CASE;
	END PROCESS;
END implement;