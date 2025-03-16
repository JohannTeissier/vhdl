from util import cycles, gen_clk, gen_rst
from cocotb import start
from cocotb.triggers import Timer, RisingEdge
import numpy as np
import cocotb
import os

WIDTH = 32

ITERATION = 100

PERIOD = 20
DELAY = 3

@cocotb.test()
async def main(dut):
    np.random.seed(42)

    i_data = dut.i_data
    i_clk = dut.i_clk
    i_rst = dut.i_rst

    o_data = dut.o_data

    await start(gen_clk(i_clk, PERIOD))
    await gen_rst(i_clk, i_rst)

    datas = np.random.randint(2**WIDTH - 1, size=(ITERATION))

    await Timer(DELAY, units="ns")

    for data in datas:
        data = int(data)

        i_data.value = data

        await cycles(i_clk, 2)
        await Timer(DELAY, units="ns")

        assert int(o_data.value) == data





def test_synchronizer(runner):

    runner.test(
        hdl_toplevel="synchronizer",
        test_module=__name__,
        gui=os.getenv("GUI", False),
        test_args=[f"--wave=vcd_{__name__}.vcd", "--format=vcd"],
        waves=True,
        parameters={"WIDTH" :  WIDTH}
    )