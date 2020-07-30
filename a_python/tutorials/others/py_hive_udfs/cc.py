#!/usr/bin/env python
import sys
#iterate by each record
for line in sys.stdin:
    #dropping "\n" character (end of line)
    line = line.replace("\n", "")
    #spliting each colums inside values
    values = line.split("\t")
    #reversing values
    values.reverse()
    #printing just first value
    print "\t".join(values)
