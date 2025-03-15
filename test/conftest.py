from cocotb.runner import get_runner
from pathlib import Path
import pytest


@pytest.fixture(scope="session")
def runner():
    sources = [
        "half_adder.vhd",
        "full_adder.vhd",
    ]

    rtl_path = (Path(__file__) / "../../vhdl/src").resolve()
    sources = [rtl_path / src for src in sources]

    runner = get_runner("nvc")
    runner.build(sources=sources)
    return runner
