.SECONDEXPANSION:

.PHONY: fundamentals-html


all: icons fundamentals-html


-include shared.mk
-include icons.mk


clean: clean_icons
	rm -f *~

fundamentals-html:
	ruby Generate.rb --output fundamentals.html --template fundamentals.template --require ./fundamentals.rb --class Fundamentals -p 2
