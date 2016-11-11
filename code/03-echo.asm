#MIT License
#
#Copyright (c) 2016 Keith Stellyes
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

# Author: Keith Stellyes
# From my MIPS tutorial
# Gets a string from user, then repeats it.

.text
	li $a0, 500   #allocate 400 bytes
	li $v0, 9     #set syscall to allocate memory
	syscall
	
	la $a0,($v0) #set the target address for the read string 
	li $a1, 500   #set max number of chars to read 
	li $v0, 8     #set syscall to read string
	syscall
	
	li $v0,4     #set syscall to print string
	syscall
	
	li $v0,10    #exit cleanly with EXIT_SUCCESS
	syscall