# mips-tutorial
A repo for the contents of a MIPS tutorial using Markdown &amp; a makefile to """compile""" it using a Python markdown module and a few plugins.

I am hosting a copy of this tutorial on my personal website:

www.keithstellyes.com/tutorials/mips

It may be a bit behind.

# Dependencies

* Python (2.x or 3.x)

* ``make`` (If you're on Linux or Mac or BSD you should be fine, if 
you're 
on Windows, if you do not have ``make``: install ``make`` using Cygwin.

* [markdown module](https://pypi.python.org/pypi/Markdown)

Various third party markdown modules...

* [mkdcomments](https://github.com/ryneeverett/python-markdown-comments)

* [Markdown-Include](https://github.com/cmacmackin/markdown-include)

# Building

To build the resulting HTML file, simply use ``make all``, and the result will
be in ``mips-tutorial.html``. In the future there should be more build targets
and options.
