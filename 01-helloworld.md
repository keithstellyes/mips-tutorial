#PART 1: Hello, World!

##Taking the plunge

Let's get our very first Hello, World! program!

Just this once, I'll throw the raw source code for you to appreciate.

    .data
    
    hello:  .asciiz "Hello, World!\n"

    .text
        la $a0, hello
        li $v0, 4
        syscall
        li
        syscall

##Explanation line-by-line

We'll need to declare a few places in memory for our data. Well, we only need
one place this time. The lines beginning with . are mainly for the assembler to
organize the parts of the program for us. A part for "variable declarations", a
part for our actual code, etc.   ``.data`` is for where we will pre-define
different variables in memory.

    .data

Now that we've marked where we're gonna store our data. Here, we declare a 
place in memory for a null-terminated string, ``"Hello, World!\n"`` the \n is
the newline character. The ``hello:`` is a label for this place in memory.

    hello:  .asciiz "Hello, World!\n"

Let's mark the section where we'll start making legitimate instructions.

    .text

Let's store our string into a register, we need to load the address of our
string into the``$a0`` register. This is the register that the print service
takes its argument from. The instruction to do this is ``la``. ``la`` means
"Load address", this loads the address we labelled hello into ``$a0``.

    la $a0, hello

So now that we have our string in the register, ready to be used as an argument
for the print string service, we need to actually *specify* this service. A
table with all the different services and their numbers can be found 
[here](http://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html).
The specific service that is executed is determined by the value in the
register ``$v0``. The print string service is ``4``. We have a specific
instruction that will set an exact value into this register, ``li``, which is
"Load immediate". It is very similar to the instruction above. (In fact, they
can be interchangable in some cases, but it's not recommended to think of them
this way, for readability.) This instruction is when we have a specific value
in our code, usually a literal like below. Effectively, we are doing
``$v0 = 4``.

    li $v0, 4

Now that we've actually set the instruction, we need to actually use the
``syscall`` instruction to use a system service. It'll check the arguments in
the various registers that the specific service, and execute accordingly. This
service we're using only takes an argument at ``$v0`` which shall contain the
address of our string.

    syscall

Now, we've printed "Hello, World!", we could theoretically just stop here. But,
the best practice in software is that we exit with an exit signal 0, exit
success. This will be a system service like last time, just making a call to
exit, marking a succesful run. This is like ``return 0`` in C. Most languages
automatically do this for you.

    li $v0, 10

And then now that we've specified our service, we make our system call, and we
are good.

    syscall

##Source
Here's the source code with comments.

    .data

    hello:	.asciiz "Hello, World!\n"

    .text

	    la $a0, hello  #argument to print str
	    li $v0, 4      #print syscall
	    syscall        #make syscall
	    li $v0, 10     #exit syscall
	    syscall        #tell OS to do the syscall

##Wrap-up

``li`` means "Load immediate" and ``la`` means "Load address". ``li`` is for
when we have a specific number, a literal as it is called in other languages,
to put into the spot in memory. Whereas ``la`` will load into it an address.

A typical program will declare a few spots in memory for variables pre-hand in
the ``.data`` section, and the actual instructions proper in ``.text``.

Most I/O will be done with syscalls that take their arguments in specific
registers like ``$a0``.
