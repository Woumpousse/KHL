.SUFFIXES: .png .pdf .tex

TEXS = dag.uml.tex inschrijving.uml.tex kind.uml.tex verblijf.uml.tex
PDFS = $(TEXS:tex=pdf)
PNGS = $(TEXS:tex=png)

all: opgave.zip

opgave.zip: figures
	7z a opgave.zip *.css *.hmtl *.js *.png

figures: $(PDFS) $(PNGS)

.pdf.png:
	convert -quality 90 -density 300 -trim $** $@

.tex.pdf:
	pdflatex $**

clean:
	del *~ *.aux *.pdf *.png *.log opgave.zip
