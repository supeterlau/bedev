def fact(n):
    ret = 1
    for i in range(2, n+1):
        ret *= i
    return ret
