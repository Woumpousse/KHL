.SECONDEXPANSION:

CURRENT = getters-setters

.PHONY:

all: icons export $(CURRENT)

-include shared.mk
-include icons.mk

clean: clean_icons
	rm -f *~ *.html *.pdf *.png *.aux

export:
	echo *.css *.png *.html *.js | ruby -e "puts STDIN.read.split" > export

$(CURRENT):
	ruby $(CURRENT).rb
