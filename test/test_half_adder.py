from cocotb.triggers import Timer
import cocotb
import os

@cocotb.test()
async def main(dut):
    entry1 = dut.i_operand1
    entry2 = dut.i_operand2

    result = dut.o_result
    carry_out = dut.o_carry

    for i in range(2):
        for j in range(2):
            entry1.value = i
            entry2.value = j

            await Timer(10, units="ns")

            if i + j == 2:
                assert int(result.value) == 0
                assert int(carry_out.value) == 1

            if j + i == 1:
                assert int(result.value) == 1
                assert int(carry_out.value) == 0

            if j + i == 0:
                assert int(result.value) == 0
                assert int(carry_out.value) == 0



def test_half_adder(runner):

    runner.test(
        hdl_toplevel="half_adder",
        test_module=__name__,
        gui=os.getenv("GUI", False),
        test_args=[f"--wave=vcd_{__name__}.vcd", "--format=vcd"],
        waves=True
    )
