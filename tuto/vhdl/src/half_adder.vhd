library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity half_adder is
    port (
        i_operand1  : in std_logic;
        i_operand2  : in std_logic;

        o_result    : out std_logic;
        o_carry     : out std_logic
    );
end half_adder;

architecture rtl of half_adder is
begin

    o_result    <= i_operand1 xor i_operand2;
    o_carry     <= i_operand1 and i_operand2;

end architecture;