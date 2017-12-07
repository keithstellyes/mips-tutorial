#sources  := $(wildcard *.md)
main_src  := "mips-tutorial.md"
main_tgt  := "mips-tutorial.html"
pypath    := "python3"
exttoc    := "markdown.extensions.toc"
extinc    := "markdown_include.include"
exttab    := "markdown.extensions.tables"
extcmt    := "mkdcomments"
VAR       :=

IMPORTSTR := "import markdown, markdown.extensions.toc, markdown_include.include, mkdcomments"
PYMODULES := "markdown, markdown.extensions.toc, markdown_include.include, markdown.extensions.tables, mkdcomments"

PY2S := "Succeeded with python2. Using python2 binary."
PY2F := "Failed with python2... testing python3"
PY3S := "Succeed with python3. Using python3 binary."

ERRNOPY := "No Python installed, or the modules not installed. Consult README"
all: clean checkdep compile

clean:
	@echo Cleaning previous HTML files generated && echo
	@$(RM) *.html

#command -v foo >/dev/null 2>&1 || { echo "test" >&2; exit 1;}
#$(eval VAR := 0)
checkdep:
	@echo Testing python2 path...
	@echo Testing for following modules:
	@echo markdown, markdown.extensions.toc, markdown_include.include

	@#What a mess... Tests for Python 2 being on system and for correct
	@#modules, redirecting stderr to /dev/null. If it has python2 and the
	@#modules, then it will exit this monster of a conditional. If one of
	@#those fails, it tries the same with Python 3.
	@python2 -c $(IMPORTSTR) 2> /dev/null && echo $(PY2S) &&\
	 : $(eval pypath := python2) || echo $(PY2F) && python3 -c $(IMPORTSTR)\
	 2> /dev/null && echo $(PY3S) && : $(eval pypath := python3)

	@echo Python binary to use: $(pypath)
#markdowntohtml:
#	@echo Calling markdown module on each .md file
#	@for src in $(sources) ; do \
#		 $(pypath) -m markdown $$src -x $(extinc) -x $(exttoc) > \
#		 $${src%.md}.html; \
#	done

compile:
	@echo && echo --Compiling Markdown to HTML--
	$(pypath) -m markdown $(main_src) -x $(extcmt) -x $(extinc) -x $(exttoc) > $(main_tgt) -x $(exttab)
	@echo && echo Wrote to: $(main_tgt)
