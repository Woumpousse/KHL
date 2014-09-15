.SECONDEXPANSION:

.PHONY: example example-html example-multimake

all: icons export primitive-types

-include shared.mk
-include icons.mk

clean: clean_icons
	rm -f *~ *.html *.pdf *.png *.aux

export:
	echo *.css *.png *.html *.js | ruby -e "puts STDIN.read.split" > export

primitive-types:
	ruby primitive-types.rb
