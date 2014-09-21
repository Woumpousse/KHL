.SECONDEXPANSION:

.PHONY: current


all: icons current

-include $(KHL_ROOT)/shared.mk
-include icons.mk




clean: clean_icons
	rm -f *~

zip:
	$(ZIP) $(PACKAGE).zip $(PACKAGE_CONTENTS)

export:

%.pdf: %.tex
	$(LATEX) $<

%.png: %.pdf
	$(IMAGEMAGICK) -quality 90 -density 300 $< $@


CURRENT = breuk

current: 
	ruby Generate.rb --output $(CURRENT).html --template $(CURRENT).template --require ./$(CURRENT).rb --class Resources -p 2
