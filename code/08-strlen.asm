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
# This will take a string from a user, then print out its length.

.data 
	string: .asciiz "Beware of bugs in the above code; I have only proved it correct, not tried it - Donald Knuth"
	thelengthisa: .asciiz "The length of the string,'"
	thelengthisb: .asciiz "' is "
	thelengthisc: .asciiz " characters.\n"
.text
	#print inital...
	la $a0, thelengthisa
	li $v0, 4
	syscall
	la $a0, string
	syscall
	la $a0, thelengthisb
	syscall

	# load a pointer to the string.
	la $a1, string
	li $a0, 0
loop:
	# get the character at pointer
	lb $a2, ($a1)
	# increment pointer
	addi $a1, $a1, 1
	# test for character at pointer being null terminator. If so, exit loop.
	beqz $a2, exit
	# increment counter
	addi $a0, $a0, 1
	# return to head of loop.
	j loop
	
exit:
	# print count
	li $v0, 1
	syscall
	# print final strings, exit syscall.
	li $v0, 4
	la $a0, thelengthisc
	syscall