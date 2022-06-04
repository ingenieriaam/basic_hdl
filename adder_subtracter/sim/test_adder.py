# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
# Simple tests for an adder module
import cocotb
from cocotb.triggers import Timer
from adder_model import adder_model
import random


@cocotb.test()
async def adder_basic_test(dut):
    """Test for 5 + 10"""
    # 8 bits -> max=256
    a = 5
    b = 10
    m=0

    dut.a <= a
    dut.b <= b
    dut.m <= m

    await Timer(2, units='ns')

    assert dut.r.value == adder_model(a, b, m), f"Adder result is incorrect: {dut.r.value} != 15"
    assert dut.co.value == co_model(a, b, m), f"co result is incorrect: {dut.co.value} != 0"

""" 
@cocotb.test()
async def adder_randomised_test(dut):
    #Test for adding 2 random numbers multiple times

    for i in range(10):

        A = random.randint(0, 15)
        B = random.randint(0, 15)

        dut.A <= A
        dut.B <= B

        await Timer(2, units='ns')

        assert dut.X.value == adder_model(A, B), "Randomised test failed with: {A} + {B} = {X}".format(
            A=dut.A.value, B=dut.B.value, X=dut.X.value)
 """