.SUFFIXES: .png .pdf .tex

TEXS = dag.uml.tex inschrijving.uml.tex kind.uml.tex verblijf.uml.tex
PDFS = $(TEX:tex=pdf)
PNGS = $(TEX:tex=png)

all: $(PDFS) $(PNGS)

.pdf.png:
	convert -quality 90 -density 300 -trim $** $@

.tex.pdf:
	pdflatex $**

clean:
	del *~
	del *.aux
	del *.pdf
	del *.png
	del *.log

