.SECONDEXPANSION:

.PHONY: example example-html example-multimake zip

PACKAGE=unnamed
PACKAGE_CONTENTS=khl.js khl.css khluml.sty hint.tex next.tex previous.tex reset.tex reveal.tex verify.tex Controller.rb Generate.rb Generation.rb HTML.rb Java.rb JavaScript.rb Parameters.rb Questions.rb Shared.rb Types.rb makefile .gitignore shared.mk icons.mk

all: icons export


-include shared.mk
-include icons.mk


example: example-template.html *.rb icons example-slides example-html example-multimake

example-html:
	ruby Generate.rb --output example.html --template example.template --require ./Example.rb --class Examples --parameter x=1 -P y=2

example-multimake: multimake-example.rb
	ruby multimake-example.rb

example-slides: slides-example.tex
	$(LATEX) slides-example.tex
	$(IMAGEMAGICK) -quality 90 -density 300 -trim -shave 3x3 slides-example.pdf slides-example-%d.png

clean_example:
	rm -f slides-example-?.png slides-example.aux

clean: clean_icons clean_example
	rm -f *~

variables-html:
	ruby Generate.rb --output variables.html --template variables.template --require ./variables.rb --class Variables -p 2

zip:
	$(ZIP) $(PACKAGE).zip $(PACKAGE_CONTENTS)
