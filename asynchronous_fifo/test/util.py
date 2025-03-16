from cocotb.triggers import RisingEdge, Timer
from dataclasses import asdict, is_dataclass
from typing import TypeVar, get_origin, get_args
import cocotb
import numpy as np

T = TypeVar("T")


def clog2(x):
    if x <= 0:
        raise ValueError("clog2 is only defined for positive integers")
    return (x - 1).bit_length()


async def gen_clk(clk, period):
    while True:
        clk.value = 1
        await Timer(period/2, units="ns")
        clk.value = 0
        await Timer(period/2, units="ns")


async def gen_rst(clk, rst):
    rst.value = 1
    for _ in range(5):
        await RisingEdge(clk)

    rst.value = 0


async def gen_clk_rst(clk, period, rst):
    await cocotb.start(gen_clk(clk, period))
    await cocotb.start(gen_rst(clk, rst))


async def cycles(clk, n):
    for _ in range(n):
        await RisingEdge(clk)


async def cycles_timeout(clk, count):
    await cycles(clk, count)
    assert False


def set_value(handle, value) -> None:
    if is_dataclass(value):
        set_value(handle, asdict(value))

    elif isinstance(value, dict):
        for k, v in value.items():
            set_value(getattr(handle, k), v)

    elif isinstance(value, (list, np.ndarray)):
        for i, v in enumerate(value):
            set_value(handle[i], v)

    elif isinstance(value, np.integer):
        handle.value = int(value)

    else:
        handle.value = value


def get_value(handle, dtype: type[T]) -> T:
    args = get_args(dtype)
    origin = get_origin(dtype)
    dtype = origin if origin else dtype

    if is_dataclass(dtype):
        kwargs = {}
        for attr, attr_dtype in dtype.__annotations__.items():
            attr_handle = getattr(handle, attr)
            kwargs[attr] = get_value(attr_handle, attr_dtype)

        return dtype(**kwargs)

    elif issubclass(np.ndarray, dtype):
        _, item_type = args
        return get_value(handle, list[item_type])

    elif issubclass(np.dtype, dtype):
        actual_dtype = args[0]
        return get_value(handle, actual_dtype)

    elif issubclass(list, dtype):
        item_type = args[0]
        return [
            get_value(handle[i], item_type)
            for i, _ in enumerate(handle)
        ]

    else:
        return dtype(handle.value)