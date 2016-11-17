#Part 6: 99 Bottles of Beer

We will write a program that counts down, generating the lyrics for the song,
*99 Bottles of Beer on the Wall* (lyrics 
[here](http://www.99-bottles-of-beer.net/lyrics.html))
No new real new concepts, just a bit of practice.

##Walking through it

First let's declare our strings we call for 3 <= n <= 99.

    .data 
	    lyrica: .asciiz " bottles of beer on the wall, "
	    lyricb: .asciiz " bottles of beer.\nTake one down and pass it around, "
	    lyricc: .asciiz " bottles of beer on the wall.\n\n"

Now, we also have to remember, when 3 > n, that the printing behavior is
not the same. For 3 > n, I'm just going to do a string constant, if you want
it to actually be printing the integer for even the last part, consider it
your challenge. Here, I split them into multiple variables for readability,
but if you want just one super long line, go ahead.

	concl1: .asciiz "2 bottles of beer on the wall, 2 bottles of beer.\n"
	concl2: .asciiz "Take one down and pass it around, 1 bottle of beer on the wall.\n\n"
	concl3: .asciiz "1 bottle of beer on the wall, 1 bottle of beer.\n"
	concl4: .asciiz "Take one down and pass it around, no more bottles of beer on the wall.\n\n"
	concl5: .asciiz "No more bottles of beer on the wall, no more bottles of beer.\n"
	concl6: .asciiz "Go to the store and buy some more, 99 bottles of beer on the wall."

Now, let's initalize our counter. I'm just going to store it in the register
``$a1``, as I've stated already, this isn't best practice.

    .text
	    li $a1, 99

Now, we're just going to do a loop for this. Where do you think the loop
should terminate? If you remember, the standard behavior ends when n is less
than 3. So, let's terminate when n == 2. Of course, don't forget the label to
jump back to. Let's just call the final block of code printing the final string
and exiting, ``concl``.

    loop:
	    beq $a1, 2, concl

If you remember how our print integer works, it prints only the number, no
whitespace or anything. So first, we must move our counter to ``$a0`` and 
use the print integer service.

	move $a0, $a1
	li $v0, 1
	syscall

And then, we will print the first part of the lyric.

	la $a0, lyrica
	li $v0, 4
	syscall

And then, if you reference the lyrics, you'll realize after here, we print our
counter again, so let's do just that.

	move $a0, $a1
	li $v0, 1
	syscall

And then we print the second part of the lyrics, using ``lyricb``...

	la $a0, lyricb
	li $v0, 4
	syscall

Okay, now we get back to the fun part. So now, if you look at the lyrics,
you should notice here, the counter decrements. Well, we already know how to
do that, right? So let's do just that.

	subi $a1, $a1, 1

Cool, and then we print our integer, and the last part of the lyric.

	move $a0, $a1
	li $v0, 1
	syscall
	la $a0, lyricc
	li $v0, 4
	syscall

And now that the loop is done, we need to add our final jump.

	j loop

Now, we will do our conclusion. We're just printing a series of strings.
Nothing much. Of course, we still need our label, ``concl``. After, we will
exit.

    concl:
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

##Source

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

##Wrap-up

Not much to say in the wrap-up this time. Remember to experiment with
different instructions to get comfortable with MIPS.
