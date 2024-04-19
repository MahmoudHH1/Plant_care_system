library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity PCS is
    Port (
	 ----------Buttons used for starting and ending the process
        startB : in  STD_LOGIC;   
        stop  : in  STD_LOGIC; 
	 -------built-in clk used for implementing the stages with different periodic time-------  
		  clk : in STD_LOGIC ;
	 ------------------Stage indicator LEDS--------------------
        LED1   : out STD_LOGIC;   
        LED2   : out STD_LOGIC ;
	-------------voltage on for the servo motor and the waterpump-----------------
		  waterPump   : out STD_LOGIC;   
        fertilizerMotor : out STD_LOGIC;
	----------------------servo duty clock to control the rotation degree with specific frequency-----
		  servoDuty : out STD_LOGIC 
    );
end PCS;

Architecture PCS_arch of PCS is
	---------------Start System when button is clicked and stages indicator signals----------------
	signal startSystem : std_logic := '0' ; 
	signal stages :unsigned(1 downto 0) := "00" ;
	------------Clock divison and enable signals------------------
	signal clk_div_enable  : std_logic;
	signal clk_enable_counter : integer range 0 to 100000000;
	---------------------Servo pwm and duty cycle signals-------------------------
	signal servo_PWM_period :integer :=0 ;
	
	begin
	process(clk)
	begin
	if(rising_edge(clk)) then
		servo_PWM_period <= servo_PWM_period + 1 ;
		clk_enable_counter <= clk_enable_counter + 1;
		--------------handling duty cycle to be 5% of the PWM cycle to rotate 90 degrees------------------------
		if(servo_PWM_period<50000 ) then
			servoDuty <='1' ;
		else
			servoDuty<='0' ;
		end if ;
		--------------generating a clock cycle with frequency of 0.5 hz using---------- 
		-------------built-in clock and clock division signals-----------------
		if(clk_enable_counter = 0) then
			clk_div_enable <= '1';
		else
			clk_div_enable <= '0';
    end if;
	end if;
	end process;
------------------------------------------------------------------
	process(clk  , startB)
	begin
	if(rising_edge(clk)) then
	IF startB = '0'then 
			startSystem <= '1' ;
		end if ;
    if(stop = '0') then
			LED1 <= '0' ;
			LED2 <= '0' ;
			waterPump <= '0' ;
			fertilizerMotor <= '0' ;
			startSystem <= '0' ;
			stages <="00" ;
    elsif(clk_div_enable = '1' and startSystem = '1' ) then
			if stages = "00" then  
                waterPump <= '1'; 
                LED1 <= '1'; 
					 fertilizerMotor <= '0';
					 stages <= stages + 1 ;
          elsif stages = "01"  then
                waterPump <= '0'; 
                fertilizerMotor <= '1'; 
                LED1<= '0' ; 
                LED2 <= '1' ;
					 stages <= stages +1 ;
          else
					fertilizerMotor <= '0';
					stages<= "00" ;
                LED2 <= '0'; 
					 startSystem <= '0' ;
          end if; 
	end if;
  end if ;
end process;
end PCS_arch;