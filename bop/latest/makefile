.SECONDEXPANSION:

-include shared.mk
-include icons.mk

all: icons export

example: example-template.html *.rb icons example-slides example-html

example-html:
	ruby Generate.rb --output example.html --template example-template.html --exercises ./Example.rb

example-slides: slides-example.tex
	$(LATEX) slides-example.tex
	$(IMAGEMAGICK) -quality 90 -density 300 -trim -shave 3x3 slides-example.pdf slides-example-%d.png

clean_example:
	rm -f slides-example-?.png slides-example.aux

clean: clean_icons clean_example
	rm -f *~

export:
	echo *.css *.png assignment.html *.js | ruby -e "puts STDIN.read.split" > export

primitive-types:
	ruby Generate.rb --output primitive-types.html --template primitive-types-template.html --exercises ./primitive-types.rb
