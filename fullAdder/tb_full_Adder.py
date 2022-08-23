# -*- coding: utf-8 -*-
import cocotb

import random

from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.regression import TestFactory
from cocotb.result import TestFailure, TestError, ReturnValue, SimFailure, TestSuccess

@cocotb.test()
async def co_test(dut):
    PERIOD = 20
    dut.co.value=0    
    dut.sum.value=0    
    dut.a.value=1
    dut.b.value=1
    dut.ci.value=1
    await Timer(PERIOD)
    print("\t\t\t CO = "+dut.co.value.binstr)
    print("\t\t\t SUM = "+dut.sum.value.binstr)
    await Timer(PERIOD)
    if (dut.co.value.binstr=="z"):
        raise TestFailure("Result CO should be {} and it was {}".format(0, dut.co.value.binstr))
    elif (dut.co.value.binstr=="x"):
        raise TestFailure("Result CO should be {} and it was {}".format(0, dut.co.value.binstr))
    elif (dut.co.value.binstr=="0"):
        raise TestFailure("Result CO should be {} and it was {}".format(0, dut.co.value.binstr))
    else:
        raise TestSuccess("Result CO should be {} and it was {}".format(1, dut.co.value.binstr))

@cocotb.test()
async def entire_test(dut):
    PERIOD = 20
    dut.co.value=0    
    dut.sum.value=0    
    dut.a.value=1
    dut.b.value=1
    dut.ci.value=1
    i=0
    for a in range(2):
        for b in range(2):  
            for ci in range(2):
                dut.a.value = a
                dut.b.value = b
                dut.ci.value = ci
                await Timer(PERIOD)
                result =(a+b+ci)
                #print("\t\t\tExpected result = "+str(bin(a+b+ci)))
                if dut.co.value.binstr=="z" or dut.co.value.binstr=="x":
                    raise SimFailure("co is a metadata")
                elif dut.sum.value.binstr=="z" or dut.sum.value.binstr=="x":
                    raise SimFailure("sum is a metadata")
                else:
                    dut_res=(dut.co.value.integer*2 + dut.sum.value.integer) 
                    #print("\t\t\tDut res ="+str(dut_res))
                    if (result != dut_res):
                        assert False,("Result should be {} and it was {}{}".format(bin(result), dut.co.value.binstr,dut.sum.value.binstr))
                    else:
                        dut._log.info("Success: Result should be {} and it was {}{}".format(bin(result), dut.co.value.binstr,dut.sum.value.binstr))
                    await Timer(PERIOD)
            await Timer(PERIOD)
        await Timer(PERIOD)
       
   
# Register the test.
factory = TestFactory(co_test)
factory = TestFactory(entire_test)
#factory.generate_tests()
    