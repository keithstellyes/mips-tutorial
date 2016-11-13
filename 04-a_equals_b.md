#Part 4: A == B

Get two integers from the user, state if they're equal or not.

##Walking through it

So, if you've done the Part 2, A+B, then the beginning of this part should
look pretty familiar. First, let's declare spots in memory for our data.

    .data
	    a:      .word 0
	    b:      .word 0
	    givea:  .asciiz "Integer A:"
	    giveb:  .asciiz "Integer B:"
	    neqstr: .asciiz "Integers not equal.\n"
	    eqstr:  .asciiz "Integers are equal.\n"

Let's read our first integer A, this is pretty much copy-pasted from Part 2.

    .text
	    # Read integer a
	    la $a0, givea
	    li $v0, 4
	    syscall
	    li $v0, 5
	    syscall
	    sw $v0, a

Let's get the second integer B, this one is going to be slightly different from
last time.

	la $a0, giveb
	li $v0, 4
	syscall
	
	li $v0, 5   #read integer service.
	syscall

Our integer B is in ``$v0``, last time we stored it in memory. This time we
wont'. But we still need to do our comparison operation, and have to do it on
our registers, so let's load A.

	lw $a0, a

And now, we need to compare the values. At the low-level, we need to use
*branching*. To do branching, we will make a comparison, and then depending
on that result, either: Jump to a specified label or: nothing. In this case,
we will use ``beq``, given two arguments, it will jump to a label if its two
register arguments are equal. Otherwise, nothing happens. Let's call this label
``equals``.

    beq $a0, $v0, equals

We haven't actually made our ``equals`` label yet, between the ``equals`` label
and that last line, we need to put our code we want to execute, that is, the if
they're not equal. Since both equals and not equals cases will print, we don't
need to put it in our not equals section, so all we need to do between our
``equals`` section and right here, is to load the string and jump to our
procedure for print and exit. We have the ``j`` instruction that will always
go to a specific label.

	la $a0, neqstr
	j printandexit

Okay, now, we have our not equals, so let's make our equals section. We'll
first need a label. You'll notice this is the same syntax as when we mark spots
in memory for our data, this is no coincidence, since instructions are in
memory just like our data.

    equals:

And then, let's do our similar procedure for equals.

    la $a0, eqstr
    j printandexit

Let's make our final procedure, printandexit. We will print whatever string is
in ``$a0``, which we would've already dealt with loading.

    printandexit:
	    li $v0, 4
	    syscall
	    li $v0, 10
	    syscall

##Source

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
	    j printandexit #We could delete this and "fall through"

    printandexit: # Prints whatever is in $a0 then exits.
	    li $v0, 4
	    syscall
	    li $v0, 10
	    syscall

##Wrap-up

Branching and jump instructions are fundamental to only conditionally executing
code. Now, there is a special type of branching instruction that will let us
have true procedures, those that can have recursion, but here it's not
necessary. Forgetting jump or branch instructions before your sections can lead
to code blocks you don't want executing. Be careful.
