.SUFFIXES: .png .pdf .tex

CONVERT = convert.exe
LATEX = pdflatex

TEXS = dag.uml.tex inschrijving.uml.tex kind.uml.tex verblijf.uml.tex
PDFS = $(TEXS:tex=pdf)
PNGS = $(TEXS:tex=png)

all: figures

figures: $(PDFS) $(PNGS)

%.png : %.pdf
	$(CONVERT) -quality 90 -density 300 -trim $< $@

%.pdf : %.tex
	$(LATEX) $<

clean:
	rm -f *~ *.aux *.pdf *.png *.log
