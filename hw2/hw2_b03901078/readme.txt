1. How the code is implemented
    1) store '+', '-', '*', '/' to register and compare if $s3 matches any. If so, jump to the corresponding segment. If the operator matches none of the supported operators, jump to a special segment that turn output_ascii to 'XXXX' and output. Also, if the divider is zero, jump to that segment.
    2) To turn an integer into ASCII string, keep dividing it by 10 and save its remainder, then add it by (int)'0'. The result is saved into the stack.
    3) Read the string from stack into output_ascii
    4) Output the result

2. Platform during doing this homework: macOS 10.13
