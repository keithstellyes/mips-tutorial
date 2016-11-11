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
# This program gets two integers, then prints if equal

.data
	a:      .word 0
	b:      .word 0
	givea:  .asciiz "Integer A:"
	giveb:  .asciiz "Integer B:"
	neqstr: .asciiz "Integers not equal.\n"
	eqstr:  .asciiz "Integers are equal.\n"
	
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
	syscall
	
	li $v0, 5   #read integer service.
	syscall
	
	lw $a0, a
	beq $a0, $v0, equals # if not equals, then it just goes to next line.
	
	la $a0, neqstr #If we get here, then A != B
	j printandexit #without this jump, we would also execute the equals procedure
equals: #Sets the string-to-print as the output for A==B
	la $a0, eqstr
	j printandexit #We could delete this

printandexit: # Prints whatever is in $a0 then exits.
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	 	