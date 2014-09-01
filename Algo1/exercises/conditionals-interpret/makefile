.SECONDEXPANSION:

.PHONY: conditionals-html export


all: icons conditionals-html export


-include shared.mk
-include icons.mk


clean: clean_icons
	rm -f *~

conditionals-html:
	ruby Generate.rb --output conditionals.html --template conditionals.template --require ./conditionals.rb --class Conditionals -p 2

export:
	echo conditionals.html *.js *.png *.css | ruby -e "puts STDIN.read.split" > export
