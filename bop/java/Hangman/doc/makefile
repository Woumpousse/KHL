CONVERT = convert.exe
IMAGE_OPTIONS = -quality 90 -density 300 -trim
ICON_OPTIONS = -quality 90 -density 100 -trim -bordercolor white -border 10x10 -transparent white
CONVERT_IMAGE = $(CONVERT) $(IMAGE_OPTIONS)
CONVERT_ICON = $(CONVERT) $(ICON_OPTIONS)
LATEX = pdflatex


all: assignment.html

assignment.html: assignment-template.html *.rb figures
	ruby Generate.rb html > assignment.html

figures: game-design.png guess-figures button-figures

game-design.png: game-design.pdf
	$(CONVERT_IMAGE) $< $@

game-design.pdf : game-design.tex
	$(LATEX) $<

guess-figures: guess.tex
	$(LATEX) guess.tex
	$(CONVERT_IMAGE) guess.pdf guess-%d.png

button-figures: hint.png verify.png next.png previous.png reveal.png reset.png

hint.pdf: hint.tex
	pdflatex hint.tex

verify.pdf: verify.tex
	pdflatex verify.tex

next.pdf: next.tex
	pdflatex next.tex

previous.pdf: previous.tex
	pdflatex previous.tex

reveal.pdf: reveal.tex
	pdflatex reveal.tex

reset.pdf: reset.tex
	pdflatex reset.tex

hint.png: hint.pdf
	$(CONVERT_ICON) hint.pdf hint.png

verify.png: verify.pdf
	$(CONVERT_ICON) verify.pdf verify.png

next.png: next.pdf
	$(CONVERT_ICON) next.pdf next.png

previous.png: previous.pdf
	$(CONVERT_ICON) previous.pdf previous.png

reveal.png: reveal.pdf
	$(CONVERT_ICON) reveal.pdf reveal.png

reset.png: reset.pdf
	$(CONVERT_ICON) reset.pdf reset.png

clean:
	rm -f *~ *.aux *.pdf *.png *.log
