#!/usr/bin/python
import sys

items_sold = []  # create global list variable

class Items:  # create class to store and access items added
    def __init__(self, x):
    	self.x = x

    def set_x(self, x):
        self.x = x
    
    def get_x(self):
        return self.x

def print_results():  # print output in Hive
	result_set = [item.get_x() for item in items_sold];
	print (result_set)

	# Hive submits each record to stdin
	# The record/line is stripped of extra characters and submitted
for line in sys.stdin:
	line = line.strip()
	purchased_item = line.split('\t')
	items_sold.append(Items(purchased_item))

print_results()
