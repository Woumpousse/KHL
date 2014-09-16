.SECONDEXPANSION:

.PHONY: export

-include ../zip.mk
-include ../ssh.mk

ZIP_FILE = doc.zip
REMOTE_DIRECTORY = $(ROOT_REMOTE_DIRECTORY)/exercises/Hangman/



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

zip: assignment.html
	ruby exports.rb . | dos2unix | xargs $(ZIP) $(ZIP_FILE)

upload: zip
	$(call UPLOAD,$(ZIP_FILE),$(REMOTE_DIRECTORY))
	$(SSH) $(LOGIN)@$(URL) "cd $(REMOTE_DIRECTORY); unzip -o $(ZIP_FILE)"
