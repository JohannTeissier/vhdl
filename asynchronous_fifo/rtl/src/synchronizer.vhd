library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity synchronizer is
    generic (
        WIDTH : integer
    );
    port (
        i_clk : in std_logic;
        i_rst : in std_logic;
        i_data : in std_logic_vector(WIDTH - 1 downto 0);

        o_data : out std_logic_vector(WIDTH - 1 downto 0)
    );
end synchronizer;

architecture rtl of synchronizer is

    signal s_reg1 : std_logic_vector(WIDTH - 1 downto 0);
    signal s_reg2 : std_logic_vector(WIDTH - 1 downto 0);

begin

    main : process(i_clk) is
    begin
        if rising_edge(i_clk) then
            if i_rst = '1' then
                s_reg1 <= (others => '0');
                s_reg2 <= (others => '0');
            else
                s_reg1 <= i_data;
                s_reg2 <= s_reg1;
            end if;

        end if;
    end process main;

    o_data <= s_reg2;

end architecture;