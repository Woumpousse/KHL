.SUFFIXES: .png .pdf .tex

ZIP = 7z
CONVERT = "C:\Program Files (x86)\ImageMagick-6.8.6-Q16\convert.exe"
LATEX = pdflatex

TEXS = dag.uml.tex inschrijving.uml.tex kind.uml.tex verblijf.uml.tex
PDFS = $(TEXS:tex=pdf)
PNGS = $(TEXS:tex=png)

all: opgave.zip

opgave.zip: figures
	$(ZIP) a opgave.zip *.css *.hmtl *.js *.png

figures: $(PDFS) $(PNGS)

%.png : %.pdf
	$(CONVERT) -quality 90 -density 300 -trim $< $@

%.pdf : %.tex
	$(LATEX) $<

clean:
	del *~ *.aux *.pdf *.png *.log opgave.zip

