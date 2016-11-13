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
# This loop counts down for 99 Bottles of Beer on the Wall.

.data 
	lyrica: .asciiz " bottles of beer on the wall, "
	lyricb: .asciiz " bottles of beer.\nTake one down and pass it around, "
	lyricc: .asciiz " bottles of beer on the wall.\n\n"
	
	concl1: .asciiz "2 bottles of beer on the wall, 2 bottles of beer.\n"
	concl2: .asciiz "Take one down and pass it around, 1 bottle of beer on the wall.\n\n"
	concl3: .asciiz "1 bottle of beer on the wall, 1 bottle of beer.\n"
	concl4: .asciiz "Take one down and pass it around, no more bottles of beer on the wall.\n\n"
	concl5: .asciiz "No more bottles of beer on the wall, no more bottles of beer.\n"
	concl6: .asciiz "Go to the store and buy some more, 99 bottles of beer on the wall."
	
.text
	li $a1, 99
	# loop for 99 -> 3
loop:
	beq $a1, 2, concl #condition
	move $a0, $a1     #copy counter for use in printing
	li $v0, 1
	syscall
	
	la $a0, lyrica    #next part of the lyrics to print
	li $v0, 4
	syscall
	move $a0, $a1     #print counter again...
	li $v0, 1
	syscall
	
	la $a0, lyricb    #next part of the lyrics to print
	li $v0, 4
	syscall
	
	subi $a1, $a1, 1  #decrement counter and print
	move $a0, $a1
	li $v0, 1
	syscall
	la $a0, lyricc    #print final part
	li $v0, 4
	syscall
	j loop

concl:
	#Printing final string.
	la $a0, concl1
	li $v0, 4
	syscall
	la $a0, concl2
	syscall
	la $a0, concl3
	syscall
	la $a0, concl4
	syscall
	la $a0, concl5
	syscall
	la $a0, concl6
	syscall
	
	li $v0, 10
	syscall