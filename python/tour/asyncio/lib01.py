#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2021 Peter Lau <superpeterlau@outlook.com>
#
# Distributed under terms of the MIT license.

import time
import asyncio

async def main1():
    print("Hello")
    await asyncio.sleep(1)
    print("DONE")

# method 1
# asyncio.run(main())
# print(main())

async def say_after(delay, message):
    await asyncio.sleep(delay)
    print(message)

async def main2():
    print(f"started at {time.strftime('%X')}")
    await say_after(2, 'Hello Main2')
    await say_after(1, 'Done Main2')
    print(f"Finished at {time.strftime('%X')}")

# asyncio.run(main2())

async def main3():
    task1 = asyncio.create_task(
        say_after(1, 'Hello Main3')
    )

    task2 = asyncio.create_task(
        say_after(2, 'Done Main3')
    )

    print(f"Started at {time.strftime('%X')}")
    await task1
    await task2

    print(f"Finished at {time.strftime('%X')}")

asyncio.run(main3())
