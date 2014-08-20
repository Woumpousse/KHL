.SUFFIXES: .png .pdf .tex

CONVERT = convert
LATEX = pdflatex

TEXS = uml.tex
PDFS = $(TEXS:tex=pdf)
PNGS = $(TEXS:tex=png)

all: figures export

figures: $(PDFS) $(PNGS)

%.png : %.pdf
	$(CONVERT) -quality 90 -density 300 -trim $< $@

%.pdf : %.tex
	$(LATEX) $<

clean:
	rm -f *~ *.aux *.pdf *.png *.log export

export:
	echo *.css *.png assignment.html *.js | ruby -e "puts STDIN.read.split" > export
