#Part 3: Echo

Get input from user, then repeat it.
This program will demonstrate allocation of memory and storing strings.

##Walking through it.

This time, we won't bother declaring in variables using ``.data``, and just go
straight to the instructions in ``.text``

    .text

Before we can take a string input, we need to make sure there is a place for it
in memory. That is to say, we will be *allocating*. We'll be doing something
akin to ``malloc`` in C or C++. We'll be using the sbrk system service. It'll
declare a number of bytes and returns its address so that we can store and use
variables in that spot. It will store ``$a0`` number of bytes, and returns its
address in ``$v0``.

	li $a0, 400
	li $v0, 9
	syscall

Next, we'll be using the read string service. It'll store at the address stored
in ``$a0`` and it will only read up to a specific number of bytes, ``$a1``
number of bytes. We need to make sure it doesn't read more bytes than we know
are allocated, otherwise we'll overflow and write to memory we shouldn't be.
Now, so the first step is to move the address of the data we allocated to
``$a0`` so our read string instruction will read to it. To move from register
to register with ``la``, we need to use a () syntax. This is because
frequently, there'll be an offset from that. For now though, we don't have to
worry about that.

    la $a0, ($v0)

Okay, and now let's set the limit on the number of bytes we will read...

    li $a1, 400

Now, if you remember, our memory allocation service only takes two arguments,
in ``$a0`` and in ``$a1``, abd we've already loaded our address in ``$a0`` and
the limit on bytes to read in ``$a1``, so now let's make the call.

    syscall

Now generally, we would have copied the address into memory using ``sw``, and
in other architectures/other implementations, that address would have been lost
if we didn't make a copy elsewhere before we made that last call. MARS is more
forgiving, however. So, the location of our string is still stored at ``$a0``.
And if you remember, our print string argument reads the string at the address
stored at... ``$a0``... So our print string argument is already set, we just
need to specify the service.

    li $v0, 4

And then, print that string.

    syscall

And then like always, we need to exit our program, so let's do that.

    li $v0, 10
	syscall

##Source

    .text
	    li $a0, 500   #allocate 400 bytes
	    li $v0, 9     #set syscall to allocate memory
	    syscall
	
	    la $a0,($v0) #set the target address for the read string 
	    li $a1, 500   #set max number of chars to read 
	    li $v0, 8     #set syscall to read string
	    syscall
	
	    li $v0,4     #set syscall to print string
	    syscall
	
	    li $v0,10    #exit cleanly with EXIT_SUCCESS
	    syscall

##Wrap-up

To allocate a large amount of data, we have to allocate it by using a system
service, and then it will give us the location of where it allocated the
memory where we will then print it.
