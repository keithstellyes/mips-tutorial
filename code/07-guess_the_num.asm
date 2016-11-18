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
# This will randomly generate a number 1 <= n <= 10

.data
	toosmallstr: .asciiz "n is greater than input.\n"
	toobigstr:   .asciiz "n is lesser than input.\n"
	correctstr:  .asciiz "n is equal to input.\n"
	makeguessstr:.asciiz "Make a guess:"
	n:        .word 0
	randgenid:.word 1

.text
	#get system time
	li $v0, 30
	syscall
	
	#use system time for seed
	move $a1, $a0
	lw   $a0, randgenid
	li $v0,40
	syscall
	
	li $a1,10
	li $v0,42
	syscall
	#our number is 1 less than it should be. Adjust.
	add $a0, $a0, 1
	sw $a0, n

loop:
	#print the make guess string and get integer.
	la $a0, makeguessstr
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	
	#store our integer.
	lw $a0, n
	#n == input?
	beq $a0, $v0, done
	#n < input?
	blt $a0, $v0, toobig
	#n > input.
	j toosmall
	
toobig:
	la $a0, toobigstr
	li $v0, 4
	syscall
	j loop
	
toosmall:
	la $a0, toosmallstr
	li $v0, 4
	syscall
	j loop
	
done:
	la $a0, correctstr
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	