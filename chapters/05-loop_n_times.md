<!-- Part 5 -->
#Part 5: Loop N Times

This time, we will write a simple program, that when given an integer, it will
print that many times, each time doing a "countdown". We can easily combine
the conditional branching we used in Part 4 here, but with a bit of modification.

##Walking through it

Our ``.data`` this time isn't going to be super interesting. Let's just have 3
different strings: One for when we ask for input, one to say that we're done,
and one that is just a newline character. This is desirable because the service
to print an integer does not automatically append a newline.

    .data
	    newline: .asciiz "\n"
	    inputstr: .asciiz "How many times to loop?\n"
	    donestr: .asciiz "No more times to loop :'(\n"

Let's ask for an integer, and store it. We've done this a lot already.

    .text 
	    la $a0, inputstr #Load string
	    li $v0, 4     #Set syscall to print string
	    syscall
	
	    li $v0, 5    #read integer service. Integer returned in $v0
	    syscall

Here's where we diverge. Both the print string and print integer services take
their argument in ``$a0``, so we will have to find a safe place for our
integer. This time, we'll just store it in a register that won't get modified.
This specific implementation and set-up we can treat a register as a safe place
for holding data, but in many architectures and systems, calling a system
service or C function makes no guarantees about preserving your registers. So
don't make that mistake like I did when you go to other assembly architectures.
We will use the ``$v1`` register, if for no reason other than to be arbitrary.
Again, holding data in registers between system calls is discouraged at best,
and simply won't work or break things at worst. But here, it'll let us focus
on other core assembly concepts. We will use the ``move`` instruction to do
this.

    move $v1, $v0

So now, let's begin the loop. Since we know we need a conditional at the start
and to jump back, we will need a label and our conditional. We will call our
post-loop code, ``alldone``. The condition will branch when our integer hits 0.

    loop:	
	    beqz $v1, alldone

Okay, now that we have implemented our condition, let's print our integer. The
print integer service is 1, and takes the argument in ``$a0``. It does not
do a newline after, which is important to remember if we want clean output. We
will have to set the system call, copy from our ``$v1`` register storing our
counter, to the ``$a0`` to be used as an argument. We use the ``move``
instruction for this. Finally, we make our syscall.

    li $v0, 1
	move $a0, $v1
	syscall

As previously stated, we still have to print our newline to ensure clean
output, so let's do that. We're just printing it as a string, nothing special.

	la $a0, newline
	li $v0, 4
	syscall

Now that we've printed our counter, let's decrement it. Many architectures
(such as x86-64, found in most personal computers) have a ``dec`` instruction
for just this, lowering it by 1. Here, we do not, we must subtract it by 1.

	subi $v1, $v1, 1

And then, we jump back to the beginning of the loop.

	j loop

Now that our loop is finished, we can write the final ``alldone`` segment.
This is just printing the ``donestr`` string and exiting. Very boilerplate.
We'll also need to set it to the ``alldone`` label.

    alldone:
	    la $a0, donestr
	    li $v0, 4
	    syscall
	    li $v0, 10
	    syscall

##Source

Note that I've done a bit of additional indentation for readability.

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

##Wrap-up
Using a branch and an unconditional jump at both the beginning and end of a
segment of code, we can implement looping structures as we see in normal
programming languages.
