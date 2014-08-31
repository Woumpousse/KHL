all: random.pdf

random.pdf: *.js *.tex
	pdflatex random.tex
	pdflatex random.tex

clean:
	rm -f *~ *.aux *.toc *.snm random.pdf *.log *.out *.nav
