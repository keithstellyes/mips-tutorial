<!-- Part 2 -->
#Part 2: A+B

This will be a simple enough program. Get two integers, then print their sum.

##Walking through it.

First, we declare a spot in memory to store our integers, and for our 
strings to display when we want user input. ``.word`` refers to the amount of
data we can address at a time, this is the size of a spot in memory like a
register. This is a bit more of a complicated thing that I'm letting on, but
this is "good enough" for our purposes here. It is a 32 bit integer. 4 bytes.
Neat. And after that data declaration, we'll output to user telling them to
give us an integer.

    .data
	    a:.word 0
	    b:.word 0
	    givea: .asciiz "A:"
	    giveb: .asciiz "B:"

    .text
	    la $a0, givea #Load string
	    li $v0, 4     #Set syscall to print string
	    syscall

Let's read an integer from the user. To do that, we'll be doing another syscall
specifically, 5, and the result is returned in ``$v0``.

	li $v0, 5    #read integer service. Integer returned in $v0
	syscall

Let's go ahead and store the result into memory. Generally speaking, storing
data into registers is risky. This is because external function calls and
system services do not make the guarantee that registers will be preserved
after its call. In MARS MIPS, this isn't necessary. So, for demonstration
purposes, we'll just store it in the register. We'll be using the
instruction ``sw`` that stores the ``word`` in the first argument, which is a
register, into the second argument, a place in memory.

    sw $v0, a

Let's do the same process, but for ``b``...

	la $a0, giveb
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	sw $v0, b

Our words are stored in memory, we have both of them, so let's put them into
our registers so we can use them in a math operation. The first loads the value
at ``a`` into ``$a0``, the second loading the value at ``b`` into ``$a1``.

	lw $a0, a
	lw $a1, b

So, we have both of our integers (*words*) in our registers. If you remember,
I said that we can only do math on the values currently in the registers. 
The ``add`` instruction stores the results of the last 2 arguments,
into the first. For ``add x y z``, ``x`` will store the results of ``y + z``.

    add $a0, $a0, $a1

And now that we have our math, we'll be using the print integer service, which
is syscall \#1. It prints the current integer stored at ``$a0`` which we
cleverly already stored the results in from the last operation. This is is
where I find assembly programming to be most enjoyable, slight little
improvements in your code like that.

	li $v0, 1 
	syscall

And then, for the farewell, the good old ``syscall`` saying we've had no
issues and time to exit.

	li $v0, 10
	syscall

##Source

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
	    syscall
	
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

##Wrap-up

Often-times we need to get used to moving data around by storing them in
memory with instructions like ``sw`` and math instructions will store
a register with the sum of two registers.
