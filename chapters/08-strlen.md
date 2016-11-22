<!-- Part 8 -->

#Part 8: Getting String Length

We will write a program that demonstrates getting the length of a string.

## Walking through it

Strings here are an array of characters, with a final character, the null
character, with the underlying number of "0", it is also known as the null
terminator. These strings are known as _null-terminated strings_.

First, let's declare our variables...

    .data 
	    string: .asciiz "Beware of bugs in the above code; I have only proved it correct, not tried it - Donald Knuth"
	    thelengthisa: .asciiz "The length of the string,'"
	    thelengthisb: .asciiz "' is "
	    thelengthisc: .asciiz " characters.\n"

And then, let's do our printing:

    .text
	    la $a0, thelengthisa
	    li $v0, 4
	    syscall
	    la $a0, string
	    syscall
	    la $a0, thelengthisb
	    syscall

Okay, now it is time to start the logic we're intererested in. First of all,
we must load the address of the string we want to get the length of. We will
store the address in ``$a1``. Remember, an address is just another number, one
that we can increment. What is called the address of a string is really just
the address of the inital character. The second character is that address + 1.
The very last character is followed by the null terminator with ASCII value of
0. So, let's clear ``$a0``, and load that address.

	la $a1, string
	li $a0, 0

And now that we have initalized everything, it is time for the loop. Basically,
we will have a loop checking every character in the string, and when the
character is not the null terminator, we increment the counter. When it is the
null terminator, we will exit the loop. For the first part of the loop, we must
load the character at the address. We will use ``lb``, meaning load byte. The
( ) notation on the second argument means it will take the value at ``$a2``,
then go to that address in memory. Basically, it asssumes ``$a2`` has a pointer
to the value we _really_ want. In this case, the character.

    loop:
	    lb $a2, ($a1)

Now that we've loaded the character, let's increment our pointer.

	addi $a1, $a1, 1

Now, let's see if that last character was a null terminator, if so, exit the
loop.

	beqz $a2, exit

Else, let's increment the counter, then go back to the head of the loop.

	addi $a0, $a0, 1
	j loop

And finally, we'll write our exit code. We print out our counter, the final
string, then make the exit ``syscall``.

    exit:
	    li $v0, 1
	    syscall
	    li $v0, 4
	    la $a0, thelengthisc
	    syscall

##Source

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

##Wrap-up

To do various operations on strings/lists/arrays/similar data structures, it
is imperative to use pointer arithmetic as we did in this example. 
