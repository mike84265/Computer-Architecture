1. How the code is implemented
    1) jal to func segment. In the func segment, it first judge whether the input n should call recursion. 
    branch to recurse part if n is larger than 1. Otherwise, store c*n to $v0
    2) In recurse part, store the current $ra into the stack, and calculate T(n/2) by divided $a0 by 2 and calling func again.
    3) After T(n/2) is calculated, multiply it by 2 and add with c*n to it. Then store the result into $v0 and jump back.
    4) Other part like I/O and atoi/itoa are all the same as HW2.

2. Platform during doing this homework: macOS 10.13
