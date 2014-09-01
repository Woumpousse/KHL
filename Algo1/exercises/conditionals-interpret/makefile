.SECONDEXPANSION:

.PHONY: html export images


all: icons html images export


-include shared.mk
-include icons.mk


clean: clean_icons
	rm -f *~ *.pdf *.png *.aux *.log

%.pdf: %.tex
	$(LATEX) $<

%.png: %.pdf
	$(IMAGEMAGICK) -quality 90 -density 300 -trim $< $@

images: ex3.png ex4.png

html:
	ruby Generate.rb --output conditionals.html --template conditionals.template --require ./conditionals.rb --class Conditionals -p 2

export:
	echo conditionals.html *.js *.png *.css | ruby -e "puts STDIN.read.split" > export
