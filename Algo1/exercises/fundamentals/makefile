.SECONDEXPANSION:

.PHONY: fundamentals-html export


all: icons fundamentals-html export


-include shared.mk
-include icons.mk


clean: clean_icons
	rm -f *~

fundamentals-html:
	ruby Generate.rb --output fundamentals.html --template fundamentals.template --require ./fundamentals.rb --class Fundamentals -p 2

export:
	echo fundamentals.html *.js *.png *.css | ruby -e "puts STDIN.read.split" > export
