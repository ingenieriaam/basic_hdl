# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0


def adder_model(a: int, b: int, m:bool) -> int:
    """ model of adder """
    result=0
    if m==0:
        result=a+b
    else:
        result=a-b
    return result

def co_model(a: int, b: int, m:bool) -> bool:
    result=0
    co=0
    if m==0:
        result=a+b
    else:
        result=a-b

    if result>255:
        co=1
    elif b>a:
        co=1
    else:
        co=0
    return co
