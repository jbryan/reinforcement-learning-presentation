#----------------------------------------------------------------------------
# General make file for building latex documents.
#----------------------------------------------------------------------------

#.PHONY: tex_clean tex_pristine

bibtex		= bibtex
make		= make
pdflatex	= pdflatex -halt-on-error

#----------------------------------------------------------------------------

%.aux:	%.tex
	$(pdflatex) $*

%.bbl:	%.aux %.bib
	$(bibtex) $*

%.pdf:	%.bbl
	$(pdflatex) $*
	$(pdflatex) $*
	$(make) -f latex/latex.mk tex_clean

%.eps: %.dia
	dia -e $@ -t eps-builtin -n $<

$(figures): %.pdf: %.eps
	epstopdf --outfile=$@ $<

tex_pristine:	tex_clean
	-rm *.eps
	-rm *.pdf

tex_clean:
	-rm *.aux
	-rm *.bbl
	-rm *.blg
	-rm *.log
	-rm *.nav
	-rm *.out
	-rm *.snm
	-rm *.sxw
	-rm *.toc

#----------------------------------------------------------------------------

