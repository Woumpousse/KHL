.SECONDEXPANSION:

.PHONY: export

CONVERT = convert
IMAGE_OPTIONS = -quality 90 -density 300 -trim
ICON_OPTIONS = -quality 90 -density 100 -trim -bordercolor white -border 10x10 -transparent white
CONVERT_IMAGE = $(CONVERT) $(IMAGE_OPTIONS)
CONVERT_ICON = $(CONVERT) $(ICON_OPTIONS)
LATEX = pdflatex


all: assignment.html export

assignment.html: assignment-template.html *.rb figures
	ruby Generate.rb html > assignment.html

figures: game-design.png guess-figures button-figures

game-design.png: game-design.pdf
	$(CONVERT_IMAGE) $< $@

game-design.pdf : game-design.tex
	$(LATEX) $<

guess-figures: guess.tex
	$(LATEX) guess.tex
	$(CONVERT_IMAGE) -shave 3x3 guess.pdf guess-%d.png

button-figures: hint.png verify.png next.png previous.png reveal.png reset.png

hint.pdf verify.pdf next.pdf previous.pdf reveal.pdf reset.pdf: $$(subst pdf,tex,$$@)
	$(LATEX) $<

hint.png verify.png next.png previous.png reveal.png reset.png: $$(subst png,pdf,$$@)
	$(CONVERT_ICON) $< $@

clean:
	rm -f *~ *.aux *.pdf *.png *.log export

export:
	echo *.css *.png assignment.html *.js | ruby -e "puts STDIN.read.split" > export
