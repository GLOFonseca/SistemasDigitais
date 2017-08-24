library ieee;
use ieee.std_logic_1164.all;

entity registerN is
	generic(N: positive := 8);
	port(
		clock, reset: in std_logic;
		d: in std_logic_vector(N-1 downto 0);
		q: out std_logic_vector(N-1 downto 0)
	);
end;

architecture canonical of registerN is
	--type State is std_logic_vector(N-1 downto 0); --mudar apenas o que esta dentro do is
	signal nextState, actualState: std_logic_vector(N-1 downto 0); --State; 
begin
	-- Next-State Logic
	nextState <= d;
	
	-- Memory Element (State Element) -- sera SEMPRE igual
	process(clock, reset) is -- sequencial 
	begin
		if reset='1' then
			actualState <= (others=>'0'); -- MUDAR apenas o que o actualState recebe
		elsif rising_edge(clock) then -- clock'event and clock='1' NAO USAR. MELHOR rising_edge()
			actualState <= nextState;
		end if;
	end process; -- utilizar process para setar apenas um valor, caso outro fazer outro process
	
	-- Output Logic
	q <= actualState;

end;
