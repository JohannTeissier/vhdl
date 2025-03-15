# from cocotb.triggers import Timer
# import numpy as np
# import cocotb
# import os

# N_BITS = 32

# ITERATION = 100

# @cocotb.test()
# async def main(dut):
#     np.random.seed(42)

#     i_operand1 = dut.i_operand1
#     i_operand2 = dut.i_operand2

#     o_result = dut.o_result
#     o_overflow = dut.o_overflow

#     x1 = np.random.randint(2**N_BITS - 1, size=(ITERATION))
#     x2 = np.random.randint(2**N_BITS - 1, size=(ITERATION))

#     # Specila case we want to test
#     i_operand1.value = 2**N_BITS - 1
#     i_operand2.value = 1

#     await Timer(10, units="ns")

#     assert int(o_result.value) == 0
#     assert int(o_overflow.value) == 1

#     for i in x1:
#         for j in x2:
#             i = int(i)
#             j = int(j)

#             i_operand1.value = i
#             i_operand2.value = j

#             await Timer(10, units="ns")

#             if i + j < 2**N_BITS:
#                 assert int(o_result.value) == i + j
#                 assert int(o_overflow.value) == 0
#             else:
#                 assert int(o_result.value) == i + j - 2**N_BITS
#                 assert(o_overflow.value) == 1




# def test_adder(runner):

#     runner.test(
#         hdl_toplevel="adder",
#         test_module=__name__,
#         gui=os.getenv("GUI", False),
#         test_args=[f"--wave=vcd_{__name__}.vcd", "--format=vcd"],
#         waves=True,
#         parameters={"N_BITS" :  N_BITS}
#     )
