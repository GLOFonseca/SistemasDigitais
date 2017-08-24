library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Contador ascedente descendente, enable, com carga, iterrupçao

entity counterN2 is
	generic(N: positive := 8);
	port(
		-- entradas de controle
		clock, reset: in std_logic;
		enb, asc, load: in std_logic;
		-- entrada de dados
		d: in std_logic_vector(N-1 downto 0);
		-- saida de controle
		interrupt: out std_logic;
		-- saida de dados 
		q: out std_logic_vector(N-1 downto 0)
	);
end;

architecture canonical of counterN2 is
	--type State is std_logic_vector(N-1 downto 0); --mudar apenas o que esta dentro do is
	signal nextState, actualState: unsigned(N-1 downto 0); --State; 
begin

	-- -- Next-State Logic -- --
	nextState <=	unsigned(d) when load='1' else
						actualState+1 when enb='1' and asc='1' else
						actualState-1 when enb='1' else
						actualState;
	
		
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
	interrupt <= '1' when actualState=2**N-1 else '0';

end;
