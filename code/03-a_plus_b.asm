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
# This program gets two integers, then prints the results.

.data
	a:.word 0
	b:.word 0
	givea: .asciiz "A:"
	giveb: .asciiz "B:"

.text
	# Read integer a
	la $a0, givea #Load string
	li $v0, 4     #Set syscall to print string
	syscall
	
	li $v0, 5    #read integer service. Integer returned in $v0
	syscall
	sw $v0, a    #store our integer into the memory location a.
	
	# Read integer b
	la $a0, giveb
	li $v0, 4
	
	li $v0, 5   #read integer service.
	syscall
	sw $v0, b   #store our integer into the memory location b.
	
	lw $a0, a
	lw $a1, b

	add $a0, $a0, $a1 #arg0 = arg1+arg2
	
	li $v0, 1 #print integer service, it prints the integer stored at register $a0
	syscall
	
	#exit	
	li $v0, 10
	syscall
