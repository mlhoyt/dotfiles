#!/usr/bin/env python3

import re
import sys

# https://stackoverflow.com/questions/14693701/how-can-i-remove-the-ansi-escape-sequences-from-a-string-in-python

ansi_escape = re.compile(r'\\x1[bB]\[\d+m', re.MULTILINE)

for line in sys.stdin:
    filteredLine = ansi_escape.sub('', line)
    print(type(filteredLine))
    print(filteredLine)
    # print(ansi_escape.sub('', line).decode('unicode_escape'))
