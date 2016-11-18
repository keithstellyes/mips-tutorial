<!-- Part 7 -->

# Part 7: Guess the Number

We will write a program that will randomly generate a number ``n`` and then
repeatedly ask for integer input until the input is equal to ``n``. The program
will also state if ``n`` is greater than or less than the integer input.

## Walking through it

This time, we will not store our number in a register, but instead in a
place in memory, as is ideal. All random generators have an *id*, don't 
forget.
First, let's declare our initial data...

    .data
	    toosmallstr:  .asciiz "n is greater than input.\n"
	    toobigstr:    .asciiz "n is lesser than input.\n"
	    correctstr:   .asciiz "n is equal to input.\n"
        makeguessstr:.asciiz "Make a guess:"
        n:         .word   0
        randgenid: .word   1

We will be using a ``syscall`` that will generate a pseudorandom number. If we
go back to the``syscall`` chart
[here](http://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
we see that we have ``syscall 42``. This generates a random number
0 <= n < [upperbound]
It requires us to set a *seed*. Typically, a pseudorandom number generator will
use the system time for this. For this, we have ``syscall 30``. So first, let's
get the time to use for our seed.

    .text
	    li $v0, 30
	    syscall

We have the time stored. Look at the table, you'll see we 
have both
low-order time in ``$a0`` and high-order in ``$a1``. For our purposes, we will
use high-order time for our purposes. Before we can use our random number
generator, we must first set the seed. The number we are going to use as our
seed is in ``$a1`` ``syscall 40`` is there to set the seed of our random number
generator, so let's move our desired seed in ``$a0`` into ``$a1`` and then make
the ``syscall 40`` to set the low-order time as our seed. Also, we need to make
sure we are using the correct random generator id, so let's set that too.

	move $a1, $a0
    lw $a0, randgenid
	li $v0,40
	syscall

Now that our random number generator is ready, we can actually use the
generator. It sets its upper bound in ``$a1``, now if you remember, it will
generate a number in the range of 0 - (``$a1`` - 1) so we can set the upper
bound to 10, and then increment to get a number in the range of 1-10.

	li $a1,10
	li $v0,42
	syscall

We now have our random number generated, but it is 1 less than it should be.
Also, it still needs to be stored in the memory location ``n``. So let's 
add 1 to it, then store
it.

	add $a0, $a0, 1
	sw $a0, n

Our number is stored and ready, so now we can start our loop. First, we will
need to get a value. We'll do this every iteration of the loop, so let's have
the label, too.

    loop:
	    la $a0, makeguessstr
	    li $v0, 4
	    syscall
	    li $v0, 5
	    syscall

We have our integer in ``v0``, so let's see if they were correct. Our
generated number is stored in ``n``, so we have to get that before we make
our comparison. We'll call our final code called when user correctly guesses
the number, ``done``.

	lw $a0, n
	beq $a0, $v0, done

We have our branch for a correct guess, let's do the branch for if the user
inputs a number greater than the generated number ``n``.

	blt $a0, $v0, toobig

And of course, we need the final condition for if the user's number is too
small. We've already tested for too great, and equal, so if this part of the
instructions is reached, then we don't have to do a comparison to know 
the input
is too small, so we can use a simple jump.

	j toosmall

Let's write those referenced sections of code. Let's write the 
``toobig``
section. It just needs to print out the number was too big, and then go back
to the beginning of the loop.

    toobig:
	    la $a0, toobigstr
	    li $v0, 4
	    syscall
	    j loop

Same thing again, but for the number ``n`` being too small.

    toosmall:
	    la $a0, toosmallstr
	    li $v0, 4
	    syscall
	    j loop

And then, our ``done`` section is just printing out a string and exiting.
Simple.

    done:
	    la $a0, correctstr
	    li $v0, 4
	    syscall
	    li $v0, 10
	    syscall

##Source

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

##Wrap-up

Making extensive use of sub-procedures as used here can be quite useful as
your code increases in complexity.

