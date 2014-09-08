.SECONDEXPANSION:

.PHONY: example example-html example-multimake zip current current-html export

PACKAGE=unnamed
PACKAGE_CONTENTS=khl.js khl.css khluml.sty hint.tex next.tex previous.tex reset.tex reveal.tex verify.tex Controller.rb Generate.rb Generation.rb HTML.rb Java.rb JavaScript.rb Parameters.rb Questions.rb Shared.rb Types.rb makefile .gitignore shared.mk icons.mk jquery.js

all: icons export


-include shared.mk
-include icons.mk

-include example.mk


clean: clean_icons
	rm -f *~

zip:
	$(ZIP) $(PACKAGE).zip $(PACKAGE_CONTENTS)

export:

%.pdf: %.tex
	$(LATEX) $<

%.png: %.pdf
	$(IMAGEMAGICK) -quality 90 -density 300 $< $@


CURRENT = loops

current: current-html

current-html:
	ruby Generate.rb --output $(CURRENT).html --template $(CURRENT).template --require ./$(CURRENT).rb --class Resources -p 2
