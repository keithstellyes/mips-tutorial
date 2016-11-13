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
# This loop takes an integer n, then counts down from there.

.data
	newline: .asciiz "\n"
	inputstr: .asciiz "How many times to loop?\n"
	donestr: .asciiz "No more times to loop :'(\n"

.text 
	la $a0, inputstr #Load string
	li $v0, 4     #Set syscall to print string
	syscall
	
	li $v0, 5    #read integer service. Integer returned in $v0
	syscall
	
	move $v1, $v0

loop:	
	# If $v1 == 0: goto alldone
	beqz $v1, alldone
		#inside loop...
		#print our counter
		li $v0, 1
		move $a0, $v1
		syscall
	
		#break to next line
		la $a0, newline
		li $v0, 4
		syscall
	
		#decrement counter and go back to start of loop.
		subi $v1, $v1, 1
	j loop
	
alldone:
	#print concluding string, and exit.
	la $a0, donestr
	li $v0, 4
	syscall
	li $v0, 10
	syscall
