.SECONDEXPANSION:

.PHONY: example example-html example-multimake

-include shared.mk
-include icons.mk

all: icons export

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

export:
	echo *.css *.png assignment.html *.js | ruby -e "puts STDIN.read.split" > export

variables-html:
	ruby Generate.rb --output variables.html --template variables.template --require ./variables.rb --class Variables -p 2
