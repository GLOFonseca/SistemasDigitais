library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counterN is
	generic(N: positive := 8);
	port(
		--entradas de controle
		clock, reset: in std_logic;
		--d: in std_logic_vector(N-1 downto 0);
		q: out std_logic_vector(N-1 downto 0)
	);
end;

architecture canonical of counterN is
	--type State is std_logic_vector(N-1 downto 0); --mudar apenas o que esta dentro do is
	signal nextState, actualState: unsigned(N-1 downto 0); --State; 
begin
	-- -- Next-State Logic -- --
	nextState <= actualState + 1;
	
	
	
	-- Memory Element (State Element) -- sera SEMPRE igual
	process(clock, reset) is -- sequencial 
	begin
		if reset='1' then
			actualState <= (others=>'0'); -- MUDAR apenas o que o actualState recebe
		elsif rising_edge(clock) then -- clock'event and clock='1' NAO USAR. MELHOR rising_edge()
			actualState <= nextState;
		end if;
	end process; -- utilizar process para setar apenas um valor, caso outro fazer outro process
	
	
	
	
	-- -- Output Logic -- --
	q <= std_logic_vector(actualState);

end;
