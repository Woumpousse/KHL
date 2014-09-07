all: functions.pdf

functions.pdf: *.tex
	pdflatex functions.tex
	pdflatex functions.tex

clean:
	rm -f *~ *.aux *.toc *.snm functions.pdf *.log *.out *.nav
