.SECONDEXPANSION:

-include shared.mk
-include icons.mk

all: icons export

example: example-template.html *.rb icons
	$(LATEX) slides-example.tex
	$(IMAGEMAGICK) -quality 90 -density 300 -trim -shave 3x3 slides-example.pdf slides-example-%d.png
	ruby Generate.rb --output example.html --template example-template.html --exercises ./Example.rb

clean_example:
	rm -f slides-example-?.png slides-example.aux

clean: clean_icons clean_example

export:
	echo *.css *.png assignment.html *.js | ruby -e "puts STDIN.read.split" > export
