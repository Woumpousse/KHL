.SECONDEXPANSION:

.PHONY: current current-html export


all: icons export current


-include shared.mk
-include icons.mk


clean: clean_icons
	rm -f *~

export:

%.pdf: %.tex
	$(LATEX) $<

%.png: %.pdf
	$(IMAGEMAGICK) -quality 90 -density 300 $< $@


CURRENT = counter

current: current-html

current-html:
	ruby Generate.rb --output $(CURRENT).html --template $(CURRENT).template --require ./$(CURRENT).rb --class Resources -p 2
