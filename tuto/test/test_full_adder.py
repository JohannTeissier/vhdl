from cocotb.triggers import Timer
import cocotb
import os

WAITING_TIME = 10

@cocotb.test()
async def main(dut):
    i_operand1 = dut.i_operand1
    i_operand2 = dut.i_operand2
    i_carry = dut.i_carry

    o_result = dut.o_result
    o_carry = dut.o_carry

    for i in range(2):
        for j in range(2):
            for k in range(2):
                i_operand1.value = i
                i_operand2.value = j
                i_carry.value = k

                await Timer(WAITING_TIME, units="ns")

                if i + j + k == 0:
                    assert int(o_result.value) == 0
                    assert int(o_carry.value) == 0

                if i + j + k == 1:
                    assert int(o_result.value) == 1
                    assert int(o_carry.value) == 0

                if i + j + k == 2:
                    assert int(o_result.value) == 0
                    assert int(o_carry.value) == 1

                if i + j + k == 3:
                    assert int(o_result.value) == 1
                    assert int(o_carry.value) == 1



def test_full_adder(runner):

    runner.test(
        hdl_toplevel="full_adder",
        test_module=__name__,
        gui=os.getenv("GUI", False),
        test_args=[f"--wave=vcd_{__name__}.vcd", "--format=vcd"],
        waves=True
    )
