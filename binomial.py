#!/usr/bin/env python
"""
Calculate binomial coefficients via calculating the log of the binomial through calculating the log factorial.
Return either the binomial coefficient itself (as an integer) or its log (as a float).
"""

import argparse
# use an Argument Parser object to handle script arguments
parser = argparse.ArgumentParser()
parser.add_argument("-n", type=int, help="total number of items to choose from")
parser.add_argument("-k", type=int, help="number of items to choose")
parser.add_argument("-l", "--log", action="store_true", help="returns the log binomial coefficient")
parser.add_argument("--test", action="store_true", help="tests the module and quits")
args = parser.parse_args()

import math

def logfactorial(n,k=0):
    """
    Calculates log(n!) for any integer n>0
    Uses math.log() to calculate the log of a single value, and uses a loop to iterate over i and get the log(i) values.
    Checks argument n is an integer, and non-negative
    Optional argument k to calculate log(n!/k!) = log((k+1)*...*n) = log(k+1) + ... + log(n), with default k=0
    Checks optional argument k is a non-negative integer
    Returns log(1)=0 if k>n, with no error (it’s a sum of 0 terms)
    
    Example:

    >>> print(logfactorial(2))
    0.6931471805599453
    >>> print(logfactorial(4,2))
    2.4849066497880004
    >>> logfactorial(1.1)
    Traceback (most recent call last):
        ...
    AssertionError: error message: n is a non-integer
    >>> logfactorial(-2)
    Traceback (most recent call last):
        ...
    AssertionError: error message: n is negative
    >>> logfactorial(4,1.1)
    Traceback (most recent call last):
        ...
    AssertionError: error message: k is a non-integer
    >>> logfactorial(4,-2)
    Traceback (most recent call last):
        ...
    AssertionError: error message: k is negative
    >>> logfactorial(5)
    4.787491742782046
    >>> logfactorial(5,5)
    0
    >>> logfactorial(5,6)
    0
    """
    assert n  == int(n), "error message: n is a non-integer"
    assert n >= 0, "error message: n is negative"
    assert k  == int(k), "error message: k is a non-integer"
    assert k >= 0,  "error message: k is negative"
    sumlog = 0
    if k > n:
        return sumlog
    for i in range(k+1, n+1):
        sumlog += math.log(i)
    return sumlog

def choose(n,k,log=False):
    """
    Calculates the log of the binomial log(choose(n,k)) for any integers n>=0 and 0 <= k <= n
    Checks argument n is non-negative
    Checks argument k is less or equal to n, and non-negative
    Uses logfactorial() to calculate the log of the binomial, where log(choose(n,k)) = log(n!/k!) - log((n-k)!).
    Optional argument log to return either the binomial coefficient itself (as an integer) or its log (as a float). 
    Returns the binomial coefficient by default, not its log.

    Example:

    >>> choose(4,2)
    6
    >>> choose(4,2,True)
    1.791759469228055
    >>> choose(4,2,False)
    6
    >>> choose(-4,2)
    Traceback (most recent call last):
        ...
    AssertionError: error message: n is negative
    >>> choose(4,-2)
    Traceback (most recent call last):
        ...
    AssertionError: error message: k is negative or greater than n
    >>> choose(2,4)
    Traceback (most recent call last):
        ...
    AssertionError: error message: k is negative or greater than n
    """
    assert n >= 0, "error message: n is negative"
    assert (k >= 0) and (k <= n), "error message: k is negative or greater than n"

    if log:
        print(logfactorial(n,k) - logfactorial(n-k))
    else:
        print(round(math.exp(logfactorial(n,k) - logfactorial(n-k))))

def runTests():
    """
    Test the package instead of calculating one particular coefficient value 
    Incompatible with n, k, log options
    """
    print("testing the module...")
    if args.n:
        print("ignoring n for testing purposes")
    if args.k:
        print("ignoring k for testing purposes")
    if args.log:
        print("ignoring log for testing purposes")
    import doctest
    doctest.testmod()
    print("done with tests.")

if __name__ == '__main__':
    if args.test:
        runTests()
    else:
        choose(args.n,args.k,args.log)


