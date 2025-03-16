library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is
    port (
        i_operand1  : in std_logic;
        i_operand2  : in std_logic;
        i_carry     : in std_logic;

        o_result    : out std_logic;
        o_carry     : out std_logic
    );
end full_adder;

architecture rtl of full_adder is

    component half_adder
        port(
            i_operand1 : in  std_logic;
            i_operand2 : in  std_logic;
            o_result   : out std_logic;
            o_carry    : out std_logic
        );
    end component half_adder;

    signal s_carry1         : std_logic;
    signal s_carry2         : std_logic;
    signal s_interconnect   : std_logic;

begin

    u_half_adder1 : half_adder
        port map(
            i_operand1 => i_operand1,
            i_operand2 => i_operand2,
            o_result   => s_interconnect,
            o_carry    => s_carry1
        );

    u_half_adder2 : half_adder
        port map(
            i_operand1 => s_interconnect,
            i_operand2 => i_carry,
            o_result   => o_result,
            o_carry    => s_carry2
        );

    o_carry <= s_carry1 or s_carry2;

end architecture;