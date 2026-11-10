# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_loopback(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # While in reset: ui_in -> uo_out
    dut.ui_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 1)

    for i in range(256):
        dut.ui_in.value = i
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == i


@cocotb.test()
async def test_counter(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Out of reset: a counter on uo_out
    dut.ui_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)

    dut._log.info("Testing counter")
    for i in range(256):
        assert dut.uo_out.value == i
        await ClockCycles(dut.clk, 1)

    dut._log.info("Testing reset")
    for i in range(5):
        assert dut.uo_out.value == i
        await ClockCycles(dut.clk, 1)
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 2)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0
