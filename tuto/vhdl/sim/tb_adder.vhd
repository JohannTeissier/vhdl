library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity tb_adder is
    generic (
        N_BITS : integer := 8
    );
end entity tb_adder;

architecture Behavioral of tb_adder is

    -- Component declaration for the Unit Under Test (UUT)
    component adder
        generic (
            N_BITS : integer

        );
        port (
            i_operand1 : in  std_logic_vector(N_BITS - 1 downto 0);
            i_operand2 : in  std_logic_vector(N_BITS - 1 downto 0);
            o_result   : out std_logic_vector(N_BITS - 1 downto 0);
            o_overflow : out std_logic
        );
    end component;

    -- Signals
    signal i_operand1 : std_logic_vector(N_BITS - 1 downto 0);
    signal i_operand2 : std_logic_vector(N_BITS - 1 downto 0);
    signal o_result   : std_logic_vector(N_BITS - 1 downto 0);
    signal o_overflow : std_logic;

    -- Constants
    constant ITERATIONS : integer := 100;
    constant WAITING_TIME : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut : adder
        generic map(
            N_BITS => N_BITS
        )
        port map(
            i_operand1 => i_operand1,
            i_operand2 => i_operand2,
            o_result   => o_result,
            o_overflow => o_overflow
        );


    -- Clock process
    process
    begin
        wait for 10 ns;
    end process;

    -- Stimulus process
    process
        variable seed1, seed2 : integer;
        variable x1, x2      : integer;
    begin
        -- Initialize random seed (VHDL does not support random number generation directly)
        seed1 := 42;
        seed2 := 42;

        -- Special case test
        i_operand1 <= std_logic_vector(to_unsigned(2**N_BITS - 1, N_BITS));
        i_operand2 <= std_logic_vector(to_unsigned(1, N_BITS));
        wait for WAITING_TIME;

        -- Check the result and overflow
        assert (to_integer(unsigned(o_result)) = 0)
            report "Result is incorrect" severity error;
        assert (o_overflow = '1')
            report "Overflow flag is incorrect" severity error;

        -- Test with random values
        for i in 0 to ITERATIONS-1 loop
            for j in 0 to ITERATIONS-1 loop
                -- Generate "random" values using a simple linear congruential generator
                x1 := (x1 * seed1 + 1) mod (2**N_BITS - 1);
                x2 := (x2 * seed2 + 1) mod (2**N_BITS - 1);

                i_operand1 <= std_logic_vector(to_unsigned(x1, N_BITS));
                i_operand2 <= std_logic_vector(to_unsigned(x2, N_BITS));
                wait for WAITING_TIME;

                -- Check the result and overflow
                if x1 + x2 < 2**N_BITS then
                    assert (to_integer(unsigned(o_result)) = x1 + x2)
                        report "Result is incorrect" severity error;
                    assert (o_overflow = '0')
                        report "Overflow flag is incorrect" severity error;
                else
                    assert (to_integer(unsigned(o_result)) = (x1 + x2) mod (2**N_BITS))
                        report "Result is incorrect" severity error;
                    assert (o_overflow = '1')
                        report "Overflow flag is incorrect" severity error;
                end if;
            end loop;
        end loop;

        -- Indicate completion
        report "Test completed successfully.";
        wait;
    end process;

end Behavioral;
