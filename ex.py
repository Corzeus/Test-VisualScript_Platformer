import random
import os
import math
import abc
# ###constant
# ###variable
close = False
setup = False
frames = 0
# ###fonction
def init():
	print("setup ok")
	return(True)

# ###classe
while not close:
	if not setup:
		setup=init()
	if frames == 10000:
		close = True
	frames += 1
	print(frames)
