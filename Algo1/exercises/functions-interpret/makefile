.SECONDEXPANSION:

.PHONY: example example-html example-multimake zip current current-html export

all: icons export current


-include shared.mk
-include icons.mk


clean: clean_icons
	rm -f *~

export:
	echo loops.html *.js *.png *.css | ruby -e "puts STDIN.read.split" > export

%.pdf: %.tex
	$(LATEX) $<

%.png: %.pdf
	$(IMAGEMAGICK) -quality 90 -density 300 $< $@


CURRENT = functions

current: current-html

current-html:
	ruby Generate.rb --output $(CURRENT).html --template $(CURRENT).template --require ./$(CURRENT).rb --class Resources -p 2
