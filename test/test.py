# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer

A = 6
B = 6
K = 0x5a
IMASK = (1 << A) - 1
OMASK = (1 << B) - 1


def loopback(ui, uio):
    """uo_out, uio_out while rst_n is low"""
    uo = (((ui >> A) << A) | (uio & IMASK)) ^ K
    return uo & 0xFF, ((ui >> (8 - B)) ^ (K >> (8 - B))) & OMASK


@cocotb.test()
async def test_loopback(dut):
    """While in reset, every input reaches an output."""
    dut.clk.value = 0
    dut.rst_n.value = 0
    rng = random.Random(1)
    for _ in range(400):
        ui, uio = rng.randrange(256), rng.randrange(1 << A)
        dut.ui_in.value = ui
        dut.uio_in.value = uio
        await Timer(1, unit="us")
        uo, out = loopback(ui, uio)
        assert dut.uo_out.value == uo
        assert dut.uio_out.value == out


@cocotb.test()
async def test_counter(dut):
    """Out of reset: a counter on uo_out (xor K) and on uio_out."""
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)
    for i in range(300):
        assert dut.uo_out.value == (i & 0xFF) ^ K
        assert dut.uio_out.value == i & OMASK
        await ClockCycles(dut.clk, 1)
