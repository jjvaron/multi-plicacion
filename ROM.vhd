-- ***********************************************
-- **  PROYECTO PDUA                            **
-- **  Modulo: 	ROM                           **
-- **  Creacion:	Julio 07								**
-- **  Revisiï¿½:	Marzo 08								**
-- **  Por:		   MGH-CMUA-UNIANDES 				**
-- ***********************************************
-- Descripcion:
-- ROM (Solo lectura)
--                      cs  
--                  _____|_
--           rd -->|       |
--          dir -->|       |--> data
--                 |_______|   
--        
-- ***********************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM is
    Port ( cs,rd	: in std_logic;
           dir 	: in std_logic_vector(7 downto 0);
           data 	: out std_logic_vector(7 downto 0));
end ROM;

architecture Behavioral of ROM is
                            
begin
process(cs,rd,dir)
begin
if cs = '1' and rd = '0' then
       case dir is
	    when "00000000" => data <= "01010000";  -- 0 JMP MAIN
	    when "00000001" => data <= "00000011";  -- 1 MAIN 
	    when "00000010" => data <= "00001000";  -- 2 RAI Vector de Interrupcion /////check 
		 
	    when "00000011" => data <= "00011000";  -- 3 MOV ACC,CTE  
		 when "00000100" => data <= "00001000";  -- 4 CTE (0x08)
	    when "00000101" => data <= "10010000";  -- 5 MOV T,ACC
		 
	    when "00000110" => data <= "10101000";  -- 6 MOV DPTR, CTE --POSICIÓN DE PRODUCTO
	    when "00000111" => data <= "10000010";  -- 28 CTE (0x82) --130
		 when "00001000" => data <= "00011000";  -- 8 MOV ACC,CTE
		 when "00001001" => data <= "00000000";  -- CTE (0x00) --Inicializacion PRODUCTO
		 when "00001010" => data <= "00110000";  -- 10 MOV [DPTR],ACC
		 
		 when "00001011" => data <= "10101000";  -- 6 MOV DPTR, CTE --POSICIÓN DE M.ando
		 when "00001100" => data <= "10000011";  -- 7 CTE (0x83)--131
		 when "00001101" => data <= "00011000";  -- 8 MOV ACC,CTE
		 when "00001110" => data <= "00000101";  -- 9 CTE (0x05) -- M.ando
		 when "00001111" => data <= "00110000";  -- 10 MOV [DPTR],ACC
		 
	    when "00010000" => data <= "10101000";  -- 11 MOV DPTR, CTE --POSICIÓN DE M.dor		 
		 when "00010001" => data <= "10000001";  -- 12 CTE (0x81) --129
	    when "00010010" => data <= "00011000";  -- 13 MOV ACC,CTE
		 when "00010011" => data <= "00001001";  -- 14 CTE (0x09) --M.dor		 
		 when "00010100" => data <= "00110000";  -- 15 MOV [DPTR],ACC  --ACC= M.dor
		 --LOOP
	    when "00010101" => data <= "00010000";  -- 16 MOV A, ACC A=M.dor --A = M.dor ////--LOOP--////
		 --COMPARADOR
		 when "00010110" => data <= "00011000";  -- 17 MOV ACC,CTE		 
		 when "00010111" => data <= "00000001";  -- 18 CTE (0x01)
		 when "00011000" => data <= "01000000";  -- 19 AND ACC,A /////////////////////7---REVISAR EL RESULTADO DE LA AND
		 
		 when "00011001" => data <= "01011010";  -- 20 JZ ACC
		 when "00011010" => data <= "00100100";  -- 21 DESPLAZAMIETO (35) JMP 00100100
		 
		 when "00011011" => data <= "10101000";  -- 23 MOV DPTR, CTE --POSICIÓN DE M.ando
		 when "00011100" => data <= "10000011";  -- 7 CTE (0x83)--131
		 when "00011101" => data <= "00100000";  -- 25 MOV ACC,[DPTR] --ACC = M.ando
	    when "00011110" => data <= "00010000";  -- 26 MOV A, ACC     --  A = M.ando
		 when "00011111" => data <= "10101000";  -- 27 MOV DPTR, CTE --POSICIÓN DE PRODUCTO
		 when "00100000" => data <= "10000010";  -- 28 CTE (0x82) --130
		 when "00100001" => data <= "00100000";  -- 29 MOV ACC,[DPTR] --ACC = PRODUCTO
		 when "00100010" => data <= "01001000";  -- 30 ADD ACC,A --PRODC = PROD + M.ando		 
		 when "00100011" => data <= "00110000";  -- 31 MOV [DPTR],ACC  --DPTR = 0xFF --ACC = PRODUCTO --GUARDO PROD
		 --CONTADOR DISMINUYE
		 when "00100100" => data <= "10101000";  -- 35 MOV DPTR, CTE --POSICIÓN DE M.dor ///--DESPLAZAMIENTO--///
		 when "00100101" => data <= "10000001";  -- 12 CTE (0x81) --129
		 when "00100110" => data <= "00100000";  -- 37 MOV ACC,[DPTR] --ACC = M.dor
		 --DESPLAZAMIENTO
		 when "00100111" => data <= "00010000";  -- 38 MOV A, ACC     --  A = M.dor
		 when "00101000" => data <= "10000000";  -- 39 Shift_right(A)
		 when "00101001" => data <= "00001000";  -- 40 MOV ACC, A		 
		 when "00101010" => data <= "00110000";  -- 41 MOV [DPTR],ACC --GUARDO M.dor luego de desplazarlo
		 when "00101011" => data <= "10101000";  -- 42 MOV DPTR, CTE --POSICIÓN DE M.ando
		 when "00101100" => data <= "10000011";  -- 7 CTE (0x83)--131
		 when "00101101" => data <= "00100000";  -- 44 MOV ACC,[DPTR] --ACC = M.ando
		 
		 when "00101110" => data <= "00010000";  -- 45 MOV A, ACC     --  A = M.ando
		 when "00101111" => data <= "10001000";  -- 46 Shift_left(A)
		 when "00110000" => data <= "00001000";  -- 47 MOV ACC, A
		 when "00110001" => data <= "00110000";  -- 48 MOV [DPTR],ACC --GUARDO M.ando luego de desplazarlo
		 when "00110010" => data <= "10101000";  -- 49 MOV DPTR, CTE --POSICIÓN DE PRODUCTO
		 when "00110011" => data <= "10000010";  -- 50 CTE (0x82) --130
		 when "00110100" => data <= "00100000";  -- 51 MOV ACC,[DPTR] --ACC = PRODUCTO
		 
		 when "00110101" => data <= "00010000";  -- 52 MOV A, ACC     --  A = PRODUCTO
		 when "00110110" => data <= "10100000";  -- 32 MOV ACC,CTE1 / CTE1= -1
		 when "00110111" => data <= "10011000";  -- 33 ADD ACC,T
		 when "00111000" => data <= "10010000";  -- 34 MOV T, ACC
		 
		 when "00111001" => data <= "10011000";  -- 33 MOV ACC,T
		 
		 when "00111010" => data <= "01011010";  -- 53 JZ ACC  //////////////////////////
		 when "00111011" => data <= "00111110";  -- 54 DIR FIN (57) DIR = 00111110
		 when "00111100" => data <= "01010000";  -- 55 JMP LOOP
		 when "00111101" => data <= "00010101";  -- 56 DIR LOOP 00010101
		 
		 when "00111110" => data <= "01111000";  -- RESTART --"00000000";  -- 57 FINALE
		 

		 when "01000010" => data <= "00000000";
		 when "01000011" => data <= "00000000";
		 when "01000100" => data <= "00000000";		 
		 when "01000101" => data <= "00000000";
		 when "01000110" => data <= "00000000";
		 when "01000111" => data <= "00000000";
		 when "01001000" => data <= "00000000";		 
		 when "01001001" => data <= "00000000";
		 when "01001010" => data <= "00000000";		 
		 when "01001011" => data <= "00000000";
		 when "01001100" => data <= "00000000";		 
		 when "01001101" => data <= "00000000";
		 when "01001110" => data <= "00000000";	 
		 when "01001111" => data <= "00000000";
		 
		 when "01110001" => data <= "00000000";
		 when "01110010" => data <= "00000000";
		 when "01110011" => data <= "00000000";
		 when "01110100" => data <= "00000000";
		 when "01110101" => data <= "00000000";
		 when "01110110" => data <= "00000000";
		 when "01110111" => data <= "00000000";
		 when "01111000" => data <= "00000000";
		 when "01111001" => data <= "00000000";
		 when "01111010" => data <= "00000000";
		 when "01111011" => data <= "00000000";
		 when "01111100" => data <= "00000000";
		 when "01111101" => data <= "00000000";
		 when "01111110" => data <= "00000000";
		 when "01111111" => data <= "00000000"; --FIN DE LA ROM
		 
		 when "10000011" => data <= "00000101";-- (5) POSICIÓN DE M.ando  CTE (0x83)--131
		 when "10000001" => data <= "00001001";-- (9) POSICIÓN DE M.dor   CTE (0x81)--129
		 when "10000010" => data <= "00000000";-- (0) POSICIÓN DE PRODUCTO    (0x82) --130
		 
		 
		 when others => data <= (others => 'X'); 
       end case;
else data <= (others => 'Z');
end if;  
end process;
end;
