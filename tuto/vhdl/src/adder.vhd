library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    generic (
        N_BITS : integer
    );
    port (
        i_operand1  : in std_logic_vector(N_BITS - 1 downto 0);
        i_operand2  : in std_logic_vector(N_BITS - 1 downto 0);

        o_result    : out std_logic_vector(N_BITS - 1 downto 0);
        o_overflow  : out std_logic
    );
end adder;

architecture rtl of adder is

    component full_adder
        port(
            i_operand1 : in  std_logic;
            i_operand2 : in  std_logic;
            i_carry    : in  std_logic;
            o_result   : out std_logic;
            o_carry    : out std_logic
        );
    end component full_adder;

    signal s_carry : std_logic_vector(N_BITS downto 0);

begin

    s_carry(0) <= '0';
    o_overflow <= s_carry(N_BITS);

    gen_full_adder : for i in 0 to N_BITS - 1 generate
            d_full_adder : full_adder
                port map(
                    i_operand1 => i_operand1(i),
                    i_operand2 => i_operand2(i),
                    i_carry    => s_carry(i),
                    o_result   => o_result(i),
                    o_carry    => s_carry(i + 1)
                );

    end generate gen_full_adder;

end architecture;