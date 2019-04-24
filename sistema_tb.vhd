LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------
ENTITY sistema_tb IS                    --IMPORTANTE: La entidad debe estar vacìa
END ENTITY sistema_tb;
-------------------------------------
ARCHITECTURE testbench OF sistema_tb IS
	                                          -- diseño de la arquitectura
															-- declaraciòn de las señales del TESTBENCH
	SIGNAL   rst_n_tb,	int_tb:  	std_logic;
	--,	iom_tb,	rw_tb
	
   SIGNAL	clk_tb  	:std_logic:='0';
   SIGNAL   bus_data_out_tb  	:  std_logic_vector(7 downto 0);

	                    
--	SIGNAL bus_dir_tb, bus_data_in_tb,                       
--	SIGNAL   
--	SIGNAL   
BEGIN

	DUT:	ENTITY work.sistema           --llamado de la funciòn, se asignan a las entradas 
	PORT MAP(
--	         bus_dir      => bus_dir_tb, 
--	         bus_data_in  => bus_data_in_tb,	
	         bus_data_out => bus_data_out_tb, 
	         clk          => clk_tb, 
				rst_n     	 => rst_n_tb,
	         int          => int_tb	
--				iom          => iom_tb,
--				rw       	 => rw_tb		                          --y salidas las señales que se crearon en la arquitectura
		      );
				
   clk_tb         <= (NOT clk_tb) AFTER 50 ns;
	
	rst_n_tb       <=   '0' after 200 ns,
	                    '1' after 800 ns,
							  '0' after 1600 ns,
	                    '1' after 2400 ns;
	                   -- '0' AFTER 100 ns
--	
--	bus_data_out_tb <=   "00000010" AFTER 30 ns,
--                        "00000001" after 40 ns;	
	
	int_tb          <=   '0' AFTER 50 ns,
                        '1' after 150 ns,
								'0' AFTER 300 ns;
	
--	signal_generation: PROCESS
--	BEGIN
--		 bus_data_in_tb   <=   "00000010";	
--		 int_tb           <=   '1';
--		WAIT FOR 200 ns;
--		
--       bus_data_in_tb   <=   "00000001";	
--		 int_tb           <=   '0';
--		WAIT FOR 200 ns;
--
--	END PROCESS signal_generation;

END ARCHITECTURE testbench;