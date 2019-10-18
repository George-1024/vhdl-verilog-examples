LIBRARY ieee;

USE ieee.std_logic_1164.ALL;



ENTITY segdisp IS
PORT (
	SW : IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
	HEX0 : out	STD_LOGIC_VECTOR(6 DOWNTO 0));
END segdisp;

ARCHITECTURE implement OF segdisp IS
	signal D3,D2,D1,D0 : std_logic;
	signal A,B,C,D,E,F,G : std_logic;
BEGIN
	D3 <= SW(3);
	D2 <= SW(2);
	D1 <= SW(1);
	D0 <= SW(0);

	A <= (D2 and not D1 and not D0) or (not D3 and not D2 and not D1 and D0);
	B <= (D2 and not D1 and D0) or (D2 and D1 and not D0);
	C <= not D3 and not D2 and D1 and not D0;
	D <= (D2 and not D1 and not D0) or (not D3 and not D2 and not D1 and D0) or (D2 and D1 and D0);
	E <= D0 or (D2 and not D1);
	F <= (not D3 and not D2 and D1) or (not D3 and not D2 and D0) or (D1 and D0);
	G <= (not D3 and not D2 and not D1) or (D2 and D1 and D0);
	
	HEX0(0) <= A;
	HEX0(1) <= B;
	HEX0(2) <= C;
	HEX0(3) <= D;
	HEX0(4) <= E;
	HEX0(5) <= F;
	HEX0(6) <= G;
	 
END implement;