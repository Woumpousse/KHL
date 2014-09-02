.SECONDEXPANSION:

.PHONY: example example-html example-multimake zip current current-html

PACKAGE=unnamed
PACKAGE_CONTENTS=khl.js khl.css khluml.sty hint.tex next.tex previous.tex reset.tex reveal.tex verify.tex Controller.rb Generate.rb Generation.rb HTML.rb Java.rb JavaScript.rb Parameters.rb Questions.rb Shared.rb Types.rb makefile .gitignore shared.mk icons.mk

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

current: current-html train.png references.png train-creation.png reclength.png detach.png nth.png last.png join.png keepWagons2.png keepWagons10.png takeWagonCapacity.png

current-html:
	ruby Generate.rb --output train.html --template train.template --require ./train.rb --class Train -p 2
