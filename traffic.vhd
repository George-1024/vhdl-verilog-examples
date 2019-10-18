LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY traffic IS
	PORT(
		CLOCK_50, KEY0					 : IN  STD_LOGIC;
		LEDR17,nsr, nsy, nsg, ewr, ewy, ewg : OUT STD_LOGIC);

END traffic;

ARCHITECTURE a OF traffic IS

	TYPE STATES IS (s0, s1, s2, s3);
	SIGNAL sequence : STATES;
	SIGNAL lights : STD_LOGIC_VECTOR (5 downto 0);
	SIGNAL timer : INTEGER RANGE 0 to 5;
	SIGNAL counter : INTEGER RANGE 0 to 100;
    signal led: std_logic;
    signal clk: std_logic;
    signal reset: std_logic;
BEGIN

    clk <= CLOCK_50;
    reset <= KEY0;
	PROCESS (clk, reset)
	BEGIN
		IF (reset = '0') THEN
			sequence <= s0;
			lights <= "011110";
		ELSIF (clk'EVENT and clk = '1') THEN
			CASE sequence IS
				WHEN s0	=>	IF timer < 4 THEN
								sequence <= s0;
								lights <= "011110";
							ELSE
								sequence <= s1;
								lights <= "011101";
							END IF;
				WHEN s1	=>	sequence <= s2;
							lights <= "110011";
				WHEN s2	=>	IF timer < 4 THEN
								sequence <= s2;
								lights <= "110011";
							ELSE
								sequence <= s3;
								lights <= "101011";
							END IF;
				WHEN s3	=>	sequence <= s0;
							lights <= "100001";
				WHEN others =>	sequence <= s0;
								lights <= "011110";
			END CASE;
		END IF;
	END PROCESS;
    
	PROCESS (clk,reset)
	BEGIN
		IF (reset = '0') THEN
			timer <=0;
		ELSIF (clk'EVENT and clk = '1') THEN
			IF counter = 100000000 THEN
                led <= '1';
				counter <= 0;
				timer <= timer + 1;
				if timer = 5 then
					timer <= 0;
			    else
				counter <= counter +1;
                end if;
			end if;
		end if;
	END PROCESS;
    LEDR17 <= led;
    
	nsr	<=	lights(5);
	nsy	<=	lights(4);
	nsg	<=	lights(3);
	ewr	<=	lights(2);
	ewy	<=	lights(1);
	ewg	<=	lights(0);
END a;

