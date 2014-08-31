all: conditionals.pdf

conditionals.pdf: *.js *.tex
	pdflatex conditionals.tex
	pdflatex conditionals.tex

clean:
	rm -f *~ *.aux *.toc *.snm conditionals.pdf *.log *.out *.nav
