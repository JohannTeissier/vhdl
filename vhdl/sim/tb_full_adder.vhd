library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_full_adder is
end tb_full_adder;

architecture behavior of tb_full_adder is

    constant WAITING_TIME : time := 10 ns;


    component full_adder
        port(
            i_operand1 : in  std_logic;
            i_operand2 : in  std_logic;
            i_carry    : in  std_logic;
            o_result   : out std_logic;
            o_carry    : out std_logic
        );
    end component full_adder;

    signal s_i_operand1 : std_logic;
    signal s_i_operand2 : std_logic;
    signal s_i_carry    : std_logic;
    signal s_o_result   : std_logic;
    signal s_o_carry    : std_logic;

begin

    test_full_adder : component full_adder
        port map(
            i_operand1 => s_i_operand1,
            i_operand2 => s_i_operand2,
            i_carry    => s_i_carry,
            o_result   => s_o_result,
            o_carry    => s_o_carry
        );

    stimulus: process
    variable v_i_operand1 : std_logic_vector(0 downto 0) := (others => '0');
    variable v_i_operand2 : std_logic_vector(0 downto 0) := (others => '0');
    variable v_i_carry    : std_logic_vector(0 downto 0) := (others => '0');

    begin
        for i in 0 to 1 loop
            for j in 0 to 1 loop
                for k in 0 to 1 loop
                    v_i_operand1    := std_logic_vector(to_unsigned(i, 1));
                    v_i_operand2    := std_logic_vector(to_unsigned(j, 1));
                    v_i_carry       := std_logic_vector(to_unsigned(k, 1));

                    s_i_operand1    <= v_i_operand1(0);
                    s_i_operand2    <= v_i_operand2(0);
                    s_i_carry       <= v_i_carry(0);

                    wait for WAITING_TIME;

                    if (i + j + k) = 0 then
                        assert s_o_result = '0' severity error;
                        assert s_o_carry = '0' severity error;
                    end if;

                    if (i + j + k) = 1 then
                        assert s_o_result = '1' severity error;
                        assert s_o_carry = '0' severity error;
                    end if;

                    if (i + j + k) = 2 then
                        assert s_o_result = '0' severity error;
                        assert s_o_carry = '1' severity error;
                    end if;

                    if (i + j + k) = 3 then
                        assert s_o_result = '1' severity error;
                        assert s_o_carry = '1' severity error;
                    end if;

                end loop;

            end loop;

        end loop;

        wait;
    end process stimulus;

end architecture;