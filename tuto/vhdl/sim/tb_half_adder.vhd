library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_half_adder is
end tb_half_adder;

architecture behavior of tb_half_adder is

    constant WAITING_TIME : time := 10 ns;


    component half_adder
        port(
            i_operand1 : in  std_logic;
            i_operand2 : in  std_logic;
            o_result   : out std_logic;
            o_carry    : out std_logic
        );
    end component half_adder;

    signal s_operand1   : std_logic;
    signal s_operand2   : std_logic;

    signal s_result     : std_logic;
    signal s_carry      : std_logic;

begin

    test_half_adder : component half_adder
        port map(
            i_operand1 => s_operand1,
            i_operand2 => s_operand2,
            o_result   => s_result,
            o_carry    => s_carry
        );


    stimulus: process
        variable v_operand1 : std_logic_vector(0 downto 0) := (others => '0');
        variable v_operand2 : std_logic_vector(0 downto 0) := (others => '0');

    begin
        for i in 0 to 1 loop
            for j in 0 to 1 loop
                v_operand1 := std_logic_vector(to_unsigned(i, 1));
                v_operand2 := std_logic_vector(to_unsigned(j, 1));

                s_operand1 <= v_operand1(0);
                s_operand2 <= v_operand2(0);

                wait for WAITING_TIME;

                if i + j = 0 then
                    assert s_result = '0' severity error;
                    assert s_carry = '0' severity error;
                end if;

                if i + j = 1 then
                    assert s_result = '1' severity error;
                    assert s_carry = '0' severity error;
                end if;

                if i + j = 2 then
                    assert s_result = '0' severity error;
                    assert s_carry = '1' severity error;
                end if;

            end loop;

        end loop;
        wait;
    end process stimulus;


end architecture;