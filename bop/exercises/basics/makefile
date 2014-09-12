.SECONDEXPANSION:

.PHONY: current current-html export


all: icons export current


-include shared.mk
-include icons.mk


clean: clean_icons
	rm -f *~

zip:
	$(ZIP) $(PACKAGE).zip $(PACKAGE_CONTENTS)

export:
	echo *.css *.png basics.html *.js | ruby -e "puts STDIN.read.split" > export


%.pdf: %.tex
	$(LATEX) $<

%.png: %.pdf
	$(IMAGEMAGICK) -quality 90 -density 300 $< $@


CURRENT = basics

current: current-html

current-html:
	ruby Generate.rb --output $(CURRENT).html --template $(CURRENT).template --require ./$(CURRENT).rb --class Resources -p 2
